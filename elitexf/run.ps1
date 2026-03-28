$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$exe = Join-Path $root 'build\elitexf.exe'

if (-not (Test-Path $exe)) {
    Write-Host 'build\elitexf.exe bulunamadi. Once build.ps1 calistirin.' -ForegroundColor Red
    exit 1
}

Set-Location $root
& $exe
