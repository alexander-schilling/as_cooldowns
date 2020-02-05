fx_version 'adamant'

game 'gta5'

description 'Cooldown system, developed by Alepra: https://github.com/alexander-schilling'

version '1.0'

client_scripts {
	'config.lua',
	'shared/main.lua',
	'client/main.lua'
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'config.lua',
	'shared/main.lua',
	'server/main.lua'
}

exports {
	'CooldownToTable',
	'CooldownToString',
	'GetCooldown',
	'GetTime'
}

server_exports {
	'CooldownToTable',
	'CooldownToString',
	'TimeToString',
	'TimeToTable',
	'GetCooldown',
	'GetCooldownWithFormat',
	'GetTimeWithFormat',
	'SetCooldown'
}

dependencies {
	'mysql-async',
	'es_extended'
}
