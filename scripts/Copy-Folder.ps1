
Param
(
    [Parameter(Mandatory = $true, HelpMessage = "Please enter a valid base directory")]
    $SourceFolder = "portfolio", 

    [Parameter(Mandatory = $true, HelpMessage = "Please enter a valid base directory")]
    $DestinationFolder = "temp"
) 

# Remove existing SourceFolder, create new empty SourceFolder and then copy SourceFolder into DestinationFolder.
Remove-Item -LiteralPath $DestinationFolder -Force -Recurse
New-Item -ItemType directory -Path $DestinationFolder
Copy-Item -Path $SourceFolder -Filter "*.md" -Recurse -Destination $DestinationFolder -Container