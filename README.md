# float-terminal.nvim

中文
一个极致简约、受 [TJ DeVries](https://www.youtube.com/watch?v=5PIiKDES_wc) 启发的 Neovim 浮动终端插件。

## ✨ 特性

- 一键切换：快速呼出/隐藏浮动终端。
- UI 同步：自动获取你当前主题中 Telescope 的边框颜色和背景样式。
- 自适应居中：无论如何调整 Neovim 窗口大小，终端始终保持居中。
- 自动模式切换：进入窗口时自动开启插入模式，退出即回。
- 轻量化：仅使用原生 Lua API，无任何冗余依赖。

## 📦 安装

使用 [lazy.nvim](https://github.com/folke/lazy.nvim)

```Lua
return {
'sidney-zhu/float-terminal.nvim',
config = function()
require('float-terminal').setup()
end,
}
```

## ⚙️ 默认快捷键

| 动作          | 快捷键       |
| ------------- | ------------ |
| 打开/隐藏终端 | `<leader>tt` |
| 退出插入模式  | `<Esc><Esc>` |

## 🎨 主题关联

本插件会自动链接以下高亮组以保持视觉一致性：

- `Normal` -> `TelescopeResultsNormal`
- `FloatBorder` -> `TelescopeResultsBorder`

## 📜 许可证

MIT

English

A minimalist floating terminal plugin for Neovim, inspired by TJ DeVries and designed to sync seamlessly with Telescope's UI.

## ✨ Features

- **Toggle with Ease**: Quickly show or hide the floating terminal with a single keybind.
- **UI Sync**: Automatically inherits border colors and background styles from Telescope.
- **Adaptive Centering**: Stays perfectly centered regardless of Neovim window resizing.
- **Auto Mode Switching**: Automatically enters Insert mode upon entry and reverts on exit.
- **Ultra-lightweight**: Built with pure Lua API, zero external dependencies.

## 📦 Installation

With lazy.nvim:

```Lua
return {
'sidney-zhu/float-terminal.nvim',
config = function()
require('float-terminal').setup()
end,
}
```

## ⚙️ Default Keybindings

| Action           | Keybinding   |
| ---------------- | ------------ |
| Toggle Terminal  | `<leader>tt` |
| Exit Insert Mode | `<Esc><Esc>` |

## 🎨 Highlight Linking

The plugin dynamically links the following groups for visual consistency:

- `Normal` -> `TelescopeResultsNormal`
- `FloatBorder` -> `TelescopeResultsBorder`

## 📜 License

MIT
