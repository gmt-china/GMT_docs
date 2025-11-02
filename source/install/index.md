# 安装

这一章介绍 GMT 的安装。不同操作系统下，GMT 的安装方式不同。同一操作系统下，
GMT 也有多种不同的安装方式，但基本可以分为三种：

1. 使用官方安装包或系统软件包管理器安装 [**简单**]
2. 使用跨平台的包管理器 `conda` 安装 [**稍复杂**]
3. 直接编译 GMT 源码 [**最复杂，仅推荐有特殊需求的用户使用**]

用户可以结合自身需求选择合适的安装方式。

::::{grid} 4

:::{grid-item-card} Windows
- [使用官方安装包](windows)
- [使用 conda 安装](conda)
- [编译源码](build-source-windows)
:::

:::{grid-item-card} macOS
- [使用 Homebrew 安装](macOS)
- [使用 conda 安装](conda)
- [编译源码](build-source-unix)
:::

:::{grid-item-card} Linux (Ubuntu/Debian)
- [使用 apt 安装](ubuntu-debian)
- [使用 conda 安装](conda)
- [编译源码](build-source-unix)
:::

:::{grid-item-card} Linux (Fedora)
- [使用 dnf 安装](fedora)
- [使用 conda 安装](conda)
- [编译源码](build-source-unix)
:::
::::

```{toctree}
:maxdepth: 1
:hidden:

windows
macOS
fedora
ubuntu-debian
conda
build-source-unix
build-source-windows
```
