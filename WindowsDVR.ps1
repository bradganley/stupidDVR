# Load the .env file
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

# Retrieve variables from environment
$outputPath = [System.Environment]::GetEnvironmentVariable("OUTPUT_PATH")
$rtspUrl = [System.Environment]::GetEnvironmentVariable("RTSP_URL")
$chunkSize = [System.Environment]::GetEnvironmentVariable("CHUNK_SIZE")
$maxAge = [System.Environment]::GetEnvironmentVariable("MAX_AGE")

# FFmpeg arguments for recording in 10-minute segments
$arguments = "-i $rtspUrl -c copy -f segment -segment_time $chunkSize -segment_format mp4 -strftime 1 " + $outputPath + "\%Y-%m-%d_%H-%M-%S.mp4"

# Start FFmpeg in the background
Start-Process ffmpeg -ArgumentList $arguments