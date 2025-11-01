# 安装

这一章介绍如何安装 GMT。

不同的操作系统下，GMT 的安装方式不同。同一操作系统下，GMT 也有多种不同的安装方式。
用户可以根据需求选择适合的安装方式。

跨平台软件包管理器 **conda** 为 Linux、macOS 和 Windows 提供了 GMT 二进制包。

当你的 Linux 发行版没有提供 GMT 最新版本的二进制包，或者你想要使用 GMT 开发版源码，
你可以选择自行编译 GMT 源码。

::::{grid} 2
:::{grid-item-card}  Windows

|方法 | 难度系数 | 推荐系数 |
|---|---|---|
| [使用官方安装包](windows) | 1 |  4 |
| [使用 conda 安装](conda) | 3 | 5 |
| [编译源码](build-source-windows) | 5 | 1 |
:::

:::{grid-item-card} macOS
- [使用 Homebrew 安装](macOS)
- [使用 conda 安装](conda)
- [编译源码](build-source-unix)
:::

:::{grid-item-card}  Linux (Fedora)
- [使用 dnf 安装](fedora)
- [使用 conda 安装](conda)
- [编译源码](build-source-unix)
:::

:::{grid-item-card} Linux (Ubuntu/Debian)
- [使用 apt 安装](ubuntu-debian)
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
