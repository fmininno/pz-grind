fx_version 'cerulean'

game 'gta5'

description 'PZ Grind'
author 'PZ-DEV'
lua54 'yes'
version '1.0' 

shared_scripts {
    '@es_extended/imports.lua',
	'@es_extended/locale.lua',
    '@ox_lib/init.lua',
	'cfg_grind.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/main.lua'
}

client_scripts {
    'client/main.lua'
}

escrow_ignore {
    'client/main.lua',
    'server/main.lua',
    'cfg_grind.lua',
}

dependency 'es_extended'