# 一個指令快速部署 Vue Cli 到 GitHub Pages

這一篇主要是針對我寫的文章而放置的 sh，該 sh 最主要的用途在於方便使用 Vue Cli 一鍵部署到 GitHub Pages。

## 原文

[一個指令快速部署 Vue Cli 到 GitHub Pages](https://hsiangfeng.github.io/vue/20200214/1055437216/)

底下是我美化過的指令，最主要是方便辨識執行流程，但是這邊還增加了一些功能

- 自動建立 vue.confing.js
  - publicPath 只會寫入「`./`」
- 辨識作業系統（目前主要是 Mac 與 Window）
- 自動編譯 build Vue Cli
- 自動取得當前專案的 GitHub 遠端路徑並加入版本控制
- 自動部署 Vue Cli 到 GitHub Pages
- ~~美美的終端機提示~~
