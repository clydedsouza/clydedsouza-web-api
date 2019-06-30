<#
.SYNOPSIS
  Copy a source folder into the destination.

.EXAMPLE
  .\Copy-Folder.ps1 -SourceFolder "portfolio" -DestinationFolder "temp"
#>

Param
(
    [Parameter(Mandatory = $true, HelpMessage = "Please enter a valid base directory")]
    $SourceFolder = "portfolio", 

    [Parameter(Mandatory = $true, HelpMessage = "Please enter a valid base directory")]
    $DestinationFolder = "temp"
) 

# Create new empty SourceFolder and then copy SourceFolder into DestinationFolder.
New-Item -ItemType directory -Path $DestinationFolder | Out-Null
Copy-Item -Path $SourceFolder -Filter "*.md" -Recurse -Destination $DestinationFolder -Container