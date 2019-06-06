. .\Generate-API-Helper.ps1

Describe 'getRelativeDirectoryName()' { 
    it 'handles a 1 level directory' {  
        $output = getRelativeDirectoryName "F:\Code\clydedsouza\projects-api\projects" "projects" 
        $output | Should Be ".\projects\"
    }
    it 'handles a 2 level directory' { 
        $output = getRelativeDirectoryName "F:\Code\clydedsouza\projects-api\projects\pinned" "projects" 
        $output | Should Be ".\projects\pinned\"
    }
}

Describe 'getFilesFromCSV()' { 
    it 'handles a valid CSV' {  
        $output = getFilesFromCSV ".\projects\pinned\RoboHashAvatars.md,.\projects\EmojiBadges.md" 
        $output[0] | Should Be ".\projects\pinned\RoboHashAvatars.md"
        $output[1] | Should Be ".\projects\EmojiBadges.md"
    } 
    it 'handles a valid CSV with a comma at the end' {  
        $output = getFilesFromCSV ".\projects\pinned\RoboHashAvatars.md,.\projects\EmojiBadges.md," 
        $output[0] | Should Be ".\projects\pinned\RoboHashAvatars.md"
        $output[1] | Should Be ".\projects\EmojiBadges.md"
        $output[2] | Should Be ""
    } 
}

Describe 'appendFilename()' { 
    it 'handles a valid directory and filename input' {  
        $output = appendFilename ".\projects\pinned\" "RoboHashAvatars.md"  
        $output | Should Be ".\projects\pinned\RoboHashAvatars.md,"
    } 
    it 'handles when no directory name is supplied' {  
        $output = appendFilename "" "RoboHashAvatars.md"  
        $output | Should Be "RoboHashAvatars.md,"
    } 
    it 'handles when no file name is supplied' {  
        $output = appendFilename ".\projects\pinned\" ""  
        $output | Should Be ".\projects\pinned\,"
    } 
}