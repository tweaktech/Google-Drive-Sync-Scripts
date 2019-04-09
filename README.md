# Google Drive Sync Scripts

## About

The scripts in this repository are designed to perform a one-way sync of users' home directories to their Google Drive 'My Drives'.

The 'AD' script uses the [Get-ADUser](https://docs.microsoft.com/en-us/powershell/module/addsadministration/get-aduser?view=win10-ps) cmdlet to obtain the paths of the home directories to migrate, while the 'CSV' script will only migrate the home directories specified in the accompanying Users.csv file.

Please read the RClone [documentation](https://rclone.org/docs/) and edit the script(s) to suit your requirements *before* running them.

**Note**: No data is deleted from the home directories. It is only copied.

## Prerequisites

1. A service account with domain wide delegation for your G Suite domain. Instructions on how to set this up can be found here:

	https://github.com/ncw/rclone/blob/master/docs/content/drive.md#service-account-support

2. The latest version of RClone configured with a Google Drive 'remote' that has been setup with the service account file from step one.

	https://github.com/ncw/rclone/releases/latest

3. PowerShell v3.0+ and the Active Directory module (the latter is only required if using the AD script).
