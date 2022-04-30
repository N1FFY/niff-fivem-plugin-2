# qb-drugdealing
## Description:

QB-Target based drug selling system allowing players to sell drugs to any pedestrians on the street. Fully configurable with more options coming soon, qb-dispatch and linden_outlawalert support



## Features:
- Easy Installation
- QB-Target based, all peds interactable
- QB-Dispatch Support.
- Linden_Outlawalert support.
- Allows for unlimited drug types.
- Configurable prices and amount sold.
- Configurable alert notifications.
- Runs at 0.00 ms idle and in use except when listening for keypress

## Dependencies:
[QB-Target](https://github.com/BerkieBb/qb-target)

[qb-lock](https://github.com/Nathan-FiveM/qb-lock)

## Installation:
Under qb-target/init.lua look for Config.GlobalPedOptions and add the code below :)
```
Config.GlobalPedOptions = {
	options = {
		{
			type = "client",
			event = "niff-selldrugs:client:selldrugs",
			icon = "fa-solid fa-cannabis",
			label = "Sell Drugs",
		},
	},
	distance = 5,
}
```
For the moneywash minigame
```
	['acetone'] 			 = {['name'] = 'acetone', 				['label'] = 'Acetone', 	 			['weight'] = 500, 		['type'] = 'item', 		['image'] = 'REPLACE.png', 		['unique'] = true, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Acetone used for things...'},
	['primer'] 			 = {['name'] = 'primer', 				['label'] = 'Ink Primer', 	 			['weight'] = 500, 		['type'] = 'item', 		['image'] = 'REPLACE.png', 		['unique'] = true, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Primes the ink for  the final product ;)'},


```
