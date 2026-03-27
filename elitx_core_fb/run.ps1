$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$exe = Join-Path $root 'build\elitx_core_fb.exe'

if (-not (Test-Path $exe)) {
    Write-Host 'build\elitx_core_fb.exe bulunamadi. Once build.ps1 calistirin.' -ForegroundColor Red
    exit 1
}

Set-Location $root
Start-Process -FilePath $exe -WorkingDirectory (Split-Path $exe -Parent)
