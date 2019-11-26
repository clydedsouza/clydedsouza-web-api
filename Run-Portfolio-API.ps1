# Check if any portfolio item has duplicate names. Exit if one found.
#-----------------------------------------------------------------------------------

.\scripts\Check-Duplicate.ps1 -BaseDirectoryName portfolio
Write-Host "Checked for duplicates"


# Copy the portfolio folder into a temporary working directory
# We'll run some updates on the portfolio items before generating an API out of it
#-----------------------------------------------------------------------------------

.\scripts\Copy-Folder.ps1 -SourceFolder "portfolio" -DestinationFolder "temp"
Write-Host "Copied folder to destination"

.\scripts\Update-Portfolio.ps1 -BaseDirectoryName temp\portfolio 
Write-Host "Update portfolio items"


# Generate API files for different basic scenarios
#--------------------------------------------------------

.\scripts\Generate-API.ps1 -BaseDirectoryName temp\portfolio -OutputFileName complete-portfolio 
Write-Host "Generated complete portfolio JSON"

.\scripts\Generate-API.ps1 -BaseDirectoryName temp\portfolio\projects -OutputFileName all-projects 
Write-Host "Generated only projects JSON"

.\scripts\Generate-API.ps1 -BaseDirectoryName temp\portfolio\speaking -OutputFileName all-speaking 
Write-Host "Generated only speaking JSON"

.\scripts\Generate-API.ps1 -BaseDirectoryName temp\portfolio\teaching -OutputFileName all-teaching 
Write-Host "Generated only teaching JSON"

.\scripts\Generate-API.ps1 -BaseDirectoryName temp\portfolio\books -OutputFileName all-books
Write-Host "Generated only books JSON"

.\scripts\Generate-API.ps1 -BaseDirectoryName temp\portfolio -OutputFileName all-pinned -FilterTagForFiles .pin
Write-Host "Generated only pinned items JSON"


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

  $baseDirectory = "temp\portfolio\projects\"+$projectYear
  .\scripts\Generate-API.ps1 -BaseDirectoryName $baseDirectory -OutputFileName $projectYear 
}
Write-Host "Generated JSON for complex scenarios"


# Move the 'modified' portfolio folder from temp to output where it can get published
# Clean up working directory
#--------------------------------------------------------

Move-Item -Path "temp\portfolio" -Destination "output" 
Write-Host "Moved items to output folder"

Remove-Item -LiteralPath "temp" -Force -Recurse
Write-Host "Remove temp folder"