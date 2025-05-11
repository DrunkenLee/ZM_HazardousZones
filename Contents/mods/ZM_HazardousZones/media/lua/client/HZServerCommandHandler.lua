local HZData = HazardousZones.Data
local HZUtils = HazardousZones.Shared.Utils

local function onServerCommand(module, command, arguments)
    if module ~= "HazardousZones" then return end
    if isServer() then return end

    print(string.format("[HZ_SERVER_CMD] command=%s", command))

    if command == "RemoteRemovePlayerExposure" then
        if getPlayer():getUsername() == arguments.remotePlayer then
            getPlayer():Say("All Exposures removed by an admin")
            HZ:removePlayerExposures("all")
        end
    end

    if command == "RemoteSetPlayerExposure" then
        if getPlayer():getUsername() == arguments.remotePlayer then
            HZ:setPlayerExposure(arguments.type, arguments.value)
        end
    end
end

local function onReceiveGlobalModData(modDataName, data)
    print("[HZ_RECEIVE_GLOBAL_MOD_DATA] name="..modDataName);
    
    if modDataName == "HZ.Zones" then
        HZData.Zones = data
    elseif modDataName == "HZ.RndZones" then
        HZData.RndZones = data
    end
end

Events.OnServerCommand.Add(onServerCommand)
Events.OnReceiveGlobalModData.Add(onReceiveGlobalModData)