local HZ = HazardousZones.Client
local HZUtils = HazardousZones.Shared.Utils
local HZData = HazardousZones.Data

local function onCollision(player, data)
    if isDebugEnabled() then

    end

    if not player:isGodMod() then
        HZ:increasePlayerExposure(data.zone, data.gradualModifier)
    end
end

local function _detectCollision(zones)
    local player = getPlayer(); if not player then return end
    local playerX = player:getX()
    local playerY = player:getY()
    local playerZ = player:getZ()

    local distanceFromEpicentre
    local isPlayerCollide = false

    if HZUtils:getTableLength(zones) then
        for i,zone in pairs(zones) do
            local zRadius = zone.radius
            local hazardType = zone.hazard.type

            distanceFromEpicentre = IsoUtils.DistanceTo(playerX, playerY, zone.epicentre.x, zone.epicentre.y)

            isPlayerCollide = distanceFromEpicentre < zRadius

            if isPlayerCollide then
                local gradualModifier = distanceFromEpicentre / zRadius
                local gain = (1 - gradualModifier) * 100

                if not zone.gradualExposure then
                    gain = zone.hazard.exposurePerInGameMinute * 6
                end

                local collision = {
                    zone = zone,
                    gain = gain,
                    gradualModifier = gradualModifier,
                    distanceFromEpicentre = distanceFromEpicentre
                }

                onCollision(player, collision)
                HZ:increaseGain(hazardType, gain);
            end
        end
    end
end

function HZ:detectCollision()
    _detectCollision(HZData.Zones)

    if SandboxVars.HZ.RandomZones then
    _detectCollision(HZData.RndZones)
    else

        return
    end
end
