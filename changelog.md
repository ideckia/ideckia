* renamed action `keepassxc` to [keepassxc-entry](https://github.com/ideckia/action_keepassxc-entry/) to use the name for the new `keepassxc` action
* add [keepassxc action](https://github.com/ideckia/action_keepassxc): Load all the password saved in the keepassxc database and creates an item for each
* add [memory game](https://github.com/ideckia/action_memory): The tipical memory game in your client
* [editor] Reload action descriptors list when `actions` changes
* [editor] Bigger font size in action descriptions
* Generate dynamic directories from actions. Actions can now return a directory structure to create dynamic directories from an item click
* Added `ideckia.check-updates` to enable/disable checking updates for the server and actions
* Fix linux client open from tray
* Fix the haxe templates to copy hidden files
* Fix deleting old log files
* Icons now are sent cached to client avoiding duplicated base64 strings. Saves network traffic.