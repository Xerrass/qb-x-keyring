local QBCore = exports['qb-core']:GetCoreObject()
RegisterNetEvent('QBCore:Client:UpdateObject', function()
    QBCore = exports['qb-core']:GetCoreObject()
end)

RegisterNetEvent('qb-x-keychain:keychain', function()

    local src = source
    local Player = src
    local PlayerData = QBCore.Functions.GetPlayerData()

    
    
    QBCore.Functions.TriggerCallback('qb-x-keychain:getkeychain', function(result)
        local key_menu = {
            {
            header = "in der Tasche",
            icon = "fas fa-key",
            isMenuHeader = true,
            }
        }
        
        for index,key in pairs(Config.Keys) do
        
            if QBCore.Functions.HasItem(key.name) then
                local itemname = QBCore.Shared.Items[key.name]["label"]
                local item_description = QBCore.Shared.Items[key.name]["description"]

                key_menu[#key_menu+1] = {
                    header = itemname,
                    txt = item_description,
                    icon = "fas fa-arrow-down-to-square",
                    params = {
                        isServer = true,
                        event = "qb-x-keychain:HangOntoKeychain",
                        args = {
                            key = key.name
                        }
                    }
                }
            end
        end
        
        if result == nil then
            QBCore.Functions.Notify("Keine Schlüssel am Schlüsselbund", "error", 5000)
            key_menu[#key_menu+1] = {
                header = "Keine Schlüssel am Schlüsselbund",
                icon = "fas fa-key",
                isMenuHeader = true,
            }
        else
            key_menu[#key_menu+1] = {
                header = "am Schlüsselbund",
                icon = "fas fa-key",
                isMenuHeader = true,
            }
            for _, key in pairs(result) do
                print(key.key_name)
                key_menu[#key_menu+1] = {
                    
                    header = QBCore.Shared.Items[key.key_name]["label"],
                    txt = QBCore.Shared.Items[key.key_name]["description"],
                    icon = "fas fa-arrow-up-from-square",
                    params = {
                        isServer = true,
                        event = "qb-x-keychain:GetOffKeychain",
                        args = {
                            key = key.key_name
                        }
                    }
                }
            end
        end
        exports['qb-menu']:openMenu(key_menu)
    end, PlayerData.citizenid)

    
end)