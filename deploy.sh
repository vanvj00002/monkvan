#!/bin/bash

# Hugo 博客部署脚本到 GitHub Pages
# 使用方式: bash deploy.sh "提交消息"

set -e

# 设置变量
REPO_DIR="/Users/vanvj/my-blog"
BRANCH="gh-pages"
COMMIT_MSG="${1:-Update site on $(date +'%Y-%m-%d %H:%M:%S')}"

echo "🚀 开始部署 Hugo 博客到 GitHub Pages..."

# 进入项目目录
cd "$REPO_DIR"

# 清理旧的 public 目录
echo "🧹 清理旧的编译文件..."
rm -rf public

# 编译 Hugo
echo "🔨 编译 Hugo..."
hugo

# 进入 public 目录
cd public

# 初始化 git（如果还没有的话）
if [ ! -d .git ]; then
    echo "📦 初始化 git 仓库..."
    git init
    git remote add origin https://github.com/vanvj00002/monkvan.git
fi

# 配置 git 用户信息（如果需要）
git config user.email "you@example.com" || git config --global user.email "you@example.com"
git config user.name "Your Name" || git config --global user.name "Your Name"

# 添加所有文件
echo "📝 添加文件到 git..."
git add -A

# 检查是否有变化
if git diff --cached --quiet; then
    echo "✅ 没有文件变化，部署已完成"
else
    # 提交
    echo "💾 提交更改..."
    git commit -m "$COMMIT_MSG"
    
    # 推送到 gh-pages 分支
    echo "🌐 推送到 GitHub..."
    git push -u origin main:gh-pages
    
    echo "✨ 部署完成！"
    echo "📍 你的博客地址: https://vanvj00002.github.io/monkvan"
fi