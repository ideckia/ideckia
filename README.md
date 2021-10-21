# ideckia: Hackable and open macro deck

## What is it for?

Control your computer (Linux, Windows, Mac) with a mobile client.

* Create multiple buttons to control your computer (run commands, control OBS, hotkeys, display weather...)
* Organize those buttons in different folders (developer, streamer, music, games...)

Download prebuilt binaries and a basic layout from [here](https://github.com/ideckia/ideckia/releases). The client app is [here](https://github.com/ideckia/mobile_client/releases).

## How to get it working

* Execute the downloaded binary for the computer. When it runs will show the IP and the port where the server is running.
* Be sure to have the computer and the mobile client connected to the same network.
* Open up the client app. It will look for the server in the IP range 192.168.1.xxx and the 8888 port.
 * If it doesn't get any response from the server, it will show a screen to insert the IP and the port manually.

## Concepts

* Layout: Bunch of _items_
* Item: An element that has a single or multiple _states_. It is clickable in the client.
* State: Definition of the item status: text, textColor, bgColor, icon and an _action_ list.
* Action: Action which will be fired (can be more than one in a state) in the host computer when the item is pressed in the client.

## Layout file

All the items and their actions are defined in a plain JSON file. [Here](./layout.json) is a basic one.

## Item

There can be three types of item:

* SwitchFolder: When clicked goes to the folder with name specified by the `toFolder` property. [Here](./layout.json#L81-L98) goes to the folder named `_main_`.
* States: When clicked executes the actions in order they are defined in the current `state` from `list` array. Actions array can be null or empty. After executing the actions and goes to the next element in `list`.
  * [Here](./layout.json#L29-L44) at the beginning the text shown will be `working` and the backgroud will be green. When clicked the state changes to `not working` and red background. When clicked again `working` and so on. No action will be executed.
  * [Here](./layout.json#L45-L65) will execute `counter` action every time is clicked.

## Actions

Actions are available in the `actions` folder usually (configurable via `app.props` file next to the executable). Every action is defined in it's own folder and an `index.js` file in it.

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
* [Counter](https://github.com/ideckia/action_counter): Count how many times you killed someone or how many times crashes your app.
* [Random color](https://github.com/ideckia/action_random-color): Generate random color and show it in the item.
* [Stopwatch](https://github.com/ideckia/action_stopwatch): Executing this action, will start and pause a timer shown in the button itself.
* [OBS-websocket](https://github.com/ideckia/action_obs-websocket): Control OBS via websockets. A wrapper for [obs-websocket-js](https://www.npmjs.com/package/obs-websocket-js)

Don't you like these actions? Change them or [create your own](#create-your-own-action) to fit your needs.

### Create your own action

Execute `ideckia --new-action` to create a new action from a existing template.
  * Select which template do you want to use as base. Current options Haxe and JavaScript
  * Select the name for the action.
  * A new folder is created in the actions folder with the name of you new action which contains the files from the selected template.
