# 安装

这一章介绍 GMT 的安装。不同操作系统下，GMT 的安装方式不同。同一操作系统下，
GMT 也有多种不同的安装方式，但基本可以分为三种：

1. 使用包管理器 `conda` 或 `Homebrew` 安装 [**推荐**]
2. 使用官方安装包或系统软件包管理器安装 [**有缺点**]
3. 直接编译 GMT 源码 [**最复杂，仅推荐有特殊需求的用户使用**]

Windows 系统的官方安装包存在无法正常使用高精度远程地形数据的 bug，而 Linux 系统的软件包管理器 apt 和 dnf 可能只能安装老版本的 GMT。

用户在知悉上述不同安装方式的优缺点后，可以结合自身需求选择合适的安装方式。

::::{grid} 4

:::{grid-item-card} Windows
- [使用 conda 安装](conda)
- [使用官方安装包](windows)
- [编译源码](build-source-windows)
:::

:::{grid-item-card} macOS
- [使用 Homebrew 安装](macOS)
- [使用 conda 安装](conda)
- [编译源码](build-source-unix)
:::

:::{grid-item-card} Linux (Ubuntu/Debian)
- [使用 conda 安装](conda)
- [使用 apt 安装](ubuntu-debian)
- [编译源码](build-source-unix)
:::

:::{grid-item-card} Linux (Fedora)
- [使用 conda 安装](conda)
- [使用 dnf 安装](fedora)
- [编译源码](build-source-unix)
:::
::::

```{toctree}
:maxdepth: 1
:hidden:

conda
windows
macOS
fedora
ubuntu-debian
build-source-unix
build-source-windows
```
