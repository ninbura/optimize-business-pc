Unregister-ScheduledTask -TaskName "optimize-business-pc" -Confirm:$false

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

function unregisterScheduledTask($scriptPath){
  Unregister-ScheduledTask -TaskName "optimize-business-pc" -Confirm:$false
}

function main(){
  $scriptPath = getScriptPath $scriptPath
  unregisterScheduledTask $scriptPath

  write-host ""
  
  quit
}

main