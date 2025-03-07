$envFilePath = ".\.env"
if (Test-Path $envFilePath) {
    Get-Content $envFilePath | ForEach-Object {
        if ($_ -match "^(.*?)=(.*)$") {
            $name = $matches[1]
            $value = $matches[2]
            [System.Environment]::SetEnvironmentVariable($name, $value)
        }
    }
} else {
    Write-Output ".env file not found"
    exit
}

$maxAge = -([System.Environment]::GetEnvironmentVariable("MAX_AGE"))
$outputPath = [System.Environment]::GetEnvironmentVariable("OUTPUT_PATH")

# Get files older than MAX_AGE hours and delete them
Get-ChildItem -Path $outputPath -File | Where-Object { $_.LastWriteTime -lt (Get-Date).AddHours($maxAge) } | Remove-Item