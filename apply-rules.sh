#!/bin/bash

# 检查是否提供了目标目录参数
if [ $# -eq 0 ]; then
    echo "错误：请提供目标项目目录"
    echo "用法：./apply-rules.sh <目标项目目录>"
    exit 1
fi

TARGET_DIR="$1"

# 如果目标目录不存在，则创建它
if [ ! -d "$TARGET_DIR" ]; then
    echo "📁 创建新项目目录：$TARGET_DIR"
    mkdir -p "$TARGET_DIR"
    
    # 为新项目初始化 README 文件
    cat > "$TARGET_DIR/README.md" << 'EOL'
# 新项目

此项目已使用来自 [cursor-auto-rules-agile-workflow](https://github.com/bmadcode/cursor-auto-rules-agile-workflow) 的敏捷工作流支持和自动规则生成进行初始化。

有关工作流文档，请参阅 [工作流规则](docs/workflow-rules.md)。
EOL
fi

# 创建 .cursor 目录（如果不存在）
mkdir -p "$TARGET_DIR/.cursor"

# 定义复制文件的函数，仅当目标文件不存在时才复制
copy_if_not_exists() {
    local src="$1"    # 源文件路径
    local dest="$2"   # 目标文件路径
    
    if [ ! -e "$dest" ]; then
        echo "📦 复制新文件：$(basename "$dest")"
        cp "$src" "$dest"
    else
        echo "⏭️  跳过已存在的文件：$(basename "$dest")"
    fi
}

# 复制 .cursor 目录结构中的所有文件
echo "📦 正在复制 .cursor 目录文件..."
find .cursor -type f | while read -r file; do
    # 获取相对于 .cursor 的路径
    rel_path="${file#.cursor/}"
    target_file="$TARGET_DIR/.cursor/$rel_path"
    target_dir="$(dirname "$target_file")"
    
    # 如果目标目录不存在，则创建它
    mkdir -p "$target_dir"
    
    # 如果文件不存在，则复制它
    copy_if_not_exists "$file" "$target_file"
done

# 创建 docs 目录（如果不存在）
mkdir -p "$TARGET_DIR/docs"

# 创建工作流文档
cat > "$TARGET_DIR/docs/workflow-rules.md" << 'EOL'
# Cursor 工作流规则

此项目已更新为使用来自 [cursor-auto-rules-agile-workflow](https://github.com/bmadcode/cursor-auto-rules-agile-workflow) 的自动规则生成器。

> **注意**：此脚本可以随时安全地重新运行以更新模板规则到最新版本。它不会影响或覆盖您创建的任何自定义规则。

## 核心功能

- 自动规则生成
- 标准化文档格式
- 自动支持所有四种笔记类型
- AI 行为控制和优化
- 灵活的工作流集成选项

## 开始使用

1. 查看 `xnotes/` 中的模板
2. 选择您喜欢的工作流方式
3. 开始自信地使用 AI！

有关演示和教程，请访问：[BMad Code 视频](https://youtube.com/bmadcode)
EOL

# 如果需要，更新 .gitignore 文件
if [ -f "$TARGET_DIR/.gitignore" ]; then
    if ! grep -q "\.cursor/rules/_\*\.mdc" "$TARGET_DIR/.gitignore"; then
        echo -e "\n# 私有个人用户 cursor 规则\n.cursor/rules/_*.mdc" >> "$TARGET_DIR/.gitignore"
    fi
else
    echo -e "# 私有个人用户 cursor 规则\n.cursor/rules/_*.mdc" > "$TARGET_DIR/.gitignore"
fi

# 创建 xnotes 目录并复制文件
echo "📝 正在设置示例 xnotes..."
mkdir -p "$TARGET_DIR/xnotes"
cp -r xnotes/* "$TARGET_DIR/xnotes/"

# 如果需要，更新 .cursorignore 文件
if [ -f "$TARGET_DIR/.cursorignore" ]; then
    if ! grep -q "^xnotes/" "$TARGET_DIR/.cursorignore"; then
        echo -e "\n# 项目笔记和模板\nxnotes/" >> "$TARGET_DIR/.cursorignore"
    fi
else
    echo -e "# 项目笔记和模板\nxnotes/" > "$TARGET_DIR/.cursorignore"
fi

# 创建或更新 .cursorindexingignore
if [ -f "$TARGET_DIR/.cursorindexingignore" ]; then
    # 在修改之前备份原始文件
    cp "$TARGET_DIR/.cursorindexingignore" "$TARGET_DIR/.cursorindexingignore.bak"
    
    # 将源 .cursorindexingignore 的所有条目复制到目标文件
    cp ".cursorindexingignore" "$TARGET_DIR/.cursorindexingignore"
    
    echo "🔄 已使用源文件中的所有条目更新 .cursorindexingignore"
else
    # 通过复制当前文件创建新文件
    cp ".cursorindexingignore" "$TARGET_DIR/.cursorindexingignore"
    echo "📝 已创建新的 .cursorindexingignore 文件"
fi

echo "✨ 部署完成！"
echo "📁 核心规则生成器：$TARGET_DIR/.cursor/rules/core-rules/rule-generating-agent.mdc"
echo "📁 示例子文件夹和规则：$TARGET_DIR/.cursor/rules/{sub-folders}/"
echo "📁 示例敏捷工作流模板：$TARGET_DIR/.cursor/templates/"
echo "📄 工作流文档：$TARGET_DIR/docs/workflow-rules.md"
echo "🔒 已更新 .gitignore、.cursorignore 和 .cursorindexingignore"
