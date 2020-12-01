<#
.SYNOPSIS
  Update the contents of portfolio items before generating an API.
  We use this to update the frontmatter like add relative URL.

.EXAMPLE
  .\Update-Portfolio.ps1 -BaseDirectoryName portfolio\projects  
  .\Update-Portfolio.ps1 -BaseDirectoryName portfolio -FilterTagForFiles .pin
#>

Param
(
    [Parameter(Mandatory = $true, HelpMessage = "Please enter a valid base directory")]
    $BaseDirectoryName, 

    $IncludeSubfolders = $true,

    $FilterTagForFiles = ""
)

# Import helper

Import-Module ".\scripts\Generate-API-Helper.psm1"

# Main starts here

Try {
    # Print inputs to the console so its visible in the pipeline
    # Suffix -verbose to the PS command to see these messages
    $consoleMessage = ("`n- Base directory name: " + $BaseDirectoryName + `
            "`n- Include subfolders: " + $IncludeSubfolders + "`n- Only pinned projects: " + $OnlyPinnedProjects) 
    printConsoleMessage -Message $consoleMessage

    # File filter used to 
    $fileFilter = getFileFilter -FileFilter $FilterTagForFiles

    # Loop thru all markdown files in the given directory and update the relative URL of that particular markdown file
    # Relative URL is used to locate where to find the markdown file given we have the base URL.
    Get-ChildItem $BaseDirectoryName -Filter $fileFilter  -Recurse:$IncludeSubfolders | Foreach-Object {  
        $fullDirectoryPath = getRelativeDirectoryName -FullDirectoryPath $_.DirectoryName  -BaseDirectoryName $BaseDirectoryName
        $fullFileName = $fullDirectoryPath + $_.Name
        $fullRelativeFileName = $fullFileName -replace '.\\temp\\','\'
        $fullRelativeFileName = $fullRelativeFileName -replace '\\','/'
       
        $replacedText = 'relativeURL: ' + $fullRelativeFileName 

        ((Get-Content -path $fullFileName -Raw) -replace "relativeURL: ''",$replacedText) | Set-Content -Path $fullFileName
    }
    
}
Catch {
    $ErrorMessage = $_.Exception.Message
    Write-Error "An error occured while generating the API" $ErrorMessage
    Break
}
