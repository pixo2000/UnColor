# Packt das Addon als ZIP fuer den AMO-Upload (addons.mozilla.org).
# Die ZIP enthaelt alle noetigen Dateien mit manifest.json im Wurzelverzeichnis.

$root = Split-Path $PSScriptRoot -Parent
$distDir = Join-Path $root "dist"
$version = (Get-Content (Join-Path $root "manifest.json") -Raw | ConvertFrom-Json).version
$outFile = Join-Path $distDir "uncolor-$version.zip"

# Dateien/Ordner, die ins Paket gehoeren
$include = @(
    "manifest.json",
    "background.js",
    "popup",
    "icons"
)

if (-not (Test-Path $distDir)) {
    New-Item -ItemType Directory -Path $distDir | Out-Null
}
if (Test-Path $outFile) {
    Remove-Item $outFile -Force
}

$paths = $include | ForEach-Object { Join-Path $root $_ }
Compress-Archive -Path $paths -DestinationPath $outFile -Force

Write-Host "Paket erstellt: $outFile"
Write-Host "Upload auf https://addons.mozilla.org/developers/"
