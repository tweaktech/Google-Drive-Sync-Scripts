#Requires -Version 3.0

Set-Location "$PSScriptRoot"
Set-Alias rclone "X:\RClone\rclone.exe"

$Filter = @"
# Example filter rule file
- .DS_Store
- .Trashes/**
- /`$RECYCLE.BIN/**
- /My Settings/**
- /SettingsPackages/**
- desktop.ini
- Thumbs.db
- *.lnk
- *.url
- *.tmp
"@
$Filter | Out-File -FilePath ".\Filter.txt" -Encoding ascii

Import-Csv -Path ".\Users.csv" | ForEach {

  $Destination = "{0}'s {1}" -f $_.Name, 'Migrated Files'

  Write-Output "Uploading $($_.User)'s files from $($_.Path) to their Google Drive"
  rclone copy --drive-impersonate $_.User "$($_.Path)" gdrive:/$Destination --filter-from ".\Filter.txt" --log-file=".\Sync.log" --retries 3 --stats=30s --stats-log-level NOTICE

}