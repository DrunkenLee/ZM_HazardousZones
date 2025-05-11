local HZServer = HazardousZones.Server
local HZUtils = HazardousZones.Shared.Utils

local function onClientCommand(module, command, playerObj, args)
    if module ~= "HazardousZones" then return end
    
    if getWorld():getGameMode() == "Multiplayer" then
        if isClient() then return end
        if playerObj:getAccessLevel() ~= "Admin" then return end
    end
    
    print(string.format("[HZ_CLIENT_CMD] command=%s, player=%s", command, playerObj:getUsername()))
    
    if command == "AddZone" then
        print("[HZ_CLIENT_CMD::ADD_ZONE] name="..args.zone.name)
        HZServer:addZone(args.zone, args.spawnZeds, args.zedCount)
    end
    
    if command == "AddRndZone" then
        print("[HZ_CLIENT_CMD::ADD_RND_ZONE] name="..args.zone.name)
        HZServer:addRndZone(args.zone, args.spawnZeds)
    end
    
    if command == "RemoveZone" then
        print("[HZ_CLIENT_CMD::REMOVE_ZONE] index="..tostring(args.index))
        HZServer:removeZone(args.index)
    end
    
    if command == "RemoveRndZone" then
        print("[HZ_CLIENT_CMD::REMOVE_RND_ZONE] index="..tostring(args.index))
        HZServer:removeZone(args.index, true)
    end
    
    if command == "EditZone" then
        print("[HZ_CLIENT_CMD::EDIT_ZONE] index="..tostring(args.zoneIndex))
        HZServer:editZone(args.zoneIndex, args.zoneData)
    end
    
    if command == "EditRndZone" then
        print("[HZ_CLIENT_CMD::EDIT_RND_ZONE] index="..tostring(args.zoneIndex))
        HZServer:editRndZone(args.zoneIndex, args.zoneData)
    end
    
    if command == "UpdateZones" then
        print("[HZ_CLIENT_CMD::UPDATE_ZONES]")
        HZServer:notifyClients() 
    end
    
    if command == "RemoteRemoveExposure" then
        print("[HZ_CLIENT_CMD::REMOTE_REMOVE_EXPOSURE] remotePlayer="..args.remotePlayer)
        HZServer:remoteRemovePlayerExposure(args.remotePlayer)
    end
    
    if command == "RemoteSetExposure" then
        print("[HZ_CLIENT_CMD::REMOTE_SET_EXPOSURE] remotePlayer="..args.remotePlayer..", type="..args.type..", value="..tostring(args.value))
        HZServer:remoteSetPlayerExposure(args)
    end
    
    if command == "ImportZones" then
        print("[HZ_CLIENT_CMD::IMPORT_ZONES]")
        HZServer:importZones(args)
    end
end

local function onServerEveryHours()
    if getWorld():getGameMode() == "Multiplayer" and not isServer() then return end
    
    if SandboxVars.HZ.RandomZones then
        HZServer:checkRandomZonesTimeout()
        HZServer:checkRandomZonesCreation()
    end
end

Events.OnClientCommand.Add(onClientCommand)
Events.EveryHours.Add(onServerEveryHours)