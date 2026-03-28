$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$exe = Join-Path $root 'build\elitx_core_bridge.exe'

if (-not (Test-Path $exe)) {
    Write-Host 'build\elitx_core_bridge.exe bulunamadi. Once build.ps1 calistirin.' -ForegroundColor Red
    exit 1
}

if ($args.Count -lt 4) {
    Write-Host 'Kullanim: .\run_bridge.ps1 <giris_bicimi> <giris_dosyasi> <cikis_bicimi> <cikis_dosyasi> [durum_dosyasi]' -ForegroundColor Yellow
    exit 2
}

Set-Location $root
& $exe $args[0] $args[1] $args[2] $args[3] $args[4]
