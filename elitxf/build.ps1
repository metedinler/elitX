$ErrorActionPreference = 'Stop'

$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$buildDir = Join-Path $root 'build'
$distDir = Join-Path $root 'dist'
$backupDir = Join-Path $root 'backup'
$outBuild = Join-Path $buildDir 'elitxf.exe'
$outDist = Join-Path $distDir 'elitxf.exe'
$stageRoot = 'C:\elitxf_stage'
$stageSrc = Join-Path $stageRoot 'src'
$stageMain = Join-Path $stageSrc 'main.bas'
$stageOut = Join-Path $stageRoot 'elitxf.exe'

New-Item -ItemType Directory -Force $buildDir | Out-Null
New-Item -ItemType Directory -Force $distDir | Out-Null
New-Item -ItemType Directory -Force $backupDir | Out-Null
New-Item -ItemType Directory -Force $stageRoot | Out-Null

if (Test-Path $outDist) {
    $stamp = Get-Date -Format 'yyyyMMdd_HHmmss'
    Copy-Item $outDist (Join-Path $backupDir ("elitxf_$stamp.exe")) -Force
}

# ASCII staging: FreeBASIC bazen Turkce karakterli yolda include bulamiyor.
if (Test-Path $stageSrc) {
    Remove-Item $stageSrc -Recurse -Force
}
Copy-Item (Join-Path $root 'src') $stageSrc -Recurse -Force

Write-Host 'FreeBASIC derleniyor...' -ForegroundColor Cyan
fbc $stageMain -x $stageOut

if ($LASTEXITCODE -ne 0) {
    throw "Derleme hatasi."
}

Copy-Item $stageOut $outBuild -Force
Copy-Item $stageOut $outDist -Force
Write-Host "Tamamlandi: $outDist" -ForegroundColor Green
