# summary

attemps to remove minor org locks, disables admin popup windows, and unpins unwanted apps from your taskbar at login.

# configuration example

for the script to run at login, you must place a properly formatted `config.json` file in root of this repository/directory. bleow is an example of what `config.json` should contain.

```json
{
  "deleteUnwantedRegistryValues": true,
  "createRegistryValues": true,
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

- deleteUnwantedRegistryValues - deletes registry values that prevent you from updating windows, controlling power options, among other minor orginaztion locks.
- createRegistryValues - creates registry values that allow you to update your computer, and disable admin requesting popups.
- unpinUnwantedAppsFromTaskbar - unpins specified apps from taskbar at login.
- unpinApps - an array of the apps you'd like to be unpinned from your taskbar.

# usage

- installation - right click `.install.bat` & run as admin
- run manually - right click `.run-manually.bat` & run as admin
- uninstallation - right click `.uninstall.bat` & run as admin
