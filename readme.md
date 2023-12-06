# summary

Unpins unwanted apps from your taskbar at login.

# prerequisites

- PowerShell 7 must be installed for this program to function
- Install PowerShell 7 by using the following commmand in powershell or cmd
  - `winget install microsoft.powershell`
- Before the included script can execute at login, you must first enable running scripts on your pc.
- Run the following command in an _admin elevated_ instance of powershell
  - `set-executionpolicy remotesigned`

# configuration example

For the script to run at login, you must place a properly formatted `config.json` file in root of this repository/directory. Below is an example of what `config.json` should contain.

```json
{
  "unpinUnwantedAppsFromTaskbar": true,
  "unpinApps": [
    "Microsoft Edge",
    "Google Chrome",
    "Outlook",
    "Excel",
    "Word",
    "Company Portal",
    "Quick Assist"
  ]
}
```

### description of options

- unpinUnwantedAppsFromTaskbar - unpins specified apps from taskbar at login.
- unpinApps - an array of the apps you'd like to be unpinned from your taskbar.

# usage

- installation - right click `.install.bat` & run as admin
- run manually - right click `.run-manually.bat` & run as admin
- uninstallation - right click `.uninstall.bat` & run as admin
- note that if you remove or move the folder containing these files you'll need to run `.uninstall.bat` and then `.install.bat` again.
