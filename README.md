# ideckia: Hackable and open macro deck

## What is it for?

Control your computer (GNU/Linux, Windows, Mac) with a mobile client.

* Create multiple buttons to control your computer (run commands, control OBS, hotkeys, display weather...)
* Organize those buttons in different directories (developer, streamer, music, games...)

Download prebuilt binaries and a basic layout from [here](https://github.com/ideckia/ideckia/releases) (the server code is hosted [here](https://github.com/ideckia/ideckia_server)). The client app is [here](https://github.com/ideckia/mobile_client/releases).

## How to get it working

* Execute the downloaded binary for the computer. When it runs will show the IP and the port where the server is running. This port can be configured in the `app.props` file.
* Allow Ideckia in your firewall so it can be found by the mobile client in local network.
* Be sure to have the computer and the mobile client connected to the same network.
* Open up the client app. It will look for the server in the IP range 192.168.1.xxx and the 8888 port.
 * If it doesn't get any response from the server, it will show a screen to insert the IP and the port manually.
* You can configure your [layout](#layout-file) by hand or using the [editor](#editor)

### Linux users

#### Appindicator

As the application is headless, there is an icon in the systray. To show this icon Ideckia uses `libayatana-appindicator` library, which should be installed in the system. The app could be running even if there is no systray icon, but is preferable to have some feedback.

This library is installed by default in Ubuntu and derivates.

#### Communication port

The port used for communication between server and client may be closed. To open that port, execute this command:


`sudo ufw allow 8888/tcp comment 'Open port 8888 for Ideckia'` (Supposing Ideckia uses the port 8888)

## Concepts

* Layout: Bunch of _items_
* Item: An element that has a single or multiple _states_. It is clickable in the client.
* State: Definition of the item status: text, textColor, bgColor, icon and an _action_ list.
* Action: Action which will be fired (can be more than one in a state) in the host computer when the item is pressed in the client.

## Layout file

All the items and their actions are defined in a plain JSON file. [Here](./layout.json) is a basic one.

## Item

There can be two types of item:

* ChangeDir: When clicked goes to the folder with name specified by the `toDir` property. [Here](./layout.json#L81-L98) goes to the directory named `_main_`.
* States: When clicked executes the actions in order they are defined in the current `state` from `list` array. Actions array can be null or empty. After executing the actions and goes to the next element in `list`.
  * [Here](./layout.json#L29-L44) at the beginning the text shown will be `working` and the backgroud will be green. When clicked the state changes to `not working` and red background. When clicked again `working` and so on. No action will be executed.
  * [Here](./layout.json#L45-L65) will execute `counter` action every time is clicked.

### RichString

The text in the state can have different size, color and style (bold, italic, underline) parts. The format is `{transformer:text to transform}`. The _transformer_ can be:

* `b`: The `text to transform` will be **bold**
* `i`: The `text to transform` will be _italic_
* `u`: The `text to transform` will be underlined
* `color.colorName`: The `text to transform` will be rendered in `colorName` color.
* `size.fontSize`: The `text to transform` will be rendered in `fontSize` size.
* `emoji.unicode`: This one has no `:` since it doesn't apply to a text. Will render the emoji of the `unicode` value, multiple values can be separated with commas (`,`). For example `emoji.1F919,1F3FC`.

The transformers can be chained. For example:

```javascript
The text is {b:{i:{u:bold, italic and underlined}}}. And this text will be {color.red:{size.50:colored with red and BIG}}
```

### Dialogs

The actions have access to the server dialog system. This system interface is defined in the [API](https://github.com/ideckia/ideckia_api/blob/develop/api/dialog/IDialog.hx). An implementation based on [clialogs](https://github.com/ideckia/clialogs) is provided in the basic package of ideckia from [here](https://github.com/ideckia/dialogs-clialogs). This implementation is stored in `dialogs` folder next to the executable, where the application will look for it. It can be customized as you want, you can even create a new one.

### Media player

The actions have access to the server media player. This media player interface is defined in the [API](https://github.com/ideckia/ideckia_api/blob/develop/api/media/IMediaPlayer.hx). An implementation is provided in the basic package of ideckia from [here](https://github.com/ideckia/mediaplayer-rust). This implementation is stored in `media` folder next to the executable, where the application will look for it. It can be customized as you want, you can even create a new one.

## Actions

Actions sources are available in the `actions` folder usually (configurable via `app.props` file next to the executable). Every action is defined in it's own folder and an `index.js` file in it.

This `index.js` file must have [this structure](https://github.com/ideckia/ideckia_api#action-structure) to be called from the server when loaded and executed

```
|-- ideckia
|-- app.props
|-- layout.json
|-- actions
|   |-- my_action
|       |-- index.js
|   |-- another_action
|       |-- index.js
|       |-- dependencies.js
|       |-+ node_modules
```
### Default actions

* [Command](https://github.com/ideckia/action_command): Execute an application or shell file with given parameters 
* [Keymouse](https://github.com/ideckia/action_keymouse): **DEPRECATED** Create hotkeys, write strings, move the mouse... A wrapper for [RobotJs](http://robotjs.io/)
* [Keyboard](https://github.com/ideckia/action_keyboard): Create hotkeys, write strings... A wrapper for [NutJs](http://nutjs.dev/)
* [Counter](https://github.com/ideckia/action_counter): Count how many times the item is clicked. Can be a countdown too.
* [Random color](https://github.com/ideckia/action_random-color): Generate random color and show it in the item.
* [Stopwatch](https://github.com/ideckia/action_stopwatch): Executing this action, will start and pause a timer shown in the button itself.
* [OBS-websocket](https://github.com/ideckia/action_obs-websocket): **DEPRECATED** Control OBS via websockets. A wrapper for [obs-websocket-js](https://www.npmjs.com/package/obs-websocket-js)
* [Timezones](https://github.com/ideckia/action_timezones): Show the time in the configurated timezones.
* [Worklog](https://github.com/ideckia/action_worklog): Log you daily work in a plain json file.
* [FTP-Connect](https://github.com/ideckia/action_ftp-connect): Connect to FTP in a simple and fast way.
* [SSH-Connect](https://github.com/ideckia/action_ssh-connect): Connect to SSH in a simple and fast way.
* [Open weather](https://github.com/ideckia/action_open-weather): Show the weather in the configured towns.
* [Clementine control](https://github.com/ideckia/action_clementine-control): Control [Clementine](https://www.clementine-player.org/).
* [Mute mic](https://github.com/ideckia/action_mute-mic): Mute / unmute microphone.
* [Toot](https://github.com/ideckia/action_toot): Publish a toot in mastodon.
* [Wait](https://github.com/ideckia/action_wait): Waits given milliseconds until the next action.
* [Countdown](https://github.com/ideckia/action_countdown): Countdown timer
* [Log-in](https://github.com/ideckia/action_log-in): Writes username and password and presses 'Enter' (this action uses [Keyboard](https://github.com/ideckia/action_keyboard), it is mandatory).
* [Color-picker](https://github.com/ideckia/action_color-picker): Show in the item the color of the pixel where the mouse is.
* [Obs-control](https://github.com/ideckia/action_obs-control): Control OBS Studio (replacing former [obs-websocket action](https://github.com/ideckia/action_obs-websocket))
* [KeePasXC](https://github.com/ideckia/action_keepassxc): Gets all the username and passwords from a [KeePassXC](https://keepassxc.org/) database and creates an item for each. This action uses [Log-in](https://github.com/ideckia/action_log-in), it is mandatory.
* [Emoji](https://github.com/ideckia/action_emoji): Shows a random emoji every time is clicked
* [Memory](https://github.com/ideckia/action_memory): The classic memory game in your client

You don't like these actions? Change them or [create your own](#create-your-own-action) to fit your needs.

### Preset action properties

Next to the `index.js` file of each action can be a file called `presets.json` where are some predefined properties for that action. These properties will be loaded by the [editor](#editor).

## Ideckia commands

### Create your own action

Execute `ideckia --new-action` to create a new action from a existing template.
  * Select which template do you want to use as base. Current options Haxe and JavaScript
  * Select the name for the action.
  * Write a description for the action (optional).
  * A new folder is created in the actions folder with the name of you new action which contains the files from the selected template.
  * Don't forget that the created action must have [this structure](https://github.com/ideckia/ideckia_api#action-structure).

### Append layout

Execute `ideckia --append-layout another_layout.json` to append the layout defined in the given parameter to you current layout.

### Export directory

Execute `ideckia --export-dirs _main_,develop,gaming` to export directories named `_main_`, `develop` and `gaming` from the current layout to the file `{project root}/dirs.export.json`.

## Editor

Open your browser and go to [http://localhost:8888/editor](http://localhost:8888/editor) (the port is the one where the server is running).

### Customize editor

When serving the editor web, Ideckia looks for the each of the editor files (`index.html`, `style.css` and `app.js`) in the `editor` folder in the root of the project. If the file doesn't exists, it's loaded from the bundled app.

Loading files in this way, you can customize only the CSS creating a new file in the path `editor/style.css` next to the `ideckia` executable. The `index.html` and `app.js` files will be loaded from the app itself and the CSS file will be the newly created.

Or you can create an entire new editor ovewriting the three files :-).
