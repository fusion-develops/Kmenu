for menu, data in pairs(Fusion) do 
    lib.addKeybind({
        name = 'menu'.. menu,
        description = 'Combat Menu',
        defaultKey = data.keybind,
        onPressed = function()
            for i = 1, #data.Locations do 
                local Location = data.Locations[i]
                if #(GetEntityCoords(cache.ped) - Location.coords) <= Location.radius then 
                    lib.showMenu('menu'.. menu)
                    return
                end 
            end 
        end,
    })

    local options = {}

    if data.Teleports then 
        local index = #options+1
        options[index] = {label = 'Teleports', menu = 'Teleports'}
        lib.registerMenu({
            id = 'menu'.. 'menu'.. menu.. options[index].menu,
            title = menu .. 'Menu',
            options = data.Teleports                      
        }, function (selected)
            SetEntityCoords(cache.ped, data.Teleports[selected].coords)
        end)
    end 

    if data.Items then 
        local index = #options + 1
        options[index] = {label = 'Items', menu = 'Items'}
        lib.registerMenu({
            id = 'menu'.. 'menu'.. menu.. options[index].menu,
            title = menu .. 'Menu',
            options = data.Items                      
        }, function (selected)
            TriggerServerEvent('fusion:buy', menu, selected)
        end)
    end

    lib.registerMenu({
        id = 'menu'.. menu,
        title = menu .. 'Menu',
        options = options                      
    }, function (selected)
        lib.showMenu('menu'.. menu.. options[selected].menu)
    end)

end 