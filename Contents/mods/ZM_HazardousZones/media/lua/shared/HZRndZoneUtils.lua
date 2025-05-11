local HZ = HazardousZones.Client
local HZUtils = HazardousZones.Shared.Utils
local HZData = HazardousZones.Data

function HZUtils:createRandomZone()
  local square = HZUtils:getRandomEpicentre()
  local radius = ZombRand(10,250)
  local hazardType
  local exposureValue

  if SandboxVars.HZ.RandomZonesType == 1 then
      if ZombRand(100) > 50 then
          hazardType = "radiation"
      else
          hazardType = "biological"
      end
  elseif SandboxVars.HZ.RandomZonesType == 2 then
      hazardType = "radiation"
  else 
      hazardType = "biological"
  end

  exposureValue = SandboxVars.HZ.RandomZonesExposureLimit

  if exposureValue == 0 then 
      exposureValue = ZombRand(5,100)
  end

  local zoneData = {
      name = getRandomUUID(),
      epicentre = {
        x = square.x,
        y = square.y,
        z = square.z
      },
      radius = SandboxVars.HZ.RandomZonesRadius,
      hazard = {
        type = hazardType,
        exposurePerInGameMinute = exposureValue
      },
      gradualExposure = SandboxVars.HZ.RandomZonesIsGradual,
      createdAt = getGameTime():getWorldAgeHours()
  }

  -- sendClientCommand(getPlayer(), "HazardousZones", "AddRndZone", { zone = zoneData, spawnZeds = false, 0 })
  return zoneData
end

function HZUtils:checkRandomZoneCreation()
  local currentZoneNum = HZUtils:getTableLength(HZData.RndZones)

  if currentZoneNum >= SandboxVars.HZ.RandomZonesLimit then 
    if isDebugEnabled() then
      print("[RANDOM ZONES:CREATE] RandomZone creation failed, limit exceeded [limit="..tostring(SandboxVars.HZ.RandomZonesLimit)..", current="..tostring(currentZoneNum).."]")
    end
    return
  end

  if getGameTime():getHour() % SandboxVars.HZ.RandomZonesCheckInterval ~= 0 then 
    if isDebugEnabled() then
      print("[RANDOM ZONES:CREATE] RandomZone creation failed, creation check is limited to every 6th hour every day")
    end
    return
  end

  local d100 = ZombRand(1,100)
  local dc = SandboxVars.HZ.RandomZonesCreationDC
  
  if d100 <= dc then
    print("[RANDOM ZONES:CREATE] Creating random zone. [d100="..tostring(d100)..", dc="..tostring(dc).."]")
    HZUtils:createRandomZone()
  else
    print("[RANDOM ZONES:CREATE] Random zone creation cancelled. [d100="..tostring(d100)..", dc="..tostring(dc).."]")
  end
end