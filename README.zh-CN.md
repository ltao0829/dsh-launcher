# dsh-launcher

**DeepSeek Harness Web 一键启动器 —— 面向 AI 编程代理工作流工具集的一部分。**

[![CI](https://github.com/ltao0829/dsh-launcher/actions/workflows/ci.yml/badge.svg)](https://github.com/ltao0829/dsh-launcher/actions/workflows/ci.yml)
[![License: BSD-3-Clause](https://img.shields.io/badge/License-BSD--3--Clause-blue.svg)](./LICENSE)

双击即可启动 DeepSeek Harness（DSH）Web 并自动打开浏览器。`dsh-launcher` 会自动定位你的 `dsh` 安装，无需配置路径、无需记忆命令。

> 属于 `@ltao0829` AI 编程代理工具集，与 [dsh-task-notify](https://github.com/ltao0829/dsh-task-notify)（编程代理的生命周期通知层）并列。

## 为什么需要它

DSH Web 通常需要从终端启动。日常使用时，双击式启动器消除了这些摩擦：自动找到正确的 `dsh`、启动服务、等待端口就绪、打开浏览器；如果服务已在运行，则直接打开浏览器而不重复启动。

## 用法

- 双击 `start-harness.bat`，默认端口 `3080`，自动打开浏览器
- 命令行指定端口：`start-harness.bat 8080`
- 关闭弹出的 "DSH Web Server" 窗口即停止服务

## 工作原理

脚本按以下顺序自动定位 `dsh` 命令：

1. PATH 中的 `dsh.cmd`（全局安装）
2. `%APPDATA%\npm\dsh.cmd`（npm 默认全局前缀）
3. 任意 npx 缓存目录 `%LOCALAPPDATA%\npm-cache\_npx\*\node_modules\.bin\dsh.cmd`
4. `%USERPROFILE%\.npm-global\bin\dsh.cmd`
5. 兜底使用 `npx`（首次运行自动联网安装 dsh）

若端口已在监听，脚本会直接打开浏览器而不重复启动。

## 环境要求

- Windows
- Node.js（含 npm/npx）：<https://nodejs.org>
- 可选：全局安装 DeepSeek Harness —— `npm install -g @deepseek-ai/dsh`

## 开发

```sh
node scripts/check-launcher.cjs
```

校验包元数据、文档与批处理脚本（含 CRLF 行尾）。

## 路线图

- [x] 一键启动 + 自动定位 `dsh`
- [x] 端口检测与复用
- [ ] 跨平台启动器（macOS / Linux）
- [ ] 桌面快捷方式安装器

## 相关项目

- [dsh-task-notify](https://github.com/ltao0829/dsh-task-notify) —— AI 编程代理的生命周期通知层（DeepSeek Harness 插件）。

## License

[BSD-3-Clause](./LICENSE)
