# ideckia: Hackable and open macro deck

## What is it for?

Control your computer (GNU/Linux, Windows, Mac) with a mobile client.

* Create multiple buttons to control your computer (run commands, control OBS, hotkeys, display weather...)
* Organize those buttons in different directories (developer, streamer, music, games...)

Download prebuilt binaries and a basic layout from [here](https://github.com/ideckia/ideckia/releases) (the server code is hosted [here](https://github.com/ideckia/ideckia_server)). The client app is [here](https://github.com/ideckia/mobile_client/releases).

## How to get it working

* Execute the downloaded binary for the computer. When it runs will show the IP and the port where the server is running. This port can be configured in the `app.props` file.
* Be sure to have the computer and the mobile client connected to the same network.
* Open up the client app. It will look for the server in the IP range 192.168.1.xxx and the 8888 port.
 * If it doesn't get any response from the server, it will show a screen to insert the IP and the port manually.
* You can configure your [layout](#layout-file) by hand or using the [editor](#editor)

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
```
### Default actions

* [Command](https://github.com/ideckia/action_command): Execute an application or shell file with given parameters 
* [Keymouse](https://github.com/ideckia/action_keymouse): Create hotkeys, write strings, move the mouse... A wrapper for [RobotJs](http://robotjs.io/)
* [Counter](https://github.com/ideckia/action_counter): Count how many times the item is clicked. Can be a countdown too.
* [Random color](https://github.com/ideckia/action_random-color): Generate random color and show it in the item.
* [Stopwatch](https://github.com/ideckia/action_stopwatch): Executing this action, will start and pause a timer shown in the button itself.
* [OBS-websocket](https://github.com/ideckia/action_obs-websocket): Control OBS via websockets. A wrapper for [obs-websocket-js](https://www.npmjs.com/package/obs-websocket-js)
* [Timezones](https://github.com/ideckia/action_timezones): Show the time in the configurated timezones.
* [Worklog](https://github.com/ideckia/action_worklog): Log you daily work in a plain json file.
* [FTP-Connect](https://github.com/ideckia/action_ftp-connect): Connect to FTP in a simple and fast way.
* [SSH-Connect](https://github.com/ideckia/action_ssh-connect): Connect to SSH in a simple and fast way.
* [Open weather](https://github.com/ideckia/action_open-weather): Show the weather in the configured towns.

You don't like these actions? Change them or [create your own](#create-your-own-action) to fit your needs.

### Create your own action

Execute `ideckia --new-action` to create a new action from a existing template.
  * Select which template do you want to use as base. Current options Haxe and JavaScript
  * Select the name for the action.
  * Write a description for the action (optional).
  * A new folder is created in the actions folder with the name of you new action which contains the files from the selected template.

### Preset actions

Next to the `index.js` file of each action can be a file called `presets.json` where are some predefined properties for that action. These properties will be loaded by the [editor](#editor).

## Editor

Open your browser and go to [http://localhost:8888/editor](http://localhost:8888/editor) (the port is the one where the server is running).

### Customize editor

When serving the editor web, Ideckia looks for the each of the editor files (`index.html`, `style.css` and `app.js`) in the `editor` folder in the root of the project. If the file doesn't exists, it's loaded from the bundled app.

Loading files in this way, you can customize only the CSS creating a new file in the path `editor/style.css` next to the `ideckia` executable. The `index.html` and `app.js` files will be loaded from the app itself and the CSS file will be the newly created.

Or you can create an entire new editor ovewriting the three files :-).
