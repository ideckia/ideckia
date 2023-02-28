* Add a `.info` file to every action, dialogs and mediaplayer. With this information, the server is able to check if there is a newer version online and download it.
* Logs are now stored in files. The logs directory is confirable in `app.props` file by `ideckia.logs.path` property. The directory will be accessible from the tray.
* Old logs will be deleted automatically after days defined in `ideckia.logs.days-of-life` property. If you want to keep them, give a negative value.
* Renamed `ideckia.log-level` property to `ideckia.logs.level`.
* Added `ideckia.client-path` in `app.props` in case you want to add a PC client path. It will be accessible from the tray.
* All actions will be reloaded if a change is detected in the actions directory.
* [editor] fix for null ActionDescriptor.props
* Added an plain JS asset in the [ideckia_server releases](https://github.com/ideckia/ideckia_server/releases) with no bundled NodeJs.
* Updated [tray](https://github.com/ideckia/tray) version to load the tray menu from a JSON
* Added 'About' item to tray to show some info about the application