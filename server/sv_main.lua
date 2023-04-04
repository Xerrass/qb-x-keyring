local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback("qb-x-keychain:getkeychain", function (source, cb, citizenid)
    MySQL.query('SELECT * FROM player_keychain WHERE citizenid = ?', {citizenid}, function(result)
        
        if result[1] then

            cb(result)
        else
            cb(nil)
        end
    end)
    
end)

RegisterServerEvent("qb-x-keychain:HangOntoKeychain", function (data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local keyname = data.key

    if Player.Functions.GetItemByName(keyname) ~= nil then
        MySQL.insert('INSERT INTO player_keychain (citizenid, key_name) VALUES (?, ?)', {Player.PlayerData.citizenid, keyname}, function(id)
            print(id)
        end)
        Player.Functions.RemoveItem(keyname, 1)
    end


end)

RegisterServerEvent("qb-x-keychain:GetOffKeychain", function (data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local keyname = data.key

    MySQL.query('DELETE FROM player_keychain WHERE citizenid = ? AND key_name = ? limit 1', {Player.PlayerData.citizenid, keyname}, function(result)
        if result then
            for i = 1, #result do
                local row = result[i]
                print(row.identifier, row.firstname, row.lastname)
            end
        end
    end)
    Player.Functions.AddItem(keyname, 1)
    
end)