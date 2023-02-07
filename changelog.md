* add [wait action](https://github.com/ideckia/action_wait): Delay (milliseconds) the execution of the next action
* add [log-in action](https://github.com/ideckia/action_log-in): Write username (optional) and password and press enter
* add [countdown action](https://github.com/ideckia/action_countdown): Countdown action
* add [color-picker action](https://github.com/ideckia/action_color-picker): Show in the item the color of the pixel where the mouse is
* add [obs-control action](https://github.com/ideckia/action_obs-control): Control OBS Studio (replacing former [obs-websocket action](https://github.com/ideckia/action_obs-websocket))
* add [keepassxc action](https://github.com/ideckia/action_keepassxc): Get write the username and password from [KeePassXC](https://keepassxc.org/)
* add [emoji action](https://github.com/ideckia/action_emoji): Shows a random emoji every time is clicked
* [editor] remove unnecessary "add-item" buton
* [editor] remove quotes from default values
* [editor] Export directories from layout
* [editor] Import and append a external layout to the current layout
* [editor] added "remove icon" button. Remove icons from layout itself and all the references
* [editor] Use default values when creating an action
* add icon to the dialogs
* added test_action.js script in the template
* New dialog system. Now is possible to create custom UIs!
* Support more image formats (Gif animations and text based emojis supported in client!)
* Added a basic media player to be used from actions
* added Action.enabled (enable and disable actions instead of removing them)
* added new field ItemState.extraData to send data from an action to others
* added 'warning' and 'calendar' to server.dialog
* add textPosition to item state
* add system tray support