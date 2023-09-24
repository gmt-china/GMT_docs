from sphinx.domains import Domain
from . import directive


class DataTemplateDomain(Domain):

    name = 'datatemplate'
    label = 'DataTemplate Replacement'
    directives = {
        'nodata': directive.DataTemplateNoData,
        'json': directive.DataTemplateJSON,
        'yaml': directive.DataTemplateYAML,
        'csv': directive.DataTemplateCSV,
        'xml': directive.DataTemplateXML,
        'dbm': directive.DataTemplateDBM,
        'import-module': directive.DataTemplateImportModule,
    }

    def get_objects(self):
        return []

    def resolve_xref(self, env, fromdocname, builder, typ, target, node,
                     contnode):
        return None

    def resolve_any_xref(self, env, fromdocname, builder, target, node,
                         contnode):
        return []

    def merge_domaindata(self, docnames, otherdata):
        pass
