# URL to the ZIP file
$url = "https://github.com/kruj0/rustdesk/releases/download/main/rust.zip"

# Target path for download
$downloadPath = "C:\temp\rust.zip"

# Target path for extraction
$extractionPath = "C:\temp\rustdesk"

# Create the extraction directory if it doesn't exist
if (-not (Test-Path -Path $extractionPath)) {
    New-Item -Path $extractionPath -ItemType Directory
}

# Create a WebClient object
$webClient = New-Object System.Net.WebClient

# Download the ZIP file
$webClient.DownloadFile($url, $downloadPath)

# Dispose of the WebClient object
$webClient.Dispose()

# Extract the ZIP archive
Add-Type -AssemblyName System.IO.Compression.FileSystem
[System.IO.Compression.ZipFile]::ExtractToDirectory($downloadPath, $extractionPath)

# Get a list of executable files in the extraction directory
$executableFiles = Get-ChildItem -Path $extractionPath -Filter "*.exe"

if ($executableFiles.Count -gt 0) {
    # Execute the first executable file found in the directory
    $executableFile = $executableFiles[0].FullName
    Start-Process -FilePath $executableFile
    Write-Host "Executed the file: $executableFile"
} else {
    Write-Host "No executable files (*.exe) found in the extraction directory."
}

# Optional: Clean up the extracted directory if desired
# Remove-Item -Path $extractionPath -Recurse