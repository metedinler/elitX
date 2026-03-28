$ErrorActionPreference = 'Stop'

$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$buildDir = Join-Path $root 'build'
$outExe = Join-Path $buildDir 'elitx_core_fb.exe'
$outBridgeExe = Join-Path $buildDir 'elitx_core_bridge.exe'

$stageRoot = 'C:\elitx_core_stage'
$stageSrc = Join-Path $stageRoot 'src'
$stageMain = Join-Path $stageSrc 'main.bas'
$stageBridgeMain = Join-Path $stageSrc 'bridge_main.bas'
$stageExe = Join-Path $stageRoot 'elitx_core_fb.exe'
$stageBridgeExe = Join-Path $stageRoot 'elitx_core_bridge.exe'

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

Write-Host 'FreeBASIC bridge derleniyor...' -ForegroundColor Cyan
fbc $stageBridgeMain -x $stageBridgeExe

if ($LASTEXITCODE -ne 0) {
    throw 'Bridge derlemesi basarisiz.'
}

Copy-Item $stageExe $outExe -Force
Copy-Item $stageBridgeExe $outBridgeExe -Force
Write-Host "Tamamlandi: $outExe" -ForegroundColor Green
Write-Host "Tamamlandi: $outBridgeExe" -ForegroundColor Green
