#!/usr/bin/env python3
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
patterns_author = re.compile(r'^\s*:(?:author|撰写):\s*(.*)$', re.I)
patterns_date = re.compile(r'^\s*:(?:date|最近更新日期):\s*(.*)$', re.I)
pattern_alt_author = re.compile(r'^\s*:(?:author|撰写):')

changed = []

for path in ROOT.glob('source/**'):
    if path.is_file() and path.suffix in ('.md', '.rst'):
        text = path.read_text(encoding='utf-8')
        lines = text.splitlines()
        # find all author/date lines
        authors = []
        dates = []
        new_lines = []
        for ln in lines:
            m = patterns_author.match(ln)
            if m:
                names = m.group(1).strip()
                # remove wrappers like {{ }} or | |
                names = re.sub(r"\{\{\s*|\s*\}\}", '', names)
                names = re.sub(r"\|", '', names)
                names = names.replace('，', ',')
                names = ', '.join([n.strip() for n in names.split(',') if n.strip()])
                if names:
                    authors.append(names)
                continue
            m2 = patterns_date.match(ln)
            if m2:
                dates.append(m2.group(1).strip())
                continue
            # also catch Chinese key variants like ':最近更新日期:' or ':撰写:' handled by patterns
            new_lines.append(ln)
        if not authors and not dates:
            continue
        # prepare header
        author_line = None
        date_line = None
        if authors:
            # take the first occurrence
            author_line = f":author: {authors[0]}"
        if dates:
            date_line = f":date: {dates[0]}"
        # check if file already starts with author/date
        starts_with_meta = False
        if lines:
            if patterns_author.match(lines[0]) or patterns_date.match(lines[0]):
                starts_with_meta = True
        # compose new content
        if path.suffix == '.md':
            header = []
            if author_line:
                header.append(author_line)
            if date_line:
                header.append(date_line)
            header.append('')
            header.append('---')
            header.append('')
            new_text = '\n'.join(header + [l for l in new_lines if l is not None])
        else:  # .rst
            header = []
            if author_line:
                header.append(author_line)
            if date_line:
                header.append(date_line)
            header.append('')
            header.append('----')
            header.append('')
            new_text = '\n'.join(header + [l for l in new_lines if l is not None])
        # If nothing changed, skip
        if text.strip() == new_text.strip():
            continue
        path.write_text(new_text, encoding='utf-8')
        changed.append(str(path.relative_to(ROOT)))

print('Modified files:')
for p in changed:
    print(p)
print(f"Total modified: {len(changed)}")
