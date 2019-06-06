function printConsoleMessage {
    param 
    (
        [string]$Message
    )
    return Write-Host "[INFO]" $Message -ForegroundColor Yellow
}

function getRelativeDirectoryName {
    param 
    (
        [string]$FullDirectoryPath,
        [string]$BaseDirectoryName
    )
    return ".\" + $FullDirectoryPath.Substring($FullDirectoryPath.LastIndexOf($BaseDirectoryName)) + "\"
}

function getFilesFromCSV {
    param 
    (
        [string]$filesCSV
    )  
    return $filesCSV.split(",") 
}  

function appendFilename {
    param 
    (
        [string]$FullDirectoryPath,
        [string]$Filename
    )
    return $FullDirectoryPath + $Filename + ","
}  

