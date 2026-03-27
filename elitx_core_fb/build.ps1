$ErrorActionPreference = 'Stop'

$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$buildDir = Join-Path $root 'build'
$outExe = Join-Path $buildDir 'elitx_core_fb.exe'

$stageRoot = 'C:\elitx_core_stage'
$stageSrc = Join-Path $stageRoot 'src'
$stageMain = Join-Path $stageSrc 'main.bas'
$stageExe = Join-Path $stageRoot 'elitx_core_fb.exe'

New-Item -ItemType Directory -Force $buildDir | Out-Null
New-Item -ItemType Directory -Force $stageRoot | Out-Null

if (Test-Path $stageSrc) {
    Remove-Item $stageSrc -Recurse -Force
}

Copy-Item (Join-Path $root 'src') $stageSrc -Recurse -Force

Write-Host 'FreeBASIC cekirdek derleniyor...' -ForegroundColor Cyan
fbc $stageMain -x $stageExe

if ($LASTEXITCODE -ne 0) {
    throw 'Derleme basarisiz.'
}

Copy-Item $stageExe $outExe -Force
Write-Host "Tamamlandi: $outExe" -ForegroundColor Green
