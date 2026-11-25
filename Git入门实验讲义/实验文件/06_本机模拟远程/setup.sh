#!/usr/bin/env bash
# =====================================================================
#  06_本机模拟远程  ·  本机模拟远程：push、pull 与一次被拒
#  作用：在 ~/git-lab/lab06 下重建本实验的起始文件
#  运行：bash setup.sh          （重来加 --force，旧目录改名备份，不删除）
# =====================================================================
set -euo pipefail
HERE="$(cd "$(dirname "$0")" && pwd)"
ROOT="$HOME/git-lab"
LAB="$ROOT/lab06"

echo
echo "  06_本机模拟远程 · 本机模拟远程：push、pull 与一次被拒"
echo "  ------------------------------------------------------------------"

if [ -e "$LAB" ]; then
  if [ "${1:-}" != "--force" ]; then
    echo "  目录已存在：$LAB"
    echo "  想从零重来请执行：  bash setup.sh --force   （旧目录会改名备份，不删除）"
    exit 0
  fi
  BAK="${LAB}_bak_$(date +%m%d%H%M%S)"
  mv "$LAB" "$BAK"
  echo "  旧目录已备份为：$BAK"
fi

mkdir -p "$LAB"
echo "  已创建目录：$LAB"
echo "  本实验无需预先准备文件。"

if ! git config --global user.name >/dev/null 2>&1 || ! git config --global user.email >/dev/null 2>&1; then
  echo
  echo "  [注意] 还没配置提交身份，第一次 commit 会失败。先执行："
  echo '      git config --global user.name  "你的名字"'
  echo '      git config --global user.email "you@example.com"'
fi

echo
echo "  下一步：cd \"$LAB\"  然后按讲义往下敲。"
echo
