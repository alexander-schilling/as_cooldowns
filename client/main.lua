ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(100)
	end
end)

function GetCooldown(cb, type, format)
	ESX.TriggerServerCallback('as_cooldowns:getCooldown', function(cooldown)
		cb(cooldown)
	end, type, format)
end

function GetTime(cb, type, format)
	ESX.TriggerServerCallback('as_cooldowns:getTime', function(time)
		cb(time)
	end, type, format)
end

RegisterNetEvent('as_cooldowns:getCooldown')
AddEventHandler('as_cooldowns:getCooldown', function(cb, type, format)
	GetCooldown(function(cooldown)
		cb(cooldown)
	end, type, format)
end)

RegisterNetEvent('as_cooldowns:getTime')
AddEventHandler('as_cooldowns:getTime', function(cb, type, format)
	GetTime(function(cooldown)
		cb(cooldown)
	end, type, format)
end)

if Config.Debug then
	RegisterCommand('testgetcooldown', function(source, args, rawCommand)
		GetCooldown(function(cooldown)
			print(cooldown)
		end, args[1], args[2])
	end, false)
	
	RegisterCommand('testgettime', function(source, args, rawCommand)
		GetTime(function(time)
			print(time)
		end, args[1], args[2])
	end, false)
end
