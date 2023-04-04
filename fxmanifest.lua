fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Xerrass#1993'
description 'A Heißts System for QB-Core'
version '0.0.1'

dependencies {
    'qb-core',
    'qb-radialmenu',
    'qb-menu'
}

shared_scripts { 
    'config.lua',
}

server_scripts {
    'server/sv_*.lua',
    '@oxmysql/lib/MySQL.lua'
}

client_scripts {
    'client/cl_*.lua',
}



