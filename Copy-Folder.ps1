$sourceRoot = "portfolio"
$destinationRoot = "temp"

Remove-Item -LiteralPath $destinationRoot -Force -Recurse
New-Item -ItemType directory -Path $destinationRoot
Copy-Item -Path $sourceRoot -Filter "*.md" -Recurse -Destination $destinationRoot -Container