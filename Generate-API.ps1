Param
(
    [Parameter(Mandatory=$True, HelpMessage="Please enter a valid base directory")]
    $BaseDirectoryName,

    [Parameter(Mandatory=$True, HelpMessage="Please enter a valid output filename")]
    $OutputFileName
)

# List of helper functions

function printConsoleMessage {
    param ([string]$Message)
    return Write-Host "[INFO]" $Message -ForegroundColor Yellow
}

function getRelativeDirectoryName {
    param ([string]$FullDirectoryPath)
    return ".\" + $FullDirectoryPath.Substring($FullDirectoryPath.LastIndexOf($BaseDirectoryName)) + "\"
}

function getFilesFromCSV {
    param ([string]$filesCSV)  
    return $filesCSV.split(",") 
}  

# Main starts here

Try
{
    # Print inputs to the console so its visible in the pipeline
    printConsoleMessage -Message ("Base directory name: " + $BaseDirectoryName)  
    printConsoleMessage -Message ("Output file name: " + $OutputFileName)

    # Loop thru all markdown files in the given directory and generate a
    # comma separated list of file name along with their relative path to 
    # the base directory supplied
    Get-ChildItem $BaseDirectoryName -Recurse -Include *.md | Foreach-Object {     
        $fullDirectoryPath = getRelativeDirectoryName -FullDirectoryPath $_.DirectoryName 
        $mdFilesCSV += $fullDirectoryPath + $_.Name + ","
    }
    
    $mdFiles = getFilesFromCSV -filesCSV $mdFilesCSV  
    ./node_modules/.bin/m2j $mdFiles -o output/$OutputFileName.json
}
Catch
{
    $ErrorMessage = $_.Exception.Message
    Write-Error "An error occured while generating the API" $ErrorMessage
    Break
}
