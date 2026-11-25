# =====================================================================
#  06_本机模拟远程  ·  本机模拟远程：push、pull 与一次被拒
#  作用：在 $HOME\git-lab\lab06 下重建本实验的起始文件
#  运行：右键 → 使用 PowerShell 运行
#        或在 PowerShell 里执行  powershell -ExecutionPolicy Bypass -File setup.ps1
#  重来：加 -Force 参数（会把旧目录改名备份，不会删除任何东西）
# =====================================================================
param([switch]$Force)

$ErrorActionPreference = 'Stop'
$root = Join-Path $HOME 'git-lab'
$lab  = Join-Path $root 'lab06'
$seed = Join-Path $PSScriptRoot 'files'

Write-Host ''
Write-Host '  06_本机模拟远程 · 本机模拟远程：push、pull 与一次被拒' -ForegroundColor Cyan
Write-Host '  ------------------------------------------------------------------' -ForegroundColor DarkGray

if (Test-Path $lab) {
    if (-not $Force) {
        Write-Host '  目录已存在：' -NoNewline -ForegroundColor Yellow
        Write-Host $lab -ForegroundColor Yellow
        Write-Host '  想保留它就直接用；想从零重来请加 -Force（旧目录会改名备份，不删除）：' -ForegroundColor Yellow
        Write-Host '      powershell -ExecutionPolicy Bypass -File setup.ps1 -Force' -ForegroundColor DarkGray
        Write-Host ''
        exit 0
    }
    $bak = $lab + '_bak_' + (Get-Date -Format 'MMddHHmmss')
    Move-Item $lab $bak
    Write-Host '  旧目录已备份为：' -NoNewline -ForegroundColor DarkGray
    Write-Host $bak -ForegroundColor DarkGray
}

New-Item -ItemType Directory -Path $lab -Force | Out-Null
Write-Host '  已创建目录：' -NoNewline -ForegroundColor Green
Write-Host $lab

# ---- 写入起始文件（UTF-8 无 BOM，避免 Git 把 BOM 一起提交）----
$utf8 = New-Object System.Text.UTF8Encoding($false)
$seeds = @()
foreach ($n in $seeds) {
    $src = Join-Path $seed $n
    $dst = Join-Path $lab  $n
    if (-not (Test-Path $src)) { throw "缺少起始文件：$src" }
    $txt = [System.IO.File]::ReadAllText($src, [System.Text.Encoding]::UTF8)
    [System.IO.File]::WriteAllText($dst, $txt, $utf8)
    Write-Host '  写入文件：' -NoNewline -ForegroundColor Green
    Write-Host $n
}
if ($seeds.Count -eq 0) { Write-Host '  本实验无需预先准备文件，直接在空目录里开始。' -ForegroundColor DarkGray }

# ---- 检查 Git 是否已配置身份（没配的话第一次 commit 会失败）----
$uname = git config --global user.name 2>$null
$umail = git config --global user.email 2>$null
Write-Host ''
if ([string]::IsNullOrWhiteSpace($uname) -or [string]::IsNullOrWhiteSpace($umail)) {
    Write-Host '  [注意] 还没配置提交身份，第一次 commit 会报 Author identity unknown。先执行：' -ForegroundColor Yellow
    Write-Host '      git config --global user.name  "你的名字"' -ForegroundColor DarkGray
    Write-Host '      git config --global user.email "you@example.com"' -ForegroundColor DarkGray
} else {
    Write-Host ('  Git 身份已配置：' + $uname + ' <' + $umail + '>') -ForegroundColor DarkGray
}

Write-Host ''
Write-Host '  下一步：cd "' -NoNewline -ForegroundColor Cyan
Write-Host $lab -NoNewline -ForegroundColor Cyan
Write-Host '"' -NoNewline -ForegroundColor Cyan
Write-Host '  然后照着讲义第 2 节往下敲。' -ForegroundColor Cyan
Write-Host ''
