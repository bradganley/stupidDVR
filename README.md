# Basic AF IP Camera Recording

## Overview
Dead-simple IP camera recording with FFmpeg. Chunks the video, deletes old files. No bloat.

## BASH Usage 

### 1. Configure `.env`
Copy `example.env` to `.env`:
```bash
cp example.env .env
```

Edit `.env` as needed:
```env
OUTPUT_PATH=/path/to/cathut
RTSP_URL=rtsp://admin:password@192.168.1.108:554/Streaming/Channels/101
CHUNK_SIZE=600
MAX_AGE=720
```

- **OUTPUT_PATH**: Where video chunks go.
- **RTSP_URL**: Your camera stream URL.
- **CHUNK_SIZE**: Video segment length in seconds (default: 600).
- **MAX_AGE**: Max file age in minutes before deletion (default: 720).

### 2. Make Scripts Executable
```bash
chmod +x start_recording.sh cleanup.sh
```

### 3. Start Recording
```bash
./start_recording.sh
```

### 4. Set Up Cleanup
Add to cron:
```bash
crontab -e
```
Add this line:
```bash
*/10 * * * * /path/to/cleanup.sh
```


## PowerShell Usage

### 1. Make Sure FFmpeg Is in PATH
Add FFmpeg to your system's PATH or update the `.env` file with the full path.

### 2. Start Recording
Run the `StartRecording.ps1` script:
```powershell
.\StartRecording.ps1
```

### 3. Set Up Cleanup
Use Task Scheduler to run `Cleanup.ps1` every 10 minutes:
1. Open Task Scheduler and create a new task.
2. Set the trigger to repeat every 10 minutes.
3. Set the action to run PowerShell with:
   ```powershell
   powershell.exe -File "C:\path\to\Cleanup.ps1"
   ```

## Prerequisites
- FFmpeg installed (`sudo apt install ffmpeg` for Linux, download for Windows).
- PowerShell (pre-installed on Windows, available on Linux).

## License
Do whatever you want.