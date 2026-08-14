# dsh-launcher

DeepSeek Harness（DSH）Web 界面的一键启动脚本：双击即可启动 `dsh web` 并自动打开浏览器。

## 用法

- 双击 `start-harness.bat`，默认端口 `3080`
- 命令行指定端口：`start-harness.bat 8080`
- 关闭弹出的 "DSH Web Server" 窗口即停止服务

## 工作原理

脚本按以下顺序自动定位 `dsh` 命令（无需手动配置路径）：

1. PATH 中的 `dsh.cmd`（全局安装）
2. `%APPDATA%\npm\dsh.cmd`（npm 默认全局前缀）
3. 任意 npx 缓存目录 `%LOCALAPPDATA%\npm-cache\_npx\*\node_modules\.bin\dsh.cmd`
4. `%USERPROFILE%\.npm-global\bin\dsh.cmd`
5. 兜底使用 `npx`（首次运行会自动联网安装 dsh）

若端口已在监听，脚本会直接打开浏览器而不重复启动。

## 环境要求

- Windows
- Node.js（含 npm/npx）：<https://nodejs.org>
- 可选：全局安装 DeepSeek Harness —— `npm install -g @deepseek-ai/dsh`

## 说明

- 脚本只负责「启动服务 + 打开浏览器」；DSH 的插件（如 web-ui 全家桶）需要在各自电脑上另行配置 profile。
- 已在 Windows 上验证通过。
