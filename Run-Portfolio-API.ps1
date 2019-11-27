Write-Host "=== Task started ==="

# Check if any portfolio item has duplicate names.
#-----------------------------------------------------------------------------------

.\scripts\Check-Duplicate.ps1 -BaseDirectoryName portfolio
Write-Host "Checked for duplicates..."


# Copy the portfolio folder into a temporary working directory
# We'll run some updates on the portfolio items before generating an API out of it
#-----------------------------------------------------------------------------------

.\scripts\Copy-Folder.ps1 -SourceFolder "portfolio" -DestinationFolder "temp"
Write-Host "Copied folder to destination..."

.\scripts\Update-Portfolio.ps1 -BaseDirectoryName temp\portfolio 
Write-Host "Updated portfolio items..."


# Generate API files for different basic scenarios
#--------------------------------------------------------

.\node_modules\.bin\processmd "temp/portfolio/**/*.{md}" --stdout --outputDir temp/portfoliooutput/allportfolio > allportfolio.json
Write-Host "Generated complete portfolio JSON..."

.\node_modules\.bin\processmd "temp/portfolio/projects/**/*.{md}" --stdout --outputDir temp/portfoliooutput/allprojects > allprojects.json
Write-Host "Generated only projects JSON..."

.\node_modules\.bin\processmd "temp/portfolio/speaking/**/*.{md}" --stdout --outputDir temp/portfoliooutput/allspeaking > allspeaking.json
Write-Host "Generated only speaking JSON..."

.\node_modules\.bin\processmd "temp/portfolio/teaching/**/*.{md}" --stdout --outputDir temp/portfoliooutput/allteaching > allteaching.json
Write-Host "Generated only teaching JSON..."

.\node_modules\.bin\processmd "temp/portfolio/books/**/*.{md}" --stdout --outputDir temp/portfoliooutput/allbooks > allbooks.json
Write-Host "Generated only books JSON..."

.\scripts\Copy-Pinned.ps1 -SourceDirectoryName temp\portfolio -FilterTagForFiles .pin
.\node_modules\.bin\processmd "temp/pinneditems/**/*.{md}" --stdout --outputDir temp/portfoliooutput/allpinned > allpinned.json
Write-Host "Generated only pinned items JSON..."


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

  $inputDirectory = "temp/portfolio/projects/"+$projectYear+"/**/*.{md}"
  $outputDirectory = "temp/"+$projectYear
  $outputFilename = "all"+$projectYear+".json"
  .\node_modules\.bin\processmd $inputDirectory --stdout --outputDir $outputDirectory > $outputFilename
}
Write-Host "Generated JSON for complex scenarios..."


# Move the 'modified' portfolio folder from temp to output where it can get published
# Clean up working directory
#--------------------------------------------------------

Move-Item -Path "temp\portfolio" -Destination "output" 
Write-Host "Moved items to output folder..."

Remove-Item -LiteralPath "temp" -Force -Recurse
Write-Host "Removed temp folder..."

Write-Host "=== Task complete ==="