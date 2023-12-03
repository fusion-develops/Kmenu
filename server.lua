
local state, ESX = GetResourceState('es_extended'), nil
if state == 'starting' or state == 'started' then 
    ESX = exports['es_extended']:getSharedObject()
end 

RegisterNetEvent('fusion:buy', function (menu, index)
    local data = Fusion[menu].Items[index]
    if not data then return end 
    if data.type == 'item' then 
        if ESX then 
            local xPlayer = ESX.GetPlayerFromId(source) 
            local price = data.price
            if price then 
                if xPlayer.getMoney() <= price then return end 
                xPlayer.removeMoney(price)
            end
            xPlayer.addInventoryItem(data.item, data.amount or 1)
        end 
    elseif data.type == 'weapon' then 
        if ESX then
            local xPlayer = ESX.GetPlayerFromId(source) 
            local price = data.price
            if price then 
                if xPlayer.getMoney() <= price then return end 
                xPlayer.removeMoney(price)
            end
            xPlayer.addWeapon(data.item, 99999)
        else
            GiveWeaponToPed(GetPlayerPed(source), joaat(data.item), 999999, false, true)
        end 
    end 
end)