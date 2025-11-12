#!/usr/bin/env python3
"""
Insert author and last modified date metadata into Markdown (.md) and reStructuredText (.rst) files.

See repository workflow in conversation: uses per-file git history (git log --follow) to gather authors,
exclude obvious bots, and write YAML front matter for .md or :author:/:date: fields for .rst.
Supports --force to overwrite existing author/date.
"""
from __future__ import annotations

import re
import subprocess
import sys
from pathlib import Path

RE_YAML_START = re.compile(r"^---\s*$")
RE_YAML_KEYVAL = re.compile(r"^([A-Za-z0-9_-]+):\s*(.*)$")

BOT_PATTERNS = [
    re.compile(r"bot\]?$", re.IGNORECASE),
    re.compile(r"dependabot", re.IGNORECASE),
]


def run(cmd: list[str], cwd: Path | None = None) -> str:
    out = subprocess.run(cmd, cwd=cwd, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
    if out.returncode != 0:
        raise RuntimeError(f"Command failed: {' '.join(cmd)}\n{out.stderr}")
    return out.stdout


def is_bot(name: str) -> bool:
    return any(p.search(name) for p in BOT_PATTERNS)


def git_authors(file: Path) -> list[str]:
    authors_count: dict[str, int] = {}
    # try with --follow first, then without
    for follow in (True, False):
        args = ["git", "log"]
        if follow:
            args.append("--follow")
        args += ["--format=%an", "--", str(file)]
        try:
            out = run(args)
        except RuntimeError:
            continue
        for line in out.splitlines():
            name = line.strip()
            if not name or is_bot(name):
                continue
            authors_count[name] = authors_count.get(name, 0) + 1
        if authors_count:
            break
    authors_sorted = sorted(authors_count.items(), key=lambda kv: (-kv[1], kv[0]))
    return [a for a, _ in authors_sorted]


def git_last_date(file: Path) -> str | None:
    for args in (["--follow"], []):
        try:
            out = run(["git", "log", *args, "-1", "--format=%cs", "--", str(file)])
            date = out.strip()
            if date:
                return date
        except RuntimeError:
            continue
    return None


def has_yaml_front_matter(lines: list[str]) -> bool:
    return len(lines) >= 1 and RE_YAML_START.match(lines[0]) is not None


def parse_yaml_block(lines: list[str]) -> tuple[dict[str, str], int]:
    data: dict[str, str] = {}
    i = 0
    if not has_yaml_front_matter(lines):
        return data, -1
    i += 1
    while i < len(lines):
        if RE_YAML_START.match(lines[i]):
            return data, i
        m = RE_YAML_KEYVAL.match(lines[i])
        if m:
            key, val = m.group(1), m.group(2)
            data[key] = val
        i += 1
    return {}, -1


def update_markdown(file: Path, force: bool = False) -> bool:
    text = file.read_text(encoding="utf-8")
    if text.startswith("\ufeff"):
        text = text.lstrip("\ufeff")
    lines = text.splitlines(keepends=True)
    updated = False

    authors = git_authors(file)
    date = git_last_date(file)

    if has_yaml_front_matter(lines):
        data, end_idx = parse_yaml_block(lines)
        if end_idx >= 0:
            insert_pos = end_idx
            if force:
                block_range = range(1, end_idx)
                new_block = []
                for i in block_range:
                    m = RE_YAML_KEYVAL.match(lines[i])
                    if m and m.group(1) in ("author", "date"):
                        continue
                    new_block.append(lines[i])
                if authors:
                    new_block.append(f"author: {', '.join(authors)}\n")
                if date:
                    new_block.append(f"date: {date}\n")
                lines[1:end_idx] = new_block
                updated = True
            else:
                inserts: list[str] = []
                if "author" not in data and authors:
                    inserts.append(f"author: {', '.join(authors)}\n")
                if "date" not in data and date:
                    inserts.append(f"date: {date}\n")
                if inserts:
                    lines[insert_pos:insert_pos] = inserts
                    updated = True
    else:
        header: list[str] = ["---\n"]
        if authors:
            header.append(f"author: {', '.join(authors)}\n")
        if date:
            header.append(f"date: {date}\n")
        header.append("---\n\n")
        lines = header + lines
        updated = True

    if updated:
        file.write_text("".join(lines), encoding="utf-8")
    return updated


def update_rst(file: Path, force: bool = False) -> bool:
    text = file.read_text(encoding="utf-8")
    if text.startswith("\ufeff"):
        text = text.lstrip("\ufeff")
    lines = text.splitlines(keepends=True)

    authors = git_authors(file)
    date = git_last_date(file)

    has_author_idx = next((i for i, l in enumerate(lines[:10]) if l.startswith(":author:")), None)
    has_date_idx = next((i for i, l in enumerate(lines[:10]) if l.startswith(":date:")), None)

    if force:
        new_top: list[str] = []
        for i, l in enumerate(lines):
            if i in (has_author_idx, has_date_idx):
                continue
            new_top.append(l)
        lines = new_top
        insertion: list[str] = []
        if authors:
            insertion.append(f":author: {', '.join(authors)}\n")
        if date:
            insertion.append(f":date: {date}\n")
        lines = insertion + lines
        file.write_text("".join(lines), encoding="utf-8")
        return True
    else:
        inserts: list[str] = []
        if has_author_idx is None and authors:
            inserts.append(f":author: {', '.join(authors)}\n")
        if has_date_idx is None and date:
            inserts.append(f":date: {date}\n")
        if not inserts:
            return False
        lines = inserts + lines
        file.write_text("".join(lines), encoding="utf-8")
        return True


def main(paths: list[str]) -> int:
    if not paths:
        print("Usage: add_author_date.py [--force] <file1> <file2> ...", file=sys.stderr)
        return 2
    force = False
    target_files: list[str] = []
    for p in paths:
        if p == "--force":
            force = True
            continue
        target_files.append(p)
    changed = 0
    for p in target_files:
        file = Path(p)
        if not file.exists():
            print(f"Skip (not found): {file}")
            continue
        if file.suffix == ".md":
            did = update_markdown(file, force=force)
        elif file.suffix == ".rst":
            did = update_rst(file, force=force)
        else:
            print(f"Skip (unsupported extension): {file}")
            continue
        if did:
            print(f"Updated: {file}")
            changed += 1
        else:
            print(f"No change: {file}")
    return 0 if changed >= 0 else 1


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
