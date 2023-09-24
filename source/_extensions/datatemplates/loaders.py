import contextlib
import csv
import dbm
import defusedxml.ElementTree as ET
import importlib
import json
import mimetypes
import pathlib
import yaml

registered_loaders = []


class LoaderEntry:
    def __init__(self, loader, name, match_source):
        self.loader = loader
        self.name = name
        self.match_source = match_source


def loader_for_source(source, default=None):
    "Return the loader for the named source."
    for e in registered_loaders:
        if e.match_source is not None and e.match_source(source):
            return e.loader
    return default


def loader_by_name(name, default=None):
    "Return the loader registered with the given name."
    for e in registered_loaders:
        if e.match_source is not None and e.name == name:
            return e.loader
    return default


def mimetype_loader(name, mimetype):
    "A data loader for the exact mimetype."
    def check_mimetype(source):
        guess = mimetypes.guess_type(source)[0]
        if not guess:
            return False
        return guess == mimetype
    return data_source_loader(name, check_mimetype)


def lenient_mimetype_loader(name, mimetype_fragment):
    "A data loader for a mimetype containing the given substring."
    def check_mimetype(source):
        guess = mimetypes.guess_type(source)[0]
        if not guess:
            return False
        return mimetype_fragment in guess
    return data_source_loader(name, check_mimetype)


def file_extension_loader(name, extensions):
    "A data loader for filenames ending with one of the given extensions."
    def check_ext(filename):
        return pathlib.Path(filename).suffix.lower() in set(
            e.lower() for e in extensions)
    return data_source_loader(name, check_ext)


def data_source_loader(name, match_source=None):
    """Add a named loader

    Add a named data loader with an optional function for matching to
    source names.

    """
    def wrap(loader_func):
        registered_loaders.append(LoaderEntry(loader_func, name, match_source))
        return loader_func

    return wrap


@data_source_loader("nodata")
@contextlib.contextmanager
def load_nodata(source, **options):
    yield None


@file_extension_loader("csv", [".csv"])
@contextlib.contextmanager
def load_csv(source,
             absolute_resolved_path,
             headers=False,
             dialect=None,
             encoding='utf-8-sig',
             **options):
    with open(absolute_resolved_path, 'r', newline='', encoding=encoding) as f:
        if dialect == "auto":
            sample = f.read(8192)
            f.seek(0)
            sniffer = csv.Sniffer()
            dialect = sniffer.sniff(sample)
        if headers:
            if dialect is None:
                r = csv.DictReader(f)
            else:
                r = csv.DictReader(f, dialect=dialect)
        else:
            if dialect is None:
                r = csv.reader(f)
            else:
                r = csv.reader(f, dialect=dialect)
        yield list(r)


@mimetype_loader("json", "application/json")
@contextlib.contextmanager
def load_json(source, absolute_resolved_path, encoding='utf-8-sig', **options):
    with open(absolute_resolved_path, 'r', encoding=encoding) as f:
        yield json.load(f)


@file_extension_loader("yaml", ['.yml', '.yaml'])
@contextlib.contextmanager
def load_yaml(source,
              absolute_resolved_path,
              encoding='utf-8-sig',
              multiple_documents=False,
              **options):
    with open(absolute_resolved_path, 'r', encoding=encoding) as f:
        if multiple_documents:
            yield list(
                yaml.safe_load_all(f)
            )  # force loading all documents now so the file can be closed
        else:
            yield yaml.safe_load(f)


@lenient_mimetype_loader('xml', 'xml')
@contextlib.contextmanager
def load_xml(source, absolute_resolved_path, **options):
    yield ET.parse(absolute_resolved_path).getroot()


@file_extension_loader("dbm", ['.dbm'])
def load_dbm(source, absolute_resolved_path, **options):
    return dbm.open(absolute_resolved_path, "r")


@data_source_loader("import-module")
@contextlib.contextmanager
def load_import_module(source, **options):
    yield importlib.import_module(source)
