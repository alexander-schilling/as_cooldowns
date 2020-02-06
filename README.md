# as_cooldowns
Simple cooldown system for FiveM using ESX and mysql-async

## Requirements
[ES Extended](https://github.com/ESX-Org/es_extended)

## Installation
- Put the resource in your `resources` folder.
- I recommend to start this resource in your `server.cfg` before the ones that will use the cooldowns.
- [Setup your scripts](#Usage), and you are ready to go.

## Configuration
- `Config.Debug`: `false` by default.
  - `true`: it will show messages in your console when a event is called and when changes are made in the database, it also adds commands to test some functions, you can easily delete them if you want.
  - `false`: messages will not appear in your console and commands will not be created.
- `Config.InexistentCooldownStartsAt0`: `false` by default.
  - `true`: inexistent cooldowns will return 0.
  - `false`: inexistent cooldowns will return the current time.
- `Config.RegisterSetCooldown`: `false` by default, I strongly recommend that this stays in false, use the export from server side.
  - `true`: it will mean that the event `as_cooldowns:setCooldown` can be triggered by clients.
  - `false`: the only way to set cooldowns from other resources is to use the export.
- `Config.DateFormat`: format the date in the function TimeToString(time): '%d': day; '%m': month; '%Y': year; '%y': short year.
  - Example: { '%d', '%m', '%Y' } will produce '20/05/2020'
  - More info: https://www.lua.org/pil/22.1.html

## Usage

### GetCooldown
Returns the cooldown (time - current time) of a registered cooldown.
Parameters after the callback:
- `type`: name of the registered cooldown.
- `format`: optional
  - `'string'`: returns the cooldown in [string format](#CooldownToString).
  - `'table'`: returns the cooldown as a [table](#CooldownToTable).
#### Export
##### Client and server side
```lua
function myFunction()
    exports.as_cooldowns:GetCooldown(function(cooldown)
        if cooldown > 0 then
            print(string.format('You need to wait %s seconds before robbing this shop again', cooldown))
        else
            -- Do stuff
        end
    end, 'robbery_shop')
end
```
#### Event
##### Client and server side
```lua
function myFunction()
    TriggerEvent('as_cooldowns:getCooldown', function(cooldown)
        if cooldown > 0 then
            print(string.format('You need to wait %s seconds before robbing this shop again', cooldown))
        else
            -- Do stuff
        end
    end, 'robbery_shop')
end
```
#### ESX Server Callback
##### Client side
```lua
function myFunction()
    ESX.TriggerServerCallback('as_cooldowns:getCooldown', function(cooldown)
        if cooldown > 0 then
            print(string.format('You need to wait %s seconds before robbing this shop again', cooldown))
        else
            -- Do stuff
        end
    end, 'robbery_shop')
end
```

### GetTime
Returns the time in Epoch of a registered cooldown.
Parameters after the callback:
- `type`: name of the registered cooldown.
- `format`: optional
  - `'string'`: returns the time in [string format](#TimeToString).
  - `'table'`: returns the time as a [table](#TimeToTable).
#### Export
##### Client and server side
```lua
function myFunction()
    exports.as_cooldowns:GetTime(function(time)
        print(string.format('Cooldown ends at %s', time))
    end, 'robbery_shop', 'string')
end
```
#### Event
##### Client and server side
```lua
function myFunction()
    TriggerEvent('as_cooldowns:getTime', function(time)
        print(string.format('Cooldown ends at %s', time))
    end, 'robbery_shop', 'string')
end
```
#### ESX Server Callback
##### Client side
```lua
function myFunction()
    ESX.TriggerServerCallback('as_cooldowns:getTime', function(cooldown)
        print(string.format('Cooldown ends at %s', time))
    end, 'robbery_shop', 'string')
end
```

#### SetCooldown
Sets or registers the cooldown.
Parameters:
- `type`: name to register for the cooldown.
- `cooldown`: time of the cooldown (in seconds).
##### Export
###### Server side
```lua
function myFunction()
    exports.as_cooldows:SetCooldown('robbery_shop', os.time() + 3600)
end
```
##### Event
[Only if you enable it](#Configuration)
###### Client side
```lua
function myFunction()
    TriggerServerEvent('as_cooldowns:setCooldown', 'robbery_shop', os.time() + 3600)
end
```
###### Server side
```lua
function myFunction()
    TriggerEvent('as_cooldowns:setCooldown', 'robbery_shop', os.time() + 3600)
end
```

### Utils
#### CooldownToTable
Returns a table with the remaining time of the cooldown, the table returns this values:
- `isNegative`: `true/false` self explanatory.
- `days`: remaining days.
- `hours`: remaining hours.
- `minutes`: remaining minutes.
- `seconds`: remaining seconds.
##### Export
###### Client and server side
```lua
function myFunction(cooldown)
    local myTable = exports.as_cooldowns:CooldownToTable(cooldown)
    if myTable.isNegative then
        print(string.format('Cooldown has passed current time'))
    end
end
```
#### CooldownToString
Returns a string with format, example output: `1:12:55:42`.
##### Export
###### Client and server side
```lua
function myFunction(cooldown)
    local myString = exports.as_cooldowns:CooldownToString(cooldown)
    print(myString)
end
```
#### TimeToString
Returns a string with [format](#Configuration), example output: `24/12/2020 23:59:50`.
##### Export
###### Server side
```lua
function myFunction(myTime)
    local myString = exports.as_cooldowns:TimeToString(myTime)
    print(myString)
end
```
#### TimeToTable
Returns a table with the format of [`os.date("*t", time)`](https://www.lua.org/pil/22.1.html).
##### Export
###### Server side
```lua
function myFunction(myTime)
    local myTable = exports.as_cooldowns:TimeToTable(myTime)
    print(myTable.day)
end
```
