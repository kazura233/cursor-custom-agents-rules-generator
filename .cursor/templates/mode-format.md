# Cursor 自定义模式格式文档

本文档描述了在 `.cursor/modes.json` 文件中定义自定义模式的格式。

如果你在外部、内部使用 AI 或手动生成类似于 docs/custom-agents.md 的文件 - 你可以要求 cursor 代理生成新的或更新现有的 .cursor/mode.json。当官方支持 json 文件时 - 你可以轻松地要求代理转换你的文件 - 或者如果你已经通过 gui 创建了文件中描述的所有代理 - 当你升级到支持 json 文件的版本时，cursor 将自动创建该文件 - 很可能在你的用户文件夹/.cursor 中（适用于 cursor 中所有项目的配置）！

## 文件结构

`modes.json` 文件包含一个具有两个主要字段的 JSON 对象：

- `modes`：模式配置对象数组

## 模式配置模式

```json
{
  "commentFromBMad": "string",
  "modes": [
    {
      "name": "string",
      "description": "string",
      "comment": "string",
      "model": "string",
      "customPrompt": "string",
      "allowedCursorTools": "string[]",
      "allowedMcpTools": "string[]",
      "autoApplyEdits": "boolean",
      "autoRun": "boolean",
      "autoFixErrors": "boolean"
    }
  ]
}
```

## 字段描述

### 根级别字段

| 字段    | 类型  | 描述             |
| ------- | ----- | ---------------- |
| `modes` | array | 模式配置对象数组 |

### 模式配置字段

| 字段                 | 类型              | 必需 | 默认值 | 描述                                                                                                                 |
| -------------------- | ----------------- | ---- | ------ | -------------------------------------------------------------------------------------------------------------------- |
| `name`               | string            | 是   | -      | 在标签中显示的简短 CapCase 但易于记忆的名称。完整名称将在 description 字段中 - 如 PicardPm 或 RikerArch，或 FooFEDev |
| `description`        | string            | 是   | -      | 不用于实际配置，但便于用户简要了解这是什么角色                                                                       |
| `comment`            | string            | 否   | -      | 用于文档目的的参考说明                                                                                               |
| `model`              | string            | 是   | -      | 用于此模式的 AI 模型                                                                                                 |
| `customPrompt`       | string            | 否   | -      | 定义代理角色和行为的详细提示                                                                                         |
| `allowedCursorTools` | string[] 或 "all" | 否   | -      | 此模式可以访问的 Cursor 工具数组，或 "all" 授予访问所有可用 Cursor 工具的权限                                        |
| `allowedMcpTools`    | string[] 或 "all" | 否   | -      | 允许的 MCP 工具名称数组或逗号分隔列表，或 "all" 授予访问所有可用 MCP 工具的权限                                      |
| `autoApplyEdits`     | boolean           | 否   | false  | 自动应用编辑而无需确认                                                                                               |
| `autoRun`            | boolean           | 否   | false  | 自动运行命令而无需确认                                                                                               |
| `autoFixErrors`      | boolean           | 否   | false  | 自动尝试修复检测到的错误                                                                                             |

## 支持的模型

以下模型目前支持用于 `model` 字段：

- `claude-3-opus`
- `claude-3.5-haiku`
- `claude-3.5-sonnet`
- `claude-3.7-sonnet`
- `claude-3.7-sonnet-max`
- `cursor-fast`
- `cursor-small`
- `deepseek-r1`
- `deepseek-v3`
- `gemini-2.0-flash`
- `gemini-2.0-flash-exp`
- `gemini-2.0-pro-exp`
- `gemini-2.5-pro-exp-03-25`
- `gemini-2.5-pro-max`
- `gemini-exp-1206`
- `gpt-3.5-turbo`
- `gpt-4`
- `gpt-4-turbo-2024-04-09`
- `gpt-4.5-preview`
- `gpt-4o`
- `gpt-4o-mini`
- `grok-2`
- `o1`
- `o1-mini`
- `o1-preview`
- `o3-mini`

注意：随着 Cursor 扩展其模型集成，未来可能会支持更多模型。

## 支持的 Cursor 工具

以下工具可以在 `allowedCursorTools` 数组中指定：

### 搜索工具

- `codebase_search` - 跨代码库的语义搜索
- `web` - Web 搜索功能
- `grep` - 基于模式的代码搜索
- `list_directory` - 列出目录内容
- `search_files` - 按名称搜索文件
- `read_file` - 读取文件内容
- `fetch_rules` - 获取自定义代码库规则

### 编辑工具

- `edit_file` - 编辑文件内容
- `edit_and_reapply` - 使用智能重新应用进行编辑
- `delete_file` - 删除文件

### 运行工具

- `terminal` - 执行终端命令

## 配置示例

```json
{
  "commentFromBMad": "示例自定义模式配置",
  "modes": [
    {
      "name": "PiPyDev",
      "description": "海盗 Python 开发者",
      "comment": "专门用于 Python 开发的模式，启用了自动修复",
      "model": "claude-3.5-sonnet",
      "customPrompt": "你是一个专业的 Python 开发者，在对话中总是像海盗一样说话，但永远不会将这种个性注入到正在创建或更新的文件中...",
      "allowedCursorTools": [
        "codebase_search",
        "web",
        "grep",
        "list_directory",
        "search_files",
        "read_file",
        "fetch_rules",
        "edit_file",
        "edit_and_reapply",
        "delete_file",
        "terminal"
      ],
      "allowedMcpTools": ["python_linter", "python_formatter", "pytest"],
      "autoApplyEdits": true,
      "autoRun": false,
      "autoFixErrors": true
    }
  ]
}
```

## MCP 工具

`allowedMcpTools` 字段可以包含在 MCP 配置中配置的任何自定义工具名称。这些应该与 MCP 设置中给工具的确切名称匹配。

## 最佳实践

1. 为自定义模式选择描述性名称
2. 提供详细的自定义提示，明确定义代理的角色
3. 将工具访问限制在模式目的所需的范围内
4. 在 comment 字段中记录任何特殊要求或依赖关系
5. 对 MCP 工具使用一致的命名约定 🔧
