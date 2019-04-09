#Requires -Version 3.0
#Requires -Module ActiveDirectory

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

$Params = @{
    Filter      = "Enabled -eq '$True' -and EmailAddress -like '*@example.net'"
    Properties  = 'Name', 'HomeDirectory', 'EmailAddress'
    SearchBase  = 'OU=Students,OU=Users,DC=example,DC=net'
    SearchScope = 'Subtree'
}

$Users = Get-ADUser @Params
$Users | ForEach {

  $Destination = "{0}'s {1}" -f $_.Name, 'Migrated Files'

  Write-Output "Uploading $($_.Name)'s files from $($_.HomeDirectory) to their Google Drive"
  rclone copy --drive-impersonate $_.EmailAddress "$($_.HomeDirectory)" gdrive:/$Destination --filter-from ".\Filter.txt" --log-file=".\Sync.log" --retries 3 --stats=30s --stats-log-level NOTICE

}