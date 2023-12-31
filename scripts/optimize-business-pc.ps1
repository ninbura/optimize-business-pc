param(
  [string]$testRelativePath = "c:\repos\optimize-business-pc"
)

function quit(){
  write-host('closing program, press [enter] to exit...') -NoNewLine
  $Host.UI.ReadLine()

  exit
}

function startUp(){
  Write-Host "Starting program...`n"
}

function getRelativePath(){
  try{
    $relativePath = $(Split-Path $PSScriptRoot -Parent)

    if($null -eq $relativePath){
      throw "Could not get relative path."
    }
  } catch {
    $relativePath = $testRelativePath
  }

  write-host "$relativePath" -ForegroundColor Red

  return $relativePath
}

function unpinUnwantedAppsFromTaskbar($unpinUnwantedAppsFromTaskbar, $unpinApps){
  if($unpinUnwantedAppsFromTaskbar -eq $false){
    Write-Host "Skipping unpinning of unwanted apps from the taskbar per your parameters...`n" -ForegroundColor Yellow

    return
  }

  $pinnedAppsPath = "c:\users\$env:username\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar"

  Write-Host "Unpinning unwanted apps from the taskbar..." -ForegroundColor Cyan

  foreach ($unpinApp in $unpinApps){
    if(Test-Path "$pinnedAppsPath\$unpinApp.lnk"){
      Remove-Item -Path "$pinnedAppsPath\$unpinApp.lnk" -Force -Verbose
    }

    try{
      ((New-Object -Com Shell.Application).NameSpace('shell:::{4234d49b-0245-4df3-b780-3893943456e1}').Items() | `
        Where-Object {$_.Name -eq $unpinApp}).Verbs() | `
        Where-Object {$_.Name.replace('&','') -match 'Unpin from taskbar'} | `
        ForEach-Object {$_.DoIt()}
    
      Write-Host "App '$unpinApp' has been unpinned from the taskbar." -ForegroundColor Magenta
    } catch {
      Write-Host "App '$unpinApp' could not be unpinned from the taskbar." -ForegroundColor Red
    }
  }

  Write-Host "Unwanted apps have been unpinned from the taskbar.`n" -ForegroundColor Green
}

function writeToLog($relativePath){
  $logPath = "$relativePath/optimize-business-pc.log"

  if(!(test-path $logPath)){
    New-Item -Path $logPath -ItemType File -Force -Verbose
  }

  $date = Get-Date -Format "yyyy/MM/dd HH:mm:ss"
  $logEntry = "[$date] - Script has run successfully.`n"

  Add-Content -Path $logPath -Value $logEntry -Verbose
}

function main(){
  startup
  $relativePath = getRelativePath
  $config = Get-Content -Path "$relativePath/config.json" -Raw | ConvertFrom-Json
  unpinUnwantedAppsFromTaskbar $config.unpinUnwantedAppsFromTaskbar $config.unpinApps
  writeToLog $relativePath
}

main