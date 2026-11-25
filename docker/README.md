# Docker 入门教程 · 六个动手实验

一套中文 Docker 入门教程，A4 排版 PDF，共 7 份 48 页。

不先灌一堆概念再让你动手，而是**每讲一个概念，立刻用一个能跑起来的小实验验证它**。
主册负责把概念和命令讲清楚，六个分册各是一个 10–40 分钟、可以独立完成的实验——
每份都自带目标、步骤、预期输出、验证清单和排错表，可以单独打印出来对着做。

做完这一套，你应该能把自己的一个脚本装进容器，并在任何一台装了 Docker 的机器上一条命令跑起来。

---

## 内容

| 编号 | 页 | 讲什么 | 做完你会得到 |
| :--- | ---: | :--- | :--- |
| [主册](<Docker%20入门教程.pdf>) | 11 | 为什么用容器、四个核心概念、与虚拟机的区别、安装、命令速查、十个常见的坑 | 一张完整的概念地图 + 速查表 |
| [01 第一个容器](实验01_第一个容器.pdf) | 5 | `run` / `-d` / `-p` / `--name` | 本机 8080 端口上的一个网页 |
| [02 生命周期](实验02_容器的生命周期.pdf) | 6 | 可写层、`exec`、stop 与 rm 的区别、退出码 | 一个能自由进出的 ubuntu 容器 |
| [03 造镜像](实验03_写Dockerfile造镜像.pdf) | 6 | `FROM` / `COPY` / `CMD`、层与构建缓存、`.dockerignore` | 一个自己的镜像，改代码 1 秒重建 |
| [04 持久化](实验04_数据持久化.pdf) | 6 | volume、bind mount、`:ro`、卷的生命周期 | 删掉容器数据还在 |
| [05 Compose](实验05_Compose多容器编排.pdf) | 7 | compose 文件、服务名即主机名、`up` / `down` | 一条命令起 web + redis，页面上看到访问计数 |
| [06 分析环境](实验06_容器化Python分析环境.pdf) | 7 | 依赖分层缓存、结果回传、镜像瘦身、`save` / `load` | pandas + matplotlib 装进镜像，图自动落回本机 |

六个分册的文件名统一为 `实验0X_主题.pdf`，例如 `实验03_写Dockerfile造镜像.pdf`；完整清单见下方目录结构。

---

## 目录结构

```
docker/
├── Docker 入门教程.pdf          # 主册
├── 实验01_第一个容器.pdf
├── 实验02_容器的生命周期.pdf
├── 实验03_写Dockerfile造镜像.pdf
├── 实验04_数据持久化.pdf
├── 实验05_Compose多容器编排.pdf
├── 实验06_容器化Python分析环境.pdf
└── _src/                        # 全部 PDF 的源码，可重新生成
    ├── main.html                # 主册
    ├── exp01.html … exp06.html  # 六个分册
    ├── assets/style.css         # 统一排版样式
    ├── build.mjs                # 打印脚本
    └── package.json
```

---

## 怎么用

1. **先装环境。** Windows 装 Docker Desktop（依赖 WSL2）；Linux 用 `curl -fsSL https://get.docker.com | sudo sh`。
   细节和验证方法在主册第 4 章。
2. **读主册第 1–4 章。** 建立概念：镜像、容器、仓库、分层。大约 30 分钟。
3. **按 01 → 06 的顺序做实验。** 每个实验只引入一两个新概念，并且都复用上一个的成果，不要跳。
4. **卡住了查主册第 7 章**「十个最常见的坑」，以及每份分册末尾的排错表。

建议新建一个空目录（例如 `D:/docker-lab`）专门放这些实验，一个实验一个子目录，清理时直接删整个文件夹。

---

## 重新生成 PDF

修改 `_src/` 里的 HTML 或 CSS 后，重新导出全部 PDF：

```bash
cd _src
npm install          # 只装 puppeteer-core，约 25 个包
node build.mjs
```

生成的 PDF 会写回仓库根目录，文件名与原来一致。

**依赖：**

- Node.js 18+
- 本机装有 Chrome 或 Edge（脚本会自动探测常见路径；找不到时用环境变量指定）
  ```bash
  CHROME_PATH="/path/to/chrome" node build.mjs
  ```
- `puppeteer-core` 不含浏览器，所以不需要下载几百 MB 的 Chromium

---

## 技术实现

- **排版**：单文件 HTML + 一份共享 CSS（`_src/assets/style.css`），用 Chrome 打印成 A4，页脚带页码。
- **图示**：全部是内联 SVG（对比图、分层图、端口映射、状态机、挂载关系、compose 架构、阶梯路线），
  没有外部图片，离线可用，放大不失真。
- **分页控制**：每章另起一页；代码块和表格尽量不跨页（`page-break-inside: avoid`
  配合 `break-inside: avoid-page` 和 `orphans/widows`，否则 Chrome 会把 `<pre>` 切两半）。
- **字体**：正文用系统自带的微软雅黑 / 苹方，代码用 Consolas / Cascadia Mono，不嵌入字体文件。

---

## 一些说明

- **实验 06 里的数据是演示数据**，只用于验证「容器能读数据、能出图」这条链路，不是任何实测结果。
  换成自己的数据即可。
- **命令以 Docker 27 / Compose v2 为准**。老教程里的 `docker-compose`（带横线）是 v1，已停止维护。
- **Windows 上涉及 `D:/` 路径挂载的命令，建议用 PowerShell 执行**。Git Bash 会改写路径，
  需要时加前缀 `MSYS_NO_PATHCONV=1`。
- **关于镜像加速**：国内拉取镜像慢是常态，但公开的加速地址变动频繁，所以教程里没有写死具体链接，
  只说明了配置方法（Docker Desktop → Settings → Docker Engine）。用你所在学校或云厂商提供的地址即可。
- 实验里的镜像标签（如 `nginx`、`redis:7-alpine`、`python:3.12-slim`）没有锁死小版本，
  长期之后行为可能有细微差异；如果某天跑不通了，把它们换成固定版本号再试。

---

## 许可

内容可自由用于学习、教学和内部培训，转载或改编注明出处即可。
