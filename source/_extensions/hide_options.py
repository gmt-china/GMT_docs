# 编写一个简单的自定义转换器 (Transform)，自动遍历所有文档，找到所有的 option 节点。
# 自动给所有的 option 创建一个新的容器包裹它，给容器添加隐藏类 hidden-opt。通过 LaTeX 统一隐藏这些标记。
from docutils import nodes
from sphinx import addnodes
from sphinx.transforms import SphinxTransform

class AutoHideOption(SphinxTransform):
    # 在解析完成后、写入文件前运行
    default_priority = 800

    def apply(self):
        # 找到所有的 option 指令生成的节点
        # 使用 list(traverse) 避免在遍历时修改树结构导致的问题
        for node in list(self.document.traverse(addnodes.desc)):
            # 检查是否为 option 类型的描述列表
            if node.get('objtype') == 'option':
                # 1. 创建一个容器节点
                wrapper = nodes.container()
                # 2. 给容器添加隐藏类
                wrapper['classes'].append('hidden-opt')
                
                # 3. 将原节点包装起来
                # 注意：这里需要先找到父节点进行替换
                # 执行替换：将原本的 node 放入 wrapper
                parent = node.parent
                if parent:
                    node.replace_self(wrapper)
                    wrapper.append(node)

def setup(app):
    app.add_transform(AutoHideOption)
    
    # 必须返回 metadata 字典，以支持并行编译 (Parallel Read/Write)
    return {
        'version': '0.1',
        'parallel_read_safe': True,
        'parallel_write_safe': True,
    }