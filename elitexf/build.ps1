$ErrorActionPreference = 'Stop'

$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$buildDir = Join-Path $root 'build'
$outExe = Join-Path $buildDir 'elitexf.exe'

$stageRoot = 'C:\elitexf_stage'
$stageSrc = Join-Path $stageRoot 'src'
$stageCore = Join-Path $stageRoot 'core'
$stageMain = Join-Path $stageSrc 'main.bas'
$stageExe = Join-Path $stageRoot 'elitexf.exe'

New-Item -ItemType Directory -Force $buildDir | Out-Null
New-Item -ItemType Directory -Force $stageRoot | Out-Null

if (Test-Path $stageSrc) { Remove-Item $stageSrc -Recurse -Force }
if (Test-Path $stageCore) { Remove-Item $stageCore -Recurse -Force }

Copy-Item (Join-Path $root 'src') $stageSrc -Recurse -Force
Copy-Item (Join-Path $root '..\elitx_core_fb\src') $stageCore -Recurse -Force

Write-Host 'Elitexf derleniyor...' -ForegroundColor Cyan
fbc $stageMain -i $stageSrc -i $stageCore -x $stageExe

if ($LASTEXITCODE -ne 0) {
    throw 'Derleme basarisiz.'
}

Copy-Item $stageExe $outExe -Force

Write-Host "Tamamlandi: $outExe" -ForegroundColor Green
