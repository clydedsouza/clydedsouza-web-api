<#
.SYNOPSIS
  Generate JSON files from the project data contained in the projects folder.

.EXAMPLE
  .\Generate-API.ps1 -BaseDirectoryName projects -OutputFileName projects -IncludeSubfolders $false
  .\Generate-API.ps1 -BaseDirectoryName projects\pinned -OutputFileName pinned
#>

Param
(
    [Parameter(Mandatory = $true, HelpMessage = "Please enter a valid base directory")]
    $BaseDirectoryName,

    [Parameter(Mandatory = $true, HelpMessage = "Please enter a valid output filename")]
    $OutputFileName,

    $IncludeSubfolders = $true
)

# Import helper

. .\Generate-API-Helper.ps1


# Main starts here

Try {
    # Print inputs to the console so its visible in the pipeline
    printConsoleMessage -Message ("Base directory name: " + $BaseDirectoryName)  
    printConsoleMessage -Message ("Output file name: " + $OutputFileName)

    # Loop thru all markdown files in the given directory and generate a
    # comma separated list of file name along with their relative path to 
    # the base directory supplied 
    Get-ChildItem $BaseDirectoryName -Filter *.md -Recurse:$IncludeSubfolders | Foreach-Object {  
        $fullDirectoryPath = getRelativeDirectoryName -FullDirectoryPath $_.DirectoryName  -BaseDirectoryName $BaseDirectoryName
        $mdFilesCSV += appendFilename -FullDirectoryPath $fullDirectoryPath -Filename $_.Name
    }
    
    $mdFiles = getFilesFromCSV -filesCSV $mdFilesCSV  
    
    # Generate JSON files and run JSON Lint on the generated file
    ./node_modules/.bin/m2j $mdFiles -o output/$OutputFileName.json
    ./node_modules/.bin/jsonlint output/$OutputFileName.json
}
Catch {
    $ErrorMessage = $_.Exception.Message
    Write-Error "An error occured while generating the API" $ErrorMessage
    Break
}
