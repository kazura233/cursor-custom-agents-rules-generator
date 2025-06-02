# 1. 标题：{项目} 的 PRD

<version>1.0.0</version>

## 状态：{ 草稿 | 已批准 }

## 简介

{ 简短描述 PRD 将要实现的内容和原因，1-2 段落 }

## 目标

{

- 明确的项目目标
- 可衡量的成果
- 成功标准
- 关键绩效指标（KPI）
  }

## 功能和需求

{

- 功能需求
- 非功能需求
- 用户体验需求
- 集成需求
- 合规需求
  }

## Epic 列表

### Epic-1：当前 PRD Epic（例如后端 epic）

### Epic-2：第二个当前 PRD Epic（例如前端 epic）

### Epic-N：未来 Epic 增强（超出当前 PRD 范围）

## Epic 1：故事列表

<example>
- 故事 1：NestJS 配置
  状态：{''|'进行中'|'完成'}
  需求：
  - 全局安装 NestJS CLI
  - 使用 nestJS cli 生成器创建新的 NestJS 项目

- 故事 2：Hacker News 检索 API 路由
  状态：{''|'进行中'|'完成'}
  需求：
  - 创建返回 Hacker News 热门帖子列表、从热门帖子抓取的文章以及热门帖子评论列表的 API 路由
  - 路由 post body 指定要返回的帖子、文章和评论数量
  - 在 package.json 中创建可用于调用 API 路由的命令（路由在 env.local 中配置）
    </example>

## 技术栈

{ 列出语言、库、基础设施等的选择表 }

  <example>
  | 技术 | 描述 |
  | ------------ | ------------------------------------------------------------- |
  | Kubernetes | 用于微服务部署的容器编排平台 |
  | Apache Kafka | 用于实时数据摄取的事件流平台 |
  | TimescaleDB | 用于传感器数据存储的时间序列数据库 |
  | Go | 数据处理服务的主要语言 |
  | GoRilla Mux | REST API 框架 |
  | Python | 用于数据分析和 ML 服务 |
  </example>

## 参考

{ 模型表的 Mermaid 图表、可视辅助工具、引用和外部 URL }

## 数据模型、API 规范、模式等...

{ 根据需要 - 可能不完整 - 但需要保留并遵循到架构和故事中的关键概念 }

<example>
### 传感器读数模式

```json
{
  "sensor_id": "string",
  "timestamp": "datetime",
  "readings": {
    "temperature": "float",
    "pressure": "float",
    "humidity": "float"
  },
  "metadata": {
    "location": "string",
    "calibration_date": "datetime"
  }
}
```

</example>

## 项目结构

{ 绘制文件夹和文件组织结构图以及描述 }

<example>

```
src/
├── services/
│   ├── gateway/        # 传感器数据摄取
│   ├── processor/      # 数据处理和验证
│   ├── analytics/      # 数据分析和 ML
│   └── notifier/       # 警报和通知系统
├── deploy/
│   ├── kubernetes/     # K8s 清单
│   └── terraform/      # 基础设施即代码
└── docs/
    ├── api/           # API 文档
    └── schemas/       # 数据模式
```

</example>

## 变更日志

{ 文档不再处于草稿状态并更新后的关键变更的 Markdown 表格，表格包括变更标题、发生变更的故事 ID，以及如果标题不够清晰时的描述 }

<example>
| 变更               | 故事 ID | 描述                                                   |
| -------------------- | -------- | ------------------------------------------------------------- |
| 初始草稿        | N/A      | 初始草稿 prd                                             |
| 添加 ML 管道      | story-4  | 集成机器学习预测服务故事      |
| Kafka 升级        | story-6  | 从 Kafka 2.0 升级到 Kafka 3.0 以提高性能 |
</example>
