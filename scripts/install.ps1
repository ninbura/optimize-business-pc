function quit(){
  write-host('closing program, press [enter] to exit...') -NoNewLine
  $Host.UI.ReadLine()

  exit
}

function getScriptPath(){
  $relativePath = $(Split-Path $PSScriptRoot -Parent)
  $scriptPath = "$relativePath/scripts/optimize-business-pc.ps1"

  return $scriptPath
}

function runScript($scriptPath){
  & $scriptPath
}

function registerScheduledTask($scriptPath){
  Register-ScheduledTask -TaskName "optimize-business-pc" -Trigger (New-ScheduledTaskTrigger -AtLogon) -Action (New-ScheduledTaskAction -Execute "pwsh" -Argument "-WindowStyle Hidden -Command `"& `"$scriptPath`"`"") -RunLevel Highest -Force;
}

function main(){
  $scriptPath = getScriptPath $scriptPath
  runScript $scriptPath
  registerScheduledTask $scriptPath
  
  quit
}

main