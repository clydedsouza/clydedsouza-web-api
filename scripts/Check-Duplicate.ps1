<#
.SYNOPSIS
  Check if duplicate file names exist.

.EXAMPLE
  .\Check-Duplicate.ps1 -BaseDirectoryName portfolio
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

    $portfolioFilenamesCSV = ""
    $duplicatePortfolioFilenamesCSV = ""

    # Loop thru all markdown files in the given directory and if the current file name already exists, add it
    # to the duplicate CSV list. If duplicate CSV list contains any value, we'll throw an alert.
    Get-ChildItem $BaseDirectoryName -Filter $fileFilter  -Recurse:$IncludeSubfolders | Foreach-Object { 
        if (!$portfolioFilenamesCSV.Contains($_.Name)) {
          $portfolioFilenamesCSV += appendFilename -FullDirectoryPath "" -Filename $_.Name
        }
        else {
          $duplicatePortfolioFilenamesCSV += ($_.Name + " ")
        }        
    } 

    if ($duplicatePortfolioFilenamesCSV -notlike "") {
      Write-Error ($duplicatePortfolioFilenamesCSV + " already exists. Rename this file so all portfolio items have a unique filename.")
      exit 1
    }    
}
Catch {
    Write-Error "An error occured while generating the API" $_.Exception.Message
    exit 1
}
