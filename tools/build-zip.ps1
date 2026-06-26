# Packt das Addon als ZIP fuer den AMO-Upload (addons.mozilla.org).
# Nutzt .NET-Zip mit Forward-Slash-Pfaden, da AMO Backslashes ablehnt.

Add-Type -AssemblyName System.IO.Compression
Add-Type -AssemblyName System.IO.Compression.FileSystem

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

# Liste aller zu packenden Dateien (rekursiv) mit relativem Pfad sammeln
$files = @()
foreach ($item in $include) {
    $full = Join-Path $root $item
    if (Test-Path $full -PathType Container) {
        $files += Get-ChildItem $full -Recurse -File
    } else {
        $files += Get-Item $full
    }
}

$zip = [System.IO.Compression.ZipFile]::Open($outFile, [System.IO.Compression.ZipArchiveMode]::Create)
try {
    foreach ($file in $files) {
        $relative = $file.FullName.Substring($root.Length + 1).Replace('\', '/')
        [System.IO.Compression.ZipFileExtensions]::CreateEntryFromFile(
            $zip, $file.FullName, $relative,
            [System.IO.Compression.CompressionLevel]::Optimal) | Out-Null
        Write-Host "  + $relative"
    }
} finally {
    $zip.Dispose()
}

Write-Host "Paket erstellt: $outFile"
Write-Host "Upload auf https://addons.mozilla.org/developers/"
