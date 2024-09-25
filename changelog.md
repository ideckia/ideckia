* Directories can now have different background color
* renamed IdeckiaServer to IdeckiaCore (moved repository to [ideckia_core](https://github.com/ideckia/ideckia_core/) )
* [mobile_client] Addes swipe gestures to change directories (left-to-right to previous dir / top-to-bottom to main dir)
* rewrite of [obs-control](https://github.com/ideckia/action_obs-control/) to create scenes and items buttons automatically
* add [system-info](https://github.com/ideckia/action_system-info/) to show system information in the item (powered by [systeminformation](https://systeminformation.io))
* add [nuclear-control](https://github.com/ideckia/action_nuclear-control/) to control the [nuclear music player](https://nuclear.js.org/)
* [editor] added 'create new action' button.
* [editor] show dynamic templates to create actions.
* [editor] show the IdeckiaAction.status with an icon.
* [editor] get the IdeckiaAction.descriptor of each instance of the action. This makes possible to give different properties for each action instance.
* [editor] the editor is now localizable (localizations are taken from `loc/xx.txt` where `xx` is the locale code).
* [editor] show passwords in password input instead of plain text
* [tray] the tray is now localizable (localizations are taken from `loc/xx.txt` where `xx` is the locale code).
* [ideckia_api] now IdeckiaAction.getActionDescriptor() returns a Promise.
* [ideckia_api] added IdeckiaAction.getStatus(), IdeckiaAction.show(currentState) and IdeckiaAction.hide().
* [ideckia_api] updated IDialog.selectFile and IDialog.saveFile adding a new 'openDirectory' optional parameter to open the dialog in the given directory.
* [ideckia_api][hx] added api.data.Loc to make the localizations easier.
* [ideckia_api] added IdeckiaCore.getCurrentLocale() adding the possibility to localize the actions based on the locale configured for the app.
* [ideckia_api] Forward some methods for Actions for handling file contents (json, plain, localizations...).
* [ideckia_api][hx] added api.action.Data.getLocalizations to centralize localizations loading for the core and the actions
* [ideckia_api][hx] Compilation stops if the embedding files are not found
* [app.props] added `ideckia.locale`. This is used to set the locale of the app
* [app.props] added `ideckia.actions-load-timeout-ms`. This is used when called action.init and action.show to limit the time of waiting response.
* [app.props] added `ideckia.actions-reload-delay-ms`. This is used when a change is detected in actions folder. Ideckia will wait the given milliseconds before reloading all actions.
* [app.props] added `ideckia.password-input-names`. This is used to identify action properties that should be hidden like a password. Default: password,pwd.