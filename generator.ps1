# Get the current working directory
$rootDirectory = $PWD

# Get immediate subfolders (one level deep)
$subfolders = Get-ChildItem -Directory -Path $rootDirectory

foreach ($subfolder in $subfolders) {
    # Exclude specific folder names
    $excludedFolders = @("ARCADE", "CPS1", "CPS2", "CPS3")
    
    if ($excludedFolders -notcontains $subfolder.Name) {
        # Set the working directory to the subfolder
        Set-Location -Path $subfolder.FullName

        # Define the input and output file paths for the current subfolder
        $inputFilePath = Join-Path -Path $PWD -ChildPath 'gamelist.xml'
        $outputFilePath = Join-Path -Path $PWD -ChildPath 'miyoogamelist.xml'

        if (Test-Path $inputFilePath) {
            # Load the XML content from the input file
            [xml]$xml = Get-Content $inputFilePath

            $nodesToDelete = @('desc', 'rating', 'genre', 'players', 'releasedate', 'developer', 'publisher', 'hash', 'thumbnail', 'genreid')

            foreach ($node in $nodesToDelete) {
                $xml.SelectNodes("//$node") | ForEach-Object { $_.ParentNode.RemoveChild($_) }
            }

            $gamesWithoutImage = $xml.SelectNodes("//game[not(image)]")
            foreach ($game in $gamesWithoutImage) {
                $newImage = $xml.CreateElement('image')
                $newImage.InnerText = 'no-img.png'
                $game.AppendChild($newImage)
            }

            # Save the modified XML content to the output file 'miyoogamelist.xml'
            $xml.Save($outputFilePath)

            Write-Host "Modified XML saved to $outputFilePath"
        } else {
            Write-Host "Input file 'gamelist.xml' not found in $subfolder."
        }

        # Return to the root directory
        Set-Location -Path $rootDirectory
    }
}

Write-Host "Processing complete."