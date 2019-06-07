# Generate API files for different basic scenarios
#--------------------------------------------------------

.\Generate-API.ps1 -BaseDirectoryName portfolio -OutputFileName complete-portfolio 

.\Generate-API.ps1 -BaseDirectoryName portfolio\projects -OutputFileName all-projects 

.\Generate-API.ps1 -BaseDirectoryName portfolio\speaking -OutputFileName all-speaking 

.\Generate-API.ps1 -BaseDirectoryName portfolio\teaching -OutputFileName all-teaching 

.\Generate-API.ps1 -BaseDirectoryName portfolio -OutputFileName all-pinned -FilterTagForFiles .pin


# Generate API files for slightly complex scenarios
# Generate API files for each project year
#--------------------------------------------------------

$currentYear = Get-Date -Format yyyy
$projectStartYear = 2012
$projectExclusionYears = @(2014)
$projectYears = ($projectStartYear..$CurrentYear)

ForEach ($projectYear in $projectYears) { 
  $isThisExcluded = $projectExclusionYears -Contains $projectYear
  
  If($isThisExcluded){
    continue
  }

  $baseDirectory = "portfolio\projects\"+$projectYear
  .\Generate-API.ps1 -BaseDirectoryName $baseDirectory -OutputFileName $projectYear 
}
