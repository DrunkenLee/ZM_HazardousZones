local HZUtils = HazardousZones.Shared.Utils
local HZ = HazardousZones.Client
local HZServer = HazardousZones.Server
local HZZonePresets = HazardousZones.Data.Presets

local function spawnZombiesInZone(zombieCount, zoneData)
    local crawler = ZombRand(100) > 75
    local isFallOnFront = ZombRand(100) > 90
    local isFakeDead = true
    local knockedDown = true
    local health = ZombRand(1, 5)
    local count = zombieCount or zoneData.radius
    local outfit = nil
    local femaleChance = ZombRand(1, 100)
    local radius = zoneData.radius

    if isClient() then
        local cmd = string.format("/createhorde2 -x %d -y %d -z %d -count %d -radius %d -crawler %s -isFallOnFront %s -isFakeDead %s -knockedDown %s -health %s -outfit %s ", zoneData.epicentre.x, zoneData.epicentre.y, zoneData.epicentre.z, count, radius, tostring(crawler), tostring(isFallOnFront), tostring(isFakeDead), tostring(knockedDown), tostring(health), outfit or "")
        SendCommandToServer(cmd)
        return
    end

    for i=1,count do
        local x = ZombRand(zoneData.epicentre.x - radius, zoneData.epicentre.x + radius + 1);
        local y = ZombRand(zoneData.epicentre.y - radius, zoneData.epicentre.y + radius + 1);
        local z = zoneData.epicentre.z
        addZombiesInOutfit(x, y, z, 1, outfit, femaleChance, crawler, isFallOnFront, isFakeDead, knockedDown, health);
    end
end

function HZServer:addZone(zoneData, spawnZombies, zombieCount)
    if not HZServer.Zones then return end

    print("[HZSERVER:ADD_ZONE] Zone added. name="..zoneData.name)

    table.insert(HZServer.Zones, zoneData)
    
    if spawnZombies then
       spawnZombiesInZone(nil, zoneData)
    end

    HZServer:notifyClients()
end

function HZServer:addRndZone(zoneData, spawnZombies, zombieCount)
    if not HZServer.RndZones then 
        return
    end

    print("[HZSERVER:ADD_RND_ZONE] Zone added. name="..zoneData.name)

    table.insert(HZServer.RndZones, zoneData)    
    HZServer:notifyClients()
end

function HZServer:editZone(zoneIndex, zoneDataNew)
    if not HZServer.Zones then return end
    if not HZServer.Zones[zoneIndex] then return end
    
    HZServer.Zones[zoneIndex] = zoneDataNew

    HZServer:notifyClients()
end

function HZServer:editRndZone(zoneIndex, zoneDataNew)
    if not HZServer.RndZones then return end
    if not HZServer.RndZones[zoneIndex] then return end
    
    HZServer.RndZones[zoneIndex] = zoneDataNew
    HZServer:notifyClients()
end

function HZServer:removeZone(index, isRndZone)    
    print("[HZSERVER:REMOVE_ZONE] index="..tostring(index)..", rnd="..tostring(isRndZone))
    if isRndZone then
        if not HZServer.RndZones or not HZServer.RndZones[index] then 
            print("No rnd zone found with index="..tostring(index)) 
            HZUtils:printTable(HZServer.RndZones)
            return
        end

        table.remove(HZServer.RndZones, index)
    else
        if not HZServer.Zones or not HZServer.Zones[index] then 
            print("No zone found with index="..tostring(index)) 
            HZUtils:printTable(HZServer.Zones)
            return 
        end
        
        table.remove(HZServer.Zones, index)
    end    
    
    HZServer:notifyClients()
end

function HZServer:removeAllZones()
    if not HZServer.Zones then return end

    HZServer.Zones = {}

    if isDebugEnabled() then
        print("[REMOVE ZONES] All zones have been removed.")
    end

    HZServer:notifyClients()
end

function HZServer:removeAllRandomZones()
    if not HZServer.RndZones then return end

    HZServer.RndZones = {}

    if isDebugEnabled() then
        print("[REMOVE RND ZONES] All random zones have been removed.")
    end

    HZServer:notifyClients()
end

function HZServer:checkRandomZonesTimeout()
    if not SandboxVars.HZ.RandomZones then return end
    
    for i, z in pairs(HZServer.RndZones) do
        local zone = HZServer.RndZones[i]

        if not zone then return end

        local currentTime = getGameTime():getWorldAgeHours()
        local isTimedOut = currentTime - zone.createdAt > SandboxVars.HZ.RandomZonesDuration

        if isTimedOut then
            print("[HZSERVER:CHECK_RND_ZONES:REMOVE] Zone is timed out, triggering removal. zone="..z.name)
            HZServer:removeZone(i, true)
        else
            print("[HZSERVER:CHECK_RND_ZONES:REMOVE] Zone is OK, no need to remove. zone="..z.name..", times out currentTime="..tostring(currentTime)..", createdAt="..tostring(zone.createdAt)..", limit="..tostring(SandboxVars.HZ.RandomZonesDuration)..", timesOutIn="..tostring(SandboxVars.HZ.RandomZonesDuration - (currentTime - zone.createdAt)))
        end
    end
end

function HZServer:checkRandomZonesCreation()
    if not SandboxVars.HZ.RandomZones then return end

    local currentZoneNum = HZUtils:getTableLength(HZServer.RndZones)

    if currentZoneNum >= SandboxVars.HZ.RandomZonesLimit then 
        if isDebugEnabled() then
          print("[HZSERVER:CHECK_RND_ZONES:CREATE] RandomZone creation failed, limit exceeded [limit="..tostring(SandboxVars.HZ.RandomZonesLimit)..", current="..tostring(currentZoneNum).."]")
        end
        return
      end
    
      if getGameTime():getHour() % SandboxVars.HZ.RandomZonesCheckInterval ~= 0 then 
        if isDebugEnabled() then
          print("[HZSERVER:CHECK_RND_ZONES:CREATE] RandomZone creation failed, creation check is limited to every "..tostring(SandboxVars.HZ.RandomZonesCheckInterval).." hour every day")
        end
        return
      end
    
      local d100 = ZombRand(1,100)
      local dc = SandboxVars.HZ.RandomZonesCreationDC
      
      if d100 <= dc then
        print("[HZSERVER:CHECK_RND_ZONES:CREATE] Creating random zone. [d100="..tostring(d100)..", dc="..tostring(dc).."]")
        local zone = HZUtils:createRandomZone()
        HZServer:addRndZone(zone, false, 0)
      else
        print("[HZSERVER:CHECK_RND_ZONES:CREATE] Random zone creation cancelled. [d100="..tostring(d100)..", dc="..tostring(dc).."]")
      end
end

function HZServer:notifyClients() 
    if isDebugEnabled() or isServer() then
        print("[CLIENTS:NOTIFY] Sending zone data to clients...")
    end

    ModData.transmit("HZ.Zones")
    ModData.transmit("HZ.RndZones")
end

function HZServer:remoteRemovePlayerExposure(remotePlayer)
    if getWorld():getGameMode() == "Multiplayer" then
        local onlinePlayers = getOnlinePlayers()

        for i = 0, onlinePlayers:size() - 1 do
            local player = onlinePlayers:get(i)
            if player then
                sendServerCommand(player, "HazardousZones", "RemoteRemovePlayerExposure", { remotePlayer = remotePlayer})
            end
        end
    else
    end
end

function HZServer:remoteSetPlayerExposure(args)
    if getWorld():getGameMode() == "Multiplayer" then
        local onlinePlayers = getOnlinePlayers()

        for i = 0, onlinePlayers:size() - 1 do
            local player = onlinePlayers:get(i)
            if player then
                sendServerCommand(player, "HazardousZones", "RemoteSetPlayerExposure", args)
            end
        end
    else
    end
end

function HZServer:importZones(args)
    print("=== IMPORTING ZONES ===")

    print(string.format("rndZones=%s importRndZones=%s", tostring(args.data.rndZones), tostring(args.importRndZones)))

    if not args.data.zones then
        print("[HZSERVER:IMPORT_ZONES] Import failed. Data is corrupted or does not exist.")
        return
    end

    if not args.data.rndZones then
        print("[HZSERVER:IMPORT_ZONES] No need to import random zones")
    end

    if args.removeZones then
        print("[HZSERVER:IMPORT_ZONES] Removing existing zones.")

        for k in pairs(HZServer.Zones) do HZServer.Zones[k] = nil end

        if args.data.rndZones and args.importRndZones then
            print("[HZSERVER:IMPORT_ZONES] Removing existing random zones.")
            for k in pairs(HZServer.RndZones) do HZServer.RndZones[k] = nil end
        end
    end
    
    print("[HZSERVER:IMPORT_ZONES] Adding zones.")

    for i, zone in pairs(args.data.zones) do
        HZServer:addZone(zone, false, 0)
    end

    if args.data.rndZones and args.importRndZones then
        print("[HZSERVER:IMPORT_ZONES] Adding random zones.")
        for i, rndZone in pairs(args.data.rndZones) do
            HZServer:addRndZone(rndZone, false, 0)
        end
    end
end

local function onInitGlobalModData()
    HZServer.Zones = ModData.getOrCreate("HZ.Zones")
    HZServer.RndZones = ModData.getOrCreate("HZ.RndZones")


    print("=== INIT GLOBAL MOD DATA ===")
    HZUtils:printTable(HZServer.Zones)

    if isServer() or getWorld():getGameMode() ~= "Multiplayer" then
        if HZUtils:getTableLength(HZServer.Zones) == 0 and SandboxVars.HZ.UsePresetsIfNoZones == true then
            print("=== ADDING PRESETS TO ZONE LIST BECAUSE ZONES ARE EMPTY ===")
            for i, z in pairs(HZZonePresets) do
                local zone = HZZonePresets[i]
                HZServer:addZone(zone, false, 0)
            end
        end
    end
end

Events.OnInitGlobalModData.Add(onInitGlobalModData)