from __future__ import print_function

import argparse
import io
import os.path
import pprint

import jinja2

from sphinxcontrib.datatemplates import helpers
from sphinxcontrib.datatemplates import loaders


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument(
        '--config-file',
        help='the path to conf.py',
    )
    subparsers = parser.add_subparsers(
        title='commands',
        description='valid commands',
        dest='command',
    )

    do_render = subparsers.add_parser(
        'render',
        help='render a template to stdout',
    )
    do_render.add_argument(
        '--option',
        '-o',
        action='append',
        default=[],
        help='options given as key:value passed through to loader and template'
    )
    do_render.add_argument(
        'template',
        help='the path to the template file',
    )
    do_render.add_argument(
        'source',
        help='the path to the data file',
    )
    do_render.set_defaults(func=render)

    do_dump = subparsers.add_parser(
        'dump',
        help='dump the data to stdout without a template',
    )
    do_dump.add_argument(
        '--option',
        '-o',
        action='append',
        default=[],
        help='options given as key:value passed through to loader and template'
    )
    do_dump.add_argument(
        'source',
        help='the path to the data file',
    )
    do_dump.set_defaults(func=dump)

    args = parser.parse_args()
    # no arguments, print help messaging, then exit with error(1)
    if not args.command:
        parser.print_help()
        return 1

    conf = {}
    if args.config_file:
        with io.open(args.config_file, 'r', encoding='utf-8-sig') as f:
            config_body = f.read()
        exec(config_body, conf)

    return args.func(args, conf)


def _parse_options(options):
    # Process the sequence of options. If there is a colon, use it to
    # separate the option name from its value. If there is no colon,
    # treat the option as a flag.
    results = {}
    for opt in options:
        if ':' in opt:
            k, _, v = opt.partition(':')
        else:
            k = opt
            v = True
        results[k.replace('-', '_')] = v
    return results


def render(args, conf):
    conf.update(_parse_options(args.option))
    conf.update({
        "source": args.source,
        "template": args.template,
        "absolute_resolved_path": os.path.abspath(args.source)
    })

    load = loaders.loader_for_source(args.source)
    if load is None:
        print('Could not find loader for {}'.format(args.source))
        return 1

    with io.open(args.template, 'r', encoding='utf-8-sig') as f:
        template_body = f.read()

    template = jinja2.Template(template_body)
    with load(**conf) as data:
        rendered = template.render(
            make_list_table=helpers.make_list_table,
            make_list_table_from_mappings=helpers.
            make_list_table_from_mappings,
            data=data,
            **conf
        )
    print(rendered)


def dump(args, conf):
    conf.update(_parse_options(args.option))
    conf.update({
        "source": args.source,
        "absolute_resolved_path": os.path.abspath(args.source)
    })

    load = loaders.loader_for_source(args.source)
    if load is None:
        print('Could not find loader for {}'.format(args.source))
        return 1

    with load(**conf) as data:
        pprint.pprint(data)


if __name__ == '__main__':
    main()
