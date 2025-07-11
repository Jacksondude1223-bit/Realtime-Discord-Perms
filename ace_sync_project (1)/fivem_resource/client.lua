
RegisterNetEvent("ace_sync:updateLoadText")
AddEventHandler("ace_sync:updateLoadText", function(text)
    SendNUIMessage({
        type = "updateText",
        content = text
    })
end)

RegisterNetEvent("ace_sync:applyRoles")
AddEventHandler("ace_sync:applyRoles", function(roles)
    print("Applied roles:", json.encode(roles))
    SendNUIMessage({
        type = "roleUpdate",
        roles = roles
    })
end)

AddEventHandler("onClientMapStart", function()
    TriggerServerEvent("ace_sync:getRoles")
end)
