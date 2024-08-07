# 🌉 Bridge
Documentation relating to the [myBridge](https://github.com/Emotion06/myBridge).

## 1. Installation
myBridge works only with VORP. 

To install myBridge:
- Drag and drop the resource into your resources folder
  - `myBridge`
- Add this ensure in your server.cfg
  ```
    ensure myBridge
  ```
- Now you can configure and translate the script as you like
  - `config.lua`
  - `translation.lua`
- At the end
  - Restart the server

## 2. Usage
Go to one of the configured black markets. There you can open the menu and buy and sell items and weapons, the more you sell, the more share you get from the black market until it possibly belongs to you and then only you can buy.

## 3. For developers
```lua
Config = {}

Config.DevMode = true
Config.Locale = 'en'
Config.Key = 0x760A9C6F -- LALT

Config.Setup = {
    coords = vector3(492.01, 1774.41, 182.5),
    item = 'dynamite',
    amount = 1,
    timer = 30000, -- in ms
}
```

## 3. Credits
Big thanks go to [BCC-Scripts](https://github.com/BryceCanyonCounty) the creator of the main script, since many servers already have a train script, but would like to go blow up the bridge, I have written out the functions and integrated them into a separate script.

Click here for the [original script](https://github.com/BryceCanyonCounty/bcc-train)