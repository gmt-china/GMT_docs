# GMT 数据集

使用 GMT 绘图时，经常用到一些特定的地学数据，如国界线、地形起伏数据等。
这些数据一般不需要任何改动即可用在多种图件中。根据使用方法的不同，分为三类：

1. GMT 内置数据：GMT 官方整理的内置于 GMT 软件包中的数据
2. GMT 远程数据：GMT 官方整理的保存在远程 GMT 数据服务器中的数据
3. 自定义数据：用户自行准备的数据

```{rubric} GMT 内置数据
```

GMT 内置了如下数据，可以直接在 GMT 中使用：

- {doc}`gshhg`
- {doc}`dcw/index`

```{rubric} GMT 远程数据
```

GMT 远程数据位于 GMT 数据服务器，在 GMT 中使用时会自动下载：

- {doc}`remote-dataset`

```{rubric} 自定义数据
```

GMT 内置数据和远程数据并不能满足所有用户的需求，用户可在 GMT 中使用自己的数据并创建数据库。
GMT 中文社区收集并整理了部分全球地学数据集 {doc}`dataset/index` 以及中国地理空间数据集
{doc}`dataset-CN/index`，以供用户使用。

```{toctree}
:hidden: true
:maxdepth: 1

gshhg
dcw/index
remote-dataset
```
