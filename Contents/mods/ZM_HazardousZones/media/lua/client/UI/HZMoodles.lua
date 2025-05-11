require "MF_ISMoodle"

local HZ = HazardousZones.Client

MF.createMoodle("HZIodinePillSingle");
MF.createMoodle("HZToxiguardPillSingle");
MF.createMoodle("HZIndralineSyringe");
MF.createMoodle("HZBioshieldRxSyringe");
MF.createMoodle("HZGasMask");
MF.createMoodle("HZHazmatSuit");
MF.createMoodle("HZChernoGeiger");
MF.createMoodle("HZCivilianGeiger");
MF.createMoodle("HZIndustrialGeiger");
MF.createMoodle("HZMilitaryGeiger");
MF.createMoodle("HZMultiGasDetector");

function HZ:setIodineMoodle(value)
  MF.getMoodle("HZIodinePillSingle"):setValue(value);
end

function HZ:setToxiguardMoodle(value)
  MF.getMoodle("HZToxiguardPillSingle"):setValue(value);
end

function HZ:setIndralineMoodle(value)
  MF.getMoodle("HZIndralineSyringe"):setValue(value);
end

function HZ:setGasMaskMoodle(value)
  MF.getMoodle("HZGasMask"):setValue(value);
end

function HZ:setHazmatSuitMoodle(value)
  MF.getMoodle("HZHazmatSuit"):setValue(value);
end

function HZ:setChernoGeigerMoodle(value)
  MF.getMoodle("HZChernoGeiger"):setValue(value);
end

function HZ:setCivilianGeigerMoodle(value)
  MF.getMoodle("HZCivilianGeiger"):setValue(value);
end

function HZ:setIndustrialGeigerMoodle(value)
  MF.getMoodle("HZIndustrialGeiger"):setValue(value);
end

function HZ:setMilitaryGeigerMoodle(value)
  MF.getMoodle("HZMilitaryGeiger"):setValue(value);
end

function HZ:setMoodleByItemType(itemType, value)
  local m = MF.getMoodle(itemType)

  if not m then return end

  m:setValue(value);
end

function HZ:hideAllDetectorMoodle() 
  HZ:setChernoGeigerMoodle(0.5)
  HZ:setCivilianGeigerMoodle(0.5)
  HZ:setIndustrialGeigerMoodle(0.5)
  HZ:setMilitaryGeigerMoodle(0.5)
  HZ:setGasDetectorMoodle(0.5)
end

function HZ:getGasDetectorMoodle()
  return MF.getMoodle("HZMultiGasDetector");
end

function HZ:setGasDetectorMoodle(value)
  return MF.getMoodle("HZMultiGasDetector"):setValue(value);
end

function HZ:setDetectorMoodle(item, hazardType, gain)
  if hazardType == "radiation" then
    if gain > 0 and gain <= 25 then
      HZ:setMoodleByItemType(item:getType(), 0.6)
    elseif gain > 25 and gain <= 50 then
      HZ:setMoodleByItemType(item:getType(), 0.4)
    elseif gain > 50 and gain <= 90 then
      HZ:setMoodleByItemType(item:getType(), 0.2)
    elseif gain > 90 then
      HZ:setMoodleByItemType(item:getType(), 0)
    end
  elseif hazardType == "biological" then
    if gain > 0 and gain <= 25 then
      HZ:setMoodleByItemType(item:getType(), 0.6)
    elseif gain > 25 and gain <= 50 then
      HZ:setMoodleByItemType(item:getType(), 0.4)
    elseif gain > 50 and gain <= 90 then
      HZ:setMoodleByItemType(item:getType(), 0.2)
    elseif gain > 90 then
      HZ:setMoodleByItemType(item:getType(), 0)
    end
  end
end

function HZ:setConsumableMoodleByTimeDelta(itemType, timeDelta)
  local value = 0.5

  if timeDelta <= 0 then 
    value = 0.5 
  elseif timeDelta <= 0.25 then 
    value = 0.2
  elseif timeDelta > 0.25 then 
    value = 1 
  end

  print("[SET CONSUMABLE MOODLE] "..itemType..", value="..value..", timeDelta="..timeDelta)
  HZ:setMoodleByItemType(itemType, value)
end