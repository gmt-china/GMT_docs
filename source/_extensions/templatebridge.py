"""
Add custom filters to the Jinja2 environment.
"""
import hashlib

from sphinx.jinja2glue import BuiltinTemplateLoader


def _filemd5(file):
    """
    Return the MD5 hash of the file contents.
    """
    with open(file, "r") as fp:
        data = fp.read()
        return hashlib.md5(data.encode()).hexdigest()


class MyTemplateBridge(BuiltinTemplateLoader):
    """
    Inherit from the default template bridge and add custom filters.
    """
    # 设为 None 是为了兼容可能不传参的情况
    def init(self, builder, theme=None):
        super().init(builder, theme)
        # Add custom filters
        self.environment.filters["filemd5"] = _filemd5
