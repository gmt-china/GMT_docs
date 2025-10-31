# 安装

这一章介绍如何安装 GMT。不同的操作系统下，GMT 的安装方式不同。同一操作系统下，
GMT 也有多种不同的安装方式。用户可以根据需求选择适合的安装方式。

跨平台软件包管理器 **conda** 为 Linux、macOS 和 Windows 提供了 GMT 二进制包。

当你的 Linux 发行版没有提供 GMT 最新版本的二进制包，或者你想要使用 GMT 开发版源码，
你可以选择自行编译 GMT 源码。

不同操作系统下，通过 GMT 安装包或软件包管理器安装 GMT：

::::{grid} 2
:::{grid-item-card}  Windows
- [使用 GMT 安装包](windows)
- [使用 conda 安装 GMT](conda)
- [编译 GMT 源码](build-source-windows)
:::

:::{grid-item-card} macOS
- [使用 Homebrew 安装](macOS)
- [使用 conda 安装 GMT](conda)
- [编译 GMT 源码](build-source-unix)
:::

:::{grid-item-card}  Linux (Fedora)
- [使用 Fedora 官方源安装 GMT](fedora)
- [使用 GMT 官方 RPM 仓库安装 GMT](fedora)
- [使用 conda 安装 GMT](conda)
- [编译 GMT 源码](build-source-unix)
:::

:::{grid-item-card} Linux (Ubuntu/Debian)
- [使用 Ubuntu/Debian 官方源安装 GMT](ubuntu-debian)
- [使用 conda 安装 GMT](conda)
- [编译 GMT 源码](build-source-unix)
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