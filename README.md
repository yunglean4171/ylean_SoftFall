# ylean_SoftFall
### The SoftFall script revolutionizes fall mechanics on your FiveM server, offering a dynamic new way to interact with gravity during gameplay. Compatible with the QBCore and ESX framework, SoftFall introduces strategic depth and thrilling new possibilities to player actions. Whether making daring leaps off buildings or venturing atop vertiginous heights, SoftFall ensures players can embark on such adventures with enhanced safety. The script's flexibility allows server administrators to configure whether an item is necessary for fall cushioning, accommodating various gameplay styles and preferences. This adaptability ensures that SoftFall fits seamlessly into any server's ecosystem, enhancing the experience for all players involved.


[![SoftFall_showcase](https://i.imgur.com/6zfe9Do.png)](https://youtu.be/hB390T8kK00)

## Features:
* The script is highly optimized,
* Resistant to cheating or abuse attempts by the player,
* Allows full customization:
  [config.lua](https://i.imgur.com/SQlEg7v.png)

## Requirements for ESX:
[OPTIONAL] - Add 'magic_shoes' item in database
## Requirements for QBC:
[OPTIONAL] - Add 'magic_shoes' item:
Go to qb-core/shared/item.lua and add an item
EXAMPLE:
```
 magic_shoes                     = { name = 'magic_shoes', label = 'Magic Shoes', weight = 100, type = 'item', image = 'newsbmic.png', unique = true, useable = true, shouldClose = true, combinable = nil, description = 'A Magic Cushion Shoes' },
```
  

# Contributing
If you have some ideas that you want to suggest please make a [pull requests](https://github.com/yunglean4171/ylean_SoftFall/pulls) and if you found some bugs please make an [issue](https://github.com/yunglean4171/ylean_SoftFall/issues). Every contribution will be appreciated.
