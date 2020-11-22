. .\scripts\Generate-API-Helper.ps1

Describe 'getRelativeDirectoryName()' { 
    it 'handles a 1 level directory' {  
        $output = getRelativeDirectoryName "F:\Code\clydedsouza\projects-api\projects" "projects" 
        $output | Should -Be ".\projects\"
    }
    it 'handles a 2 level directory' { 
        $output = getRelativeDirectoryName "F:\Code\clydedsouza\projects-api\projects\pinned" "projects" 
        $output | Should -Be ".\projects\pinned\"
    }
}

Describe 'appendFilename()' { 
    it 'handles a valid directory and filename input' {  
        $output = appendFilename ".\projects\pinned\" "RoboHashAvatars.md"  
        $output | Should -Be ".\projects\pinned\RoboHashAvatars.md,"
    } 
    it 'handles when no directory name is supplied' {  
        $output = appendFilename "" "RoboHashAvatars.md"  
        $output | Should -Be "RoboHashAvatars.md,"
    } 
    it 'handles when no file name is supplied' {  
        $output = appendFilename ".\projects\pinned\" ""  
        $output | Should -Be ".\projects\pinned\,"
    } 
}

Describe 'getFileFilter()' { 
    it 'handles when no filter is applied' {  
        $output = getFileFilter -FileFilter ""  
        $output | Should -Be "*.md"
    }  
    it 'handles when pinned filter is applied' {  
        $output = getFileFilter -FileFilter ".pinned"  
        $output | Should -Be "*.pinned.md"
    } 
    it 'handles when unmaintained filter is applied' {  
        $output = getFileFilter -FileFilter ".unmaintained"  
        $output | Should -Be "*.unmaintained.md"
    } 
    it 'handles when star filter is applied' {  
        $output = getFileFilter -FileFilter ".star"  
        $output | Should -Be "*.star.md"
    } 
}