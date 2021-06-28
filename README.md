# ideckia: Hackable and open macro deck

## What is it for?

Control your computer (Linux, Windows, Mac) with a mobile client.

* Create multiple buttons to control your computer (open apps, control OBS, hotkeys...)
* Organize those buttons in different folders (deveoper, streamer, music, games...)

Download prebuilt binaries and a basic layout from [here](https://github.com/ideckia/ideckia/releases). The client app is [here](https://github.com/ideckia/mobile_client/releases).

### Hackable

These are the default actions:

* [Command](https://github.com/ideckia/action_command): Execute an application or shell file with given parameters 
* [Keymouse](https://github.com/ideckia/action_keymouse): Create hotkeys, write strings, move the mouse... A wrapper for [RobotJs](http://robotjs.io/)
* [Counter](https://github.com/ideckia/action_counter): Count how many times you killed someone or how many times crashes your app.
* [Random color](https://github.com/ideckia/action_random-color): Generate random color and show it in the item.
* [Clipboard](https://github.com/ideckia/action_clipboard): Executing this action, the defined value will store in the clipboard.
* [Stopwatch](https://github.com/ideckia/action_stopwatch): Executing this action, will start and pause a timer shown in the button itself.
* [OBS-websocket](https://github.com/ideckia/action_obs-websocket): Control OBS via websockets. A wrapper for [obs-websocket-js](https://www.npmjs.com/package/obs-websocket-js)

Don't you like the stock actions? Change them or [create your own](#create-your-own-action) to fit your needs.

## Concepts

* Layout: Bunch of _items_
* Item: An element that has a single or multiple _states_. It is clickable in the client.
* State: Definition of the item status: text, textColor, bgColor, icon and a _action_.
* Action: Action which will be fired in the host computer when the item is pressed in the client.

## Layout file

All the items and their actions are defined in a plain JSON file. [Here](https://github.com/ideckia/ideckia/blob/master/layout.json) is a basic one

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

### Create your own action

Execute `ideckia --new-action` to create a new action from a existing template.
  * Select which template do you want to use as base. Current options Haxe and JavaScript
  * Select the name for the action.
  * A new folder is created in the actions folder with the name of you new action which contains the files from the selected template.
