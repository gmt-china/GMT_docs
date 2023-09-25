from sphinx.jinja2glue import BuiltinTemplateLoader

import hashlib

def _filemd5(file):
    with open(file, 'r') as fp:
        data = fp.read()
        return hashlib.md5(data.encode()).hexdigest()

class MyTemplateBridge(BuiltinTemplateLoader):
    def init(self, builder, template_name):
        super().init(builder, template_name)
        self.environment.filters['filemd5'] = _filemd5

