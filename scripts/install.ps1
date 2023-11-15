# get the realtive path to this script
$relativePath = $(Split-Path $PSScriptRoot -Parent)

& "$realtivePath/scripts/optimize-business-laptop.ps1"

Register-ScheduledTask -TaskName "optimize-business-laptop" -Trigger (New-ScheduledTaskTrigger -AtLogon) -Action (New-ScheduledTaskAction -Execute "pwsh" -Argument "-WindowStyle Hidden -Command `'& `"$relativePath/install.ps1`"`'") -RunLevel Highest -Force;