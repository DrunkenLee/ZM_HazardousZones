if isServer() then
    return
end

local HZ         = HazardousZones.Client
local HZUtils    = HazardousZones.Shared.Utils
local HZConsts   = HazardousZones.Constants
local HZSettings = HazardousZones.Settings
local HZData     = HazardousZones.Data

local function calculateDamageByExposures()
    local playerExposures = HZ:getPlayerExposures()

    if not playerExposures then return end

    for hazardType, exposureValue in pairs(playerExposures) do
        local exposureEffectData = HZUtils:getEffectByExposure(hazardType, exposureValue)
        if (exposureEffectData == nil) then
            if isDebugEnabled() then

            end
        end
        if (exposureEffectData ~= nil and exposureEffectData.effect ~= nil and exposureEffectData.severity ~= "none") then
            if (isDebugEnabled()) then

            end
            HZ:executeEffect(exposureEffectData.effect)
        else
            -- no need to do anything
        end
    end
end

local function onGameBoot()

end

local function onGameStart()
    if isServer() then return end

    if isClient() then

        ModData.request('HZ.Zones')
        ModData.request('HZ.RndZones')
    else

        HazardousZones.Data.Zones = ModData.getOrCreate('HZ.Zones')
        HazardousZones.Data.RndZones = ModData.getOrCreate('HZ.RndZones')
    end
end

local function onCreatePlayer()
    if isDebugEnabled() then

    end
end

local function onEveryOneMinute()
    local player = getPlayer()

    HZ:resetGains()
    HZ:resetExpData()

    if player:isGodMod() or player:isDead() then
        if isDebugEnabled() then

        end
    else
        -- detecting collision and calculating damages
        HZ:detectCollision()
        calculateDamageByExposures()
    end

    local gains = HZ:getGains()
    HZUtils:setSoundAndMoodlesByGains(player, gains)
end

local function onEveryTenMinutes()
    local player = getPlayer()

    HZ:checkProtections(player)

    if isDebugEnabled() then

    end
end

local function onInitGlobalModData()
    if getWorld():getGameMode() ~= "Multiplayer" then

        HZData.Zones = ModData.getOrCreate("HZ.Zones")
        HZData.RndZones = ModData.getOrCreate("HZ.RndZones")
    end
end

local function onClothingUpdated(player)
    if HZUtils:isPlayerUseGasMask(player) then
        HZ:setGasMaskMoodle(1)
    else
        HZ:setGasMaskMoodle(0.5)
    end

    if HZUtils:isPlayerUseHazmatSuit(player) then
        HZ:setHazmatSuitMoodle(1)
    else
        HZ:setHazmatSuitMoodle(0.5)
    end
end

Events.OnClothingUpdated.Add(onClothingUpdated)
Events.OnCreatePlayer.Add(onCreatePlayer)
Events.OnGameBoot.Add(onGameBoot)
Events.OnGameStart.Add(onGameStart)
Events.EveryOneMinute.Add(onEveryOneMinute)
Events.EveryTenMinutes.Add(onEveryTenMinutes)
Events.OnInitGlobalModData.Add(onInitGlobalModData)