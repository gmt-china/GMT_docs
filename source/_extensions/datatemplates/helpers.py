def make_list_table(headers, data, title='', columns=None):
    """Build a list-table directive.

    :param headers: List of header values.
    :param data: Iterable of row data, yielding lists or tuples with rows.
    :param title: Optional text to show as the table title.
    :param columns: Optional widths for the columns.
    """
    results = []
    add = results.append
    add('.. list-table:: %s' % title)
    add('   :header-rows: 1')
    if columns:
        add('   :widths: %s' % (','.join(str(c) for c in columns)))
    add('')
    add('   - * %s' % headers[0])
    for h in headers[1:]:
        add('     * %s' % h)
    for row in data:
        add('   - * %s' % row[0])
        for r in row[1:]:
            add('     * %s' % r)
    add('')
    return '\n'.join(results)


def make_list_table_from_mappings(headers, data, title, columns=None):
    """Build a list-table directive.

    :param headers: List of tuples containing header title and key value.
    :param data: Iterable of row data, yielding mappings with rows.
    :param title: Optional text to show as the table title.
    :param columns: Optional widths for the columns.
    """
    header_names = [h[0] for h in headers]
    header_keys = [h[1] for h in headers]
    row_data = ([d.get(k) for k in header_keys] for d in data)
    return make_list_table(header_names, row_data, title, columns)


def escape_rst(s):
    """Escape string for inclusion in RST documents.

    See
    https://docutils.sourceforge.io/docs/ref/rst/restructuredtext.html#escaping-mechanism

    :param s: String for escaping
    """
    return "".join(c if c.isspace() else "\\" + c for c in s)


def escape_rst_url(s):
    """Escape string for inclusion in URLs in RST documents.

    See
    https://docutils.sourceforge.io/docs/ref/rst/restructuredtext.html#escaping-mechanism

    :param s: String for escaping
    """
    return "\\".join(s)
