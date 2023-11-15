param (
  [boolean]$deleteUnwantedRegistryValues = $true,
  [boolean]$createRegistryValues = $true,
  [boolean]$unpinUnwantedAppsFromTaskbar = $true,
  [array]$unpinApps = @(
    "Google Chrome.lnk"
    "C:\Users\GJBalaich\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\Microsoft Edge.lnk"
  )
)

function quit(){
  write-host('Closing program, press [Enter] to exit...') -NoNewLine
  $Host.UI.ReadLine()

  exit
}

function startUp(){
  Write-Host "Starting program...`n"
}

function deleteRegistryValues(){
  if($deleteUnwantedRegistryValues -eq $false){
    Write-Host "Skipping deletion of unwanted registry values per your parameters...`n" -ForegroundColor Magenta

    return
  }

  $deletePaths = @(
    "HKLM:\Software\Microsoft\Policies",
    "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies",
    "HKLM:\Software\Microsoft\Windows\CurrentVersion\WindowsStore\WindowsUpdate",
    "HKLM:\Software\Microsoft\WindowsSelfHost",
    "HKLM:\Software\Policies",
    "HKLM:\Software\WOW6432Node\Microsoft\Policies",
    "HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Policies",
    "HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\WindowsStore\WindowsUpdate"
    "HKLM:\Software\Microsoft\WindowsUpdate"
    "HKCU:\Software\Microsoft\Policies",
    "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies",
    "HKCU:\Software\Microsoft\Windows\CurrentVersion\WindowsStore\WindowsUpdate",
    "HKCU:\Software\Microsoft\WindowsSelfHost",
    "HKCU:\Software\Policies",
    "HKCU:\Software\WOW6432Node\Microsoft\Policies",
    "HKCU:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Policies",
    "HKCU:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\WindowsStore\WindowsUpdate"
    "HKCU:\Software\Microsoft\WindowsUpdate"
  )

  Write-Host "Deleting unwanted registry values..." -ForegroundColor Cyan

  foreach ($deletePath in $deletePaths){
    if(test-path $deletePath){
      Remove-Item -Path $deletePath -Recurse -Verbose
    }
  }
  
  foreach ($deletePath in $deletePaths){
    if(test-path $deletePath){
      Remove-Item -Path $deletePath -Recurse -Force -Verbose
    }
  }

  Write-Host "Unwanted registry values have been deleted.`n" -ForegroundColor Green
}

function createRegistryValues(){
  if($createRegistryValues -eq $false){
    Write-Host "Skipping creation of registry values per your parameters...`n"  -ForegroundColor Magenta

    return
  }

  [array]$createValues = @(
    [pscustomobject]@{
      path = "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System"
      property = "ConsentPromptBehaviorAdmin"
      propertyType = "DWord"
      propertyValue = 0
    },
    [pscustomobject]@{
      path = "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System"
      property = "EnableLUA"
      propertyType = "DWord"
      propertyValue = 1
    },
    [pscustomobject]@{
      path = "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System"
      property = "PromptOnSecureDesktop"
      propertyType = "DWord"
      propertyValue = 0
    },
    [pscustomobject]@{
      path = "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\WindowsUpdate"
      property = "DisableWindowsUpdateAccess"
      propertyType = "DWord"
      propertyValue = 0
    },
    [pscustomobject]@{
      path = "HKLM:\Software\Microsoft\WindowsUpdate\UX\Settings"
      property = "IsContinuousInnovationOptedIn"
      propertyType = "DWord"
      propertyValue = 1
    },
    [pscustomobject]@{
      path = "HKLM:\Software\Policies\Microsoft\Windows\WindowsUpdate\AU"
      property = "AUOptions"
      propertyType = "DWord"
      propertyValue = 3
    }
  )

  Write-Host "Creating registry values..." -ForegroundColor Cyan

  foreach ($createValue in $createValues){
    if(!(Test-Path $createValue.path)){
      New-Item -Path $createValue.path -Force -Verbose
      New-ItemProperty -Path $createValue.path -Name $createValue.property -PropertyType $createValue.propertyType -Value $createValue.propertyValue -Force -Verbose
    } else {
      $currentPropertyValue = (Get-ItemProperty -Path $createValue.path).$($createValue.property)

      if($currentPropertyValue -ne $createValue.propertyValue || $null -eq $currentPropertyValue){
        New-ItemProperty -Path $createValue.path -Name $createValue.property -PropertyType $createValue.propertyType -Value $createValue.propertyValue -Force -Verbose
      }
    }
  }

  Write-Host "Registry values have been created.`n" -ForegroundColor Green
}

function unpinUnwantedAppsFromTaskbar(){
  if($unpinUnwantedAppsFromTaskbar -eq $false){
    Write-Host "Skipping unpinning of unwanted apps from the taskbar per your parameters...`n" -ForegroundColor Magenta

    return
  }

  $pinnedAppsPath = "c:\users\$env:username\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar"

  Write-Host "Unpinning unwanted apps from the taskbar..." -ForegroundColor Cyan

  foreach ($unpinApp in $unpinApps){
    if(Test-Path "$pinnedAppsPath\$unpinApp"){
      Remove-Item -Path "$pinnedAppsPath\$unpinApp" -Force -Verbose
    }
  }
}

function main(){
  startup
  deleteRegistryValues
  createRegistryValues
  unpinUnwantedAppsFromTaskbar

  quit
}

Write-Host "Unpinning unwanted apps from the taskbar..."