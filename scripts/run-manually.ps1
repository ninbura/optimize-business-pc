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

function main(){
  $scriptPath = getScriptPath $scriptPath
  runScript $scriptPath

  write-host ""
  
  quit
}

main