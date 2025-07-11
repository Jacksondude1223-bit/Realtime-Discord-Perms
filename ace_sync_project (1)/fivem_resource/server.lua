
RegisterNetEvent("ace_sync:getRoles")
AddEventHandler("ace_sync:getRoles", function()
    local src = source
    local ids = GetPlayerIdentifiers(src)
    local discordId

    for _, v in pairs(ids) do
        if string.sub(v, 1, string.len("discord:")) == "discord:" then
            discordId = string.sub(v, 9)
            break
        end
    end

    if not discordId then
        TriggerClientEvent("ace_sync:updateLoadText", src, "❌ Discord not linked")
        return
    end

    TriggerClientEvent("ace_sync:updateLoadText", src, "🔄 Fetching roles...")

    PerformHttpRequest("http://localhost:30120/role-sync/" .. discordId, function(statusCode, body, _)
        if statusCode ~= 200 or not body then
            TriggerClientEvent("ace_sync:updateLoadText", src, "❌ Failed to fetch roles (HTTP " .. statusCode .. ")")
            return
        end

        local data = json.decode(body)
        if data and data.roles and type(data.roles) == "table" then
            local count = #data.roles
            TriggerClientEvent("ace_sync:updateLoadText", src, ("✅ Applied %d roles"):format(count))
            TriggerClientEvent("ace_sync:applyRoles", src, data.roles)
        else
            TriggerClientEvent("ace_sync:updateLoadText", src, "⚠️ No roles found")
        end
    end, "GET", "", { ["Content-Type"] = "application/json" })
end)
