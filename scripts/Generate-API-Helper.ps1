function printConsoleMessage {
    [CmdletBinding()]
    param 
    (
        [string]$Message
    )
    return Write-Verbose ("[INFO]" + $Message)  
}

function getRelativeDirectoryName {
    param 
    (
        [string]$FullDirectoryPath,
        [string]$BaseDirectoryName
    )
    return ".\" + $FullDirectoryPath.Substring($FullDirectoryPath.LastIndexOf($BaseDirectoryName)) + "\"
}


function appendFilename {
    param 
    (
        [string]$FullDirectoryPath,
        [string]$Filename
    )
    return $FullDirectoryPath + $Filename + ","
}  

function getFileFilter {
    param 
    (
        [string]$FileFilter
    )
    return "*" + $FileFilter + ".md" 
}  

