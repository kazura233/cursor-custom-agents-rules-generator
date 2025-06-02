@echo off
REM 启用延迟变量扩展
setlocal EnableDelayedExpansion
REM 设置控制台代码页为 UTF-8
chcp 65001 >nul

echo 调试：脚本已启动

REM 检查是否提供了目标目录参数
if "%~1"=="" (
    echo 错误：请提供目标项目目录
    echo 用法：%~nx0 ^<目标项目目录^>
    exit /b 1
)
REM 设置目标目录变量
set "TARGET_DIR=%~1"

REM 如果目标目录不存在，则创建它
if not exist "%TARGET_DIR%\" (
    echo 📁 创建新项目目录：%TARGET_DIR%
    mkdir "%TARGET_DIR%"
    REM 创建并写入 README.md 文件内容
    (
        echo # 新项目
        echo.
        echo 此项目已使用来自 [cursor-auto-rules-agile-workflow](https://github.com/bmadcode/cursor-auto-rules-agile-workflow) 的敏捷工作流支持和自动规则生成进行初始化
        echo.
        echo 有关工作流文档，请参阅 [工作流规则](docs/workflow-rules.md)
    ) > "%TARGET_DIR%\README.md"
)

REM 创建 .cursor 目录（如果不存在）
if not exist "%TARGET_DIR%\.cursor\" (
    mkdir "%TARGET_DIR%\.cursor"
)

REM 定义复制文件的函数，仅当目标文件不存在时才复制
:copy_if_not_exists
set "src=%~1"
set "dest=%~2"
if not exist "%dest%" (
    echo 📦 复制新文件：%~nx2
    copy "%src%" "%dest%" >nul
) else (
    echo ⏭️  跳过已存在的文件：%~nx2
)
exit /b

REM 复制 .cursor 目录结构中的所有文件
echo 📦 正在复制 .cursor 目录文件...
for /r ".cursor" %%F in (*) do (
    REM 获取相对路径
    set "rel_path=%%~pF"
    set "rel_path=!rel_path:.cursor\=!"
    
    REM 如果目标目录不存在，则创建它
    if not exist "%TARGET_DIR%\.cursor\!rel_path!" (
        mkdir "%TARGET_DIR%\.cursor\!rel_path!"
    )
    
    REM 如果文件不存在，则复制它
    call :copy_if_not_exists "%%F" "%TARGET_DIR%\.cursor\!rel_path!%%~nxF"
)

REM 创建 docs 目录（如果不存在）
if not exist "%TARGET_DIR%\docs\" (
    mkdir "%TARGET_DIR%\docs"
)

REM 创建工作流文档
(
    echo # Cursor 工作流规则
    echo.
    echo 此项目已更新为使用来自 [cursor-auto-rules-agile-workflow](https://github.com/bmadcode/cursor-auto-rules-agile-workflow) 的自动规则生成器
    echo.
    echo ^> **注意**：此脚本可以随时安全地重新运行以更新模板规则到最新版本。它不会影响或覆盖您创建的任何自定义规则。
    echo.
    echo ## 核心功能
    echo.
    echo - 自动规则生成
    echo - 标准化文档格式
    echo - 自动支持所有四种笔记类型
    echo - AI 行为控制和优化
    echo - 灵活的工作流集成选项
    echo.
    echo ## 开始使用
    echo.
    echo 1^. 查看 `xnotes/` 中的模板
    echo 2^. 选择您喜欢的工作流方式
    echo 3^. 开始自信地使用 AI！
    echo.
    echo 有关演示和教程，请访问：[BMad Code 视频](https://youtube^.com/bmadcode)
) > "%TARGET_DIR%\docs\workflow-rules.md"

REM 更新 .gitignore 文件，添加 xnotes 和 docs 目录
if exist "%TARGET_DIR%\.gitignore" (
    REM 检查是否已包含 cursor 规则忽略项
    findstr /L /C:".cursor/rules/_*.mdc" "%TARGET_DIR%\.gitignore" >nul
    if errorlevel 1 (
        REM 添加新的忽略规则
        (
            echo.
            echo # 私有个人用户 cursor 规则
            echo .cursor/rules/_*.mdc
            echo.
            echo # 文档和模板
            echo xnotes/
            echo docs/
        ) >> "%TARGET_DIR%\.gitignore"
    )
) else (
    REM 创建新的 .gitignore 文件
    (
        echo # 私有个人用户 cursor 规则
        echo .cursor/rules/_*.mdc
        echo.
        echo # 文档和模板
        echo xnotes/
        echo docs/
    ) > "%TARGET_DIR%\.gitignore"
)

REM 添加示例 xnotes 文件
echo 正在设置示例 xnotes 文件...
if not exist "%TARGET_DIR%\xnotes\" (
    mkdir "%TARGET_DIR%\xnotes"
)
REM 复制所有 xnotes 文件到目标目录
xcopy "xnotes\*.*" "%TARGET_DIR%\xnotes\" /E /I /Y >nul

REM 更新 .cursorignore 文件
if exist "%TARGET_DIR%\.cursorignore" (
    REM 检查是否已包含 xnotes 忽略项
    findstr /L /C:"xnotes/" "%TARGET_DIR%\.cursorignore" >nul
    if errorlevel 1 (
        REM 添加新的忽略规则
        (
            echo.
            echo # 项目笔记和模板
            echo xnotes/
        ) >> "%TARGET_DIR%\.cursorignore"
    )
) else (
    REM 创建新的 .cursorignore 文件
    (
        echo # 项目笔记和模板
        echo xnotes/
    ) > "%TARGET_DIR%\.cursorignore"
)

REM 创建或更新 .cursorindexingignore 文件
if exist "%TARGET_DIR%\.cursorindexingignore" (
    REM 检查是否已包含模板忽略项
    findstr /L /C:".cursor/templates/" "%TARGET_DIR%\.cursorindexingignore" >nul
    if errorlevel 1 (
        REM 添加新的忽略规则
        (
            echo.
            echo # 模板 - 可访问但不索引
            echo .cursor/templates/
        ) >> "%TARGET_DIR%\.cursorindexingignore"
    )
) else (
    REM 创建新的 .cursorindexingignore 文件
    (
        echo # 模板 - 可访问但不索引
        echo .cursor/templates/
    ) > "%TARGET_DIR%\.cursorindexingignore"
)

REM 显示部署完成信息
echo.
echo ✨ 部署完成！
echo 📁 核心规则生成器：%TARGET_DIR%\.cursor\rules\core-rules\rule-generating-agent.mdc
echo 📁 示例子文件夹和规则：%TARGET_DIR%\.cursor\rules\{sub-folders}\
echo 📁 示例敏捷工作流模板：%TARGET_DIR%\.cursor\templates\
echo 📄 工作流文档：%TARGET_DIR%\docs\workflow-rules.md
echo 🔒 已更新 .gitignore、.cursorignore 和 .cursorindexingignore

REM 结束本地变量环境
endlocal
