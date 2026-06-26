# Erzeugt PNG-Icons (48/96/128) fuer das UnColor-Addon.
# Motiv: durchgestrichener Kreis ("ban") in Lila auf transparentem Grund.

Add-Type -AssemblyName System.Drawing

$sizes = @(48, 96, 128)
$color = [System.Drawing.Color]::FromArgb(255, 124, 108, 255) # #7c6cff
$outDir = Join-Path (Split-Path $PSScriptRoot -Parent) "icons"

if (-not (Test-Path $outDir)) {
    New-Item -ItemType Directory -Path $outDir | Out-Null
}

foreach ($size in $sizes) {
    $bmp = New-Object System.Drawing.Bitmap($size, $size)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
    $g.Clear([System.Drawing.Color]::Transparent)

    $stroke = [Math]::Max(2, [int]($size * 0.10))
    $pen = New-Object System.Drawing.Pen($color, $stroke)
    $pen.StartCap = [System.Drawing.Drawing2D.LineCap]::Round
    $pen.EndCap = [System.Drawing.Drawing2D.LineCap]::Round

    $margin = [int]($size * 0.16)
    $diameter = $size - (2 * $margin)
    $g.DrawEllipse($pen, $margin, $margin, $diameter, $diameter)

    # Diagonale Linie von oben-links nach unten-rechts
    $offset = [int]($size * 0.29)
    $g.DrawLine($pen, $offset, $offset, $size - $offset, $size - $offset)

    $g.Dispose()
    $path = Join-Path $outDir "icon-$size.png"
    $bmp.Save($path, [System.Drawing.Imaging.ImageFormat]::Png)
    $bmp.Dispose()
    Write-Host "Erstellt: $path"
}
