<#
.SYNOPSIS
  Copy pinned items to a pinned folder

.EXAMPLE
  .\Copy-Pinned.ps1 -SourceDirectoryName temp\portfolio -FilterTagForFiles .pin
#>

Param
(
    [Parameter(Mandatory = $true, HelpMessage = "Please enter a valid base directory")]
    $SourceDirectoryName,

    $IncludeSubfolders = $true,
    
    $DestinationFolder = "temp\pinneditems",

    $FilterTagForFiles = ""
) 

# Import helper

Import-Module ".\scripts\Generate-API-Helper.psm1"

# Main starts here

Try {

  # Create a folder for pinned items
  New-Item -ItemType directory -Path $DestinationFolder | Out-Null

  # File filter used
  $fileFilter = getFileFilter -FileFilter $FilterTagForFiles
  
  # Loop thru all markdown files in the given directory and generate a
  # comma separated list of file name along with their relative path to 
  # the base directory supplied 

  Get-ChildItem $SourceDirectoryName -Filter $fileFilter -Recurse:$IncludeSubfolders | Foreach-Object {  
    $fullDirectoryPath = getRelativeDirectoryName -FullDirectoryPath $_.DirectoryName -BaseDirectoryName $SourceDirectoryName
    $mdFilesCSV =  $fullDirectoryPath+"\"+$_.Name
    Copy-Item -Path $mdFilesCSV -Filter "*.md" -Recurse -Destination $DestinationFolder -Container
  }
  
}
Catch {
  $ErrorMessage = $_.Exception.Message
  Write-Error "An error occured while generating the API" $ErrorMessage
  Break
}


