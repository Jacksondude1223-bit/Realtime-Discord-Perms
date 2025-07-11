
SetHttpHandler(function(req, res)
    if req.path:match("^/role%-sync$") and req.method == "POST" then
        req.setDataHandler(function(body)
            local data = json.decode(body or "{}")
            local discordId = data.discord_id
            local roles = data.roles

            if not discordId or type(roles) ~= "table" then
                res.send(json.encode({ success = false, error = "Invalid payload" }))
                return
            end

            for _, playerId in ipairs(GetPlayers()) do
                for _, identifier in ipairs(GetPlayerIdentifiers(playerId)) do
                    if identifier:find("discord:" .. discordId) then
                        TriggerClientEvent("ace_sync:updateLoadText", playerId, "✅ Roles updated in real-time!")
                        TriggerClientEvent("ace_sync:applyRoles", playerId, roles)
                        print("Updated roles for", GetPlayerName(playerId))
                    end
                end
            end

            res.send(json.encode({ success = true }))
        end)
    else
        res.send(json.encode({ status = "Invalid endpoint or method" }))
    end
end)
