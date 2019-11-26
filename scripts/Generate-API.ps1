<#
.SYNOPSIS
  Generate JSON files from the project data contained in the projects folder.

.EXAMPLE
  .\Generate-API.ps1 -BaseDirectoryName portfolio\projects -OutputFileName allprojects 
  .\Generate-API.ps1 -BaseDirectoryName portfolio -OutputFileName pinned -FilterTagForFiles .pin
#>

Param
(
    [Parameter(Mandatory = $true, HelpMessage = "Please enter a valid base directory")]
    $BaseDirectoryName,

    [Parameter(Mandatory = $true, HelpMessage = "Please enter a valid output filename")]
    $OutputFileName,

    $IncludeSubfolders = $true,

    $FilterTagForFiles = ""
)

# Import helper

. .\scripts\Generate-API-Helper.ps1

# Main starts here

Try {
    # Print inputs to the console so its visible in the pipeline
    # Suffix -verbose to the PS command to see these messages
    $consoleMessage = ("`n- Base directory name: " + $BaseDirectoryName + "`n- Output file name: " + $OutputFileName + `
            "`n- Include subfolders: " + $IncludeSubfolders + "`n- Only pinned projects: " + $OnlyPinnedProjects) 
    printConsoleMessage -Message $consoleMessage

    # File filter used to 
    $fileFilter = getFileFilter -FileFilter $FilterTagForFiles

    # Loop thru all markdown files in the given directory and generate a
    # comma separated list of file name along with their relative path to 
    # the base directory supplied 
    Get-ChildItem $BaseDirectoryName -Filter $fileFilter  -Recurse:$IncludeSubfolders | Foreach-Object {  
        $fullDirectoryPath = getRelativeDirectoryName -FullDirectoryPath $_.DirectoryName  -BaseDirectoryName $BaseDirectoryName
        $isProjectPrivate = $_.Name.StartsWith("_")
        
        if(!$isProjectPrivate){
          $mdFilesCSV += appendFilename -FullDirectoryPath $fullDirectoryPath -Filename $_.Name
        }        
    }
    
    $mdFiles = getFilesFromCSV -filesCSV $mdFilesCSV  
    
    # Generate JSON files and run JSON Lint on the generated file
    ./node_modules/.bin/m2j -o ./output/$OutputFileName.json $mdFiles
    ./node_modules/.bin/jsonlint ./output/$OutputFileName.json -q
}
Catch {
    $ErrorMessage = $_.Exception.Message
    Write-Error "An error occured while generating the API" $ErrorMessage
    Break
}
