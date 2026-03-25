#!/bin/bash

set -e

REPO_DIR="/Users/vanvj/my-blog"
COMMIT_MSG="${1:-deploy: $(date '+%Y-%m-%d %H:%M:%S')}"

echo "=========================================="
echo "开始部署博客到 GitHub"
echo "=========================================="

cd "$REPO_DIR"

# Clean build
echo "[1/4] 清理旧构建..."
rm -rf public resources/_gen

# Build
echo "[2/4] 构建博客..."
hugo --minify

# Deploy to gh-pages branch
echo "[3/4] 部署到 gh-pages..."
cd public

# Init git in public folder if needed
if [ ! -d .git ]; then
    git init
    git remote add origin https://github.com/vanvj00002/monkvan.git
fi

git add -A
git commit -m "$COMMIT_MSG" || echo "没有更改需要提交"
git push origin gh-pages --force

echo "=========================================="
echo "部署完成！"
echo "博客地址: https://vanvj00002.github.io/monkvan"
echo "=========================================="
