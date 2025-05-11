local HZ = HazardousZones.Client
local HZUtils = HazardousZones.Shared.Utils

HazardousZones.OnCreate = {}
HazardousZones.OnTest = {}

function HazardousZones.OnTest.HZChernoGeigerBatteryInsert(sourceItem, result)
  if sourceItem:getType() == "HZChernoGeiger" then
		return sourceItem:getUsedDelta() == 0;
	end
	return true -- the battery
end


function HazardousZones.OnCreate.HZChernoGeigerBatteryInsert(items, result, player)
  for i=0, items:size() - 1 do
    if items:get(i):getType() == "Battery" then
      result:setUsedDelta(items:get(i):getUsedDelta());
    end
  end
end

function HazardousZones.OnTest.HZCivilianGeigerBatteryInsert(sourceItem, result)
  if sourceItem:getType() == "HZCivilianGeiger" then
		return sourceItem:getUsedDelta() == 0;
	end
	return true
end

function HazardousZones.OnCreate.HZCivilianGeigerBatteryInsert(items, result, player)
  for i=0, items:size() - 1 do
    if items:get(i):getType() == "Battery" then
      result:setUsedDelta(items:get(i):getUsedDelta());
    end
  end
end

function HazardousZones.OnTest.HZChernoGeigerBatteryRemove(sourceItem, result)
  return sourceItem:getUsedDelta() > 0;
end

function HazardousZones.OnCreate.HZChernoGeigerBatteryRemove(items, result, player)
  for i=0, items:size() - 1 do
		local item = items:get(i)
		if item:getType() == "HZChernoGeiger" then
			result:setUsedDelta(item:getUsedDelta());
			item:setUsedDelta(0);
		end
	end
end

function HazardousZones.OnTest.HZCivilianGeigerBatteryRemove(sourceItem, result)
  return sourceItem:getUsedDelta() > 0;
end

function HazardousZones.OnCreate.HZCivilianGeigerBatteryRemove(items, result, player)
  for i=0, items:size() - 1 do
		local item = items:get(i)
		if item:getType() == "HZCivilianGeiger" then
			result:setUsedDelta(item:getUsedDelta());
			item:setUsedDelta(0);
		end
	end
end

function HazardousZones.OnTest.HZIndustrialGeigerBatteryInsert(sourceItem, result)
  if sourceItem:getType() == "HZIndustrialGeiger" then
		return sourceItem:getUsedDelta() == 0;
	end
	return true
end

function HazardousZones.OnCreate.HZIndustrialGeigerBatteryInsert(items, result, player)
  local totalCharge = 0

  for i=0, items:size() - 1 do
    local item = items:get(i)
    if item:getType() == "Battery" then
      totalCharge = totalCharge + item:getUsedDelta()
    end
  end

  if totalCharge > 0 then
    result:setUsedDelta(totalCharge / 2)
  end

end

function HazardousZones.OnTest.HZIndustrialGeigerBatteryRemove(sourceItem, result)
  return sourceItem:getUsedDelta() > 0;
end

function HazardousZones.OnCreate.HZIndustrialGeigerBatteryRemove(items, result, player)
  for i=0, items:size() - 1 do
		local item = items:get(i)
		if item:getType() == "HZIndustrialGeiger" then
      player:getInventory():AddItem("Battery"):setUsedDelta(item:getUsedDelta())
      result:setUsedDelta(item:getUsedDelta());
			-- then we empty the torch used delta (his energy)
			item:setUsedDelta(0);
		end
	end
end

function HazardousZones.OnTest.HZMilitaryGeigerBatteryInsert(sourceItem, result)
  if sourceItem:getType() == "HZMilitaryGeiger" then
		return sourceItem:getUsedDelta() == 0;
	end
	return true
end

function HazardousZones.OnCreate.HZMilitaryGeigerBatteryInsert(items, result, player)
  local totalCharge = 0

  for i=0, items:size() - 1 do
    local item = items:get(i)
    if item:getType() == "Battery" then
      totalCharge = totalCharge + item:getUsedDelta()
    end
  end

  if totalCharge > 0 then
    result:setUsedDelta(totalCharge / 4)
  end
end

function HazardousZones.OnTest.HZMilitaryGeigerBatteryRemove(sourceItem, result)
  return sourceItem:getUsedDelta() > 0;
end

function HazardousZones.OnCreate.HZMilitaryGeigerBatteryRemove(items, result, player)
  for i=0, items:size() - 1 do
		local item = items:get(i)
		if item:getType() == "HZMilitaryGeiger" then
			player:getInventory():AddItem("Battery"):setUsedDelta(item:getUsedDelta())
      player:getInventory():AddItem("Battery"):setUsedDelta(item:getUsedDelta())
      player:getInventory():AddItem("Battery"):setUsedDelta(item:getUsedDelta())
      result:setUsedDelta(item:getUsedDelta());
			item:setUsedDelta(0);
		end
	end
end

--

function HazardousZones.OnTest.HZMultiGasDetectorBatteryInsert(sourceItem, result)
  if sourceItem:getType() == "HZMultiGasDetector" then
		return sourceItem:getUsedDelta() == 0;
	end
	return true
end

function HazardousZones.OnCreate.HZMultiGasDetectorBatteryInsert(items, result, player)
  local totalCharge = 0

  for i=0, items:size() - 1 do
    local item = items:get(i)
    if item:getType() == "Battery" then
      totalCharge = totalCharge + item:getUsedDelta()
    end
  end

  if totalCharge > 0 then
    result:setUsedDelta(totalCharge / 4)
  end
end

function HazardousZones.OnTest.HZMultiGasDetectorBatteryRemove(sourceItem, result)
  return sourceItem:getUsedDelta() > 0;
end

function HazardousZones.OnCreate.HZMultiGasDetectorBatteryRemove(items, result, player)
  for i=0, items:size() - 1 do
		local item = items:get(i)
		if item:getType() == "HZMultiGasDetector" then
      local battery = InventoryItemFactory.CreateItem("Base.Battery");
			player:getInventory():AddItem("Battery"):setUsedDelta(item:getUsedDelta())
      player:getInventory():AddItem("Battery"):setUsedDelta(item:getUsedDelta())
      player:getInventory():AddItem("Battery"):setUsedDelta(item:getUsedDelta())
      result:setUsedDelta(item:getUsedDelta());
			item:setUsedDelta(0);
		end
	end
end

function HazardousZones.OnTest.HZIodinePillsBottleAdd(sourceItem, result)
  if (sourceItem:getType() == "HZIodinePillsBottle") then
    return sourceItem:getUsedDelta() < 1;
  end

  return true
end

function HazardousZones.OnCreate.HZIodinePillsBottleAdd(items, result, player)
  for i=0, items:size() - 1 do
		local item = items:get(i)
    if item:getType() == "HZIodinePillsBottle" then
      local useDelta = item:getUseDelta()
      result:setUsedDelta(item:getUsedDelta() + useDelta);
    end

  end
end

function HazardousZones.OnTest.HZIodinePillsBottleRemove(sourceItem, result)
  return sourceItem:getUsedDelta() > 0;
end

function HazardousZones.OnCreate.HZIodinePillsBottleRemove(items, result, player)
  for i=0, items:size() - 1 do
		local item = items:get(i)
		if item:getType() == "HZIodinePillsBottle" then
      player:getInventory():AddItem("HZIodinePillSingle")
      item:setUsedDelta(item:getUsedDelta())
		end
	end
end

function HazardousZones.OnTest.HZToxiguardPackRemove(sourceItem, result)
  return sourceItem:getUsedDelta() > 0;
end

function HazardousZones.OnCreate.HZToxiguardPackRemove(items, result, player)
  for i=0, items:size() - 1 do
		local item = items:get(i)
		if item:getType() == "HZToxiguardPillSingle" then
      player:getInventory():AddItem("HZToxiguardPillSingle")
      item:setUsedDelta(item:getUsedDelta())
		end
	end
end

function HazardousZones.OnCreate.HZWorkWithRadioactiveMaterial(items, result, player)
  local hasGloves = HZUtils:getWornItemByType(player, "Gloves_Surgical") or
                      HZUtils:getWornItemByType(player, "Glove_Leather") or
                      HZUtils:getWornItemByType(player, "Gloves_LeatherGloves") or
                      HZUtils:getWornItemByType(player, "Gloves_LeatherGlovesBlack")
  local hasHazmat = HZUtils:isPlayerUseHazmatSuit(player)
  if not hasGloves and not hasHazmat and not player:isGodMod() and not player:isDead() then
    HZ:modifyPlayerExposure('radiation', 50, 'Player is not wearing gloves or hazmat while working with radioactive materials')
    if ZombRand(100) > 85 then
      player:setHaloNote(getText("ContextMenu_HZHaveABadFeeling"), 255, 170, 170, 250) -- some hint to use gloves
    end
  end
end

function HazardousZones.OnCreate.HZExtractTwoWayRadioComponents(items, result, player)
  local playerElectricityLevel = player:getPerkLevel(Perks.Electricity)
  local modifier = playerElectricityLevel * 2

  local isGiveLed = ZombRand(1,100) >= (50 - modifier)
  local isGiveLCD = ZombRand(1,100) >= (85 - modifier)
  local isGiveCasing = ZombRand(1,100) >= (30 - modifier)
  local isGiveCapacitor = ZombRand(1,100) >= (90 - modifier)
  local isGiveResistors = ZombRand(1,100) >= (90 - modifier)
  local isGiveSemicond  = ZombRand(1,100) >= (85 - modifier)

  local ledNum = HZUtils:getRandomMaterialCountByPerkLevel(player, Perks.Electricity)

  if isGiveLed then
    for i=1, ledNum do player:getInventory():AddItem("HazardousZones.HZDiode") end
  end

  if isGiveLCD then
    player:getInventory():AddItem("HazardousZones.HZOneLineLCD")
  end

  if isGiveCasing then
    player:getInventory():AddItem("HazardousZones.HZDevicePlasticCasing")
  end

  if isGiveCapacitor then
    player:getInventory():AddItem("HazardousZones.HZCapacitor")
  end

  if isGiveResistors then
    player:getInventory():AddItem("HazardousZones.HZResistors")
  end

  if isGiveSemicond then
    player:getInventory():AddItem("HazardousZones.HZSemiconductor")
  end

end

function HazardousZones.OnTest.HZMakeshiftBodyRadiationDetectorBatteryInsert(sourceItem, result)
  if sourceItem:getType() == "HZMakeshiftBodyRadiationDetector" then
		return sourceItem:getUsedDelta() == 0;
	end
	return true
end

function HazardousZones.OnCreate.HZMakeshiftBodyRadiationDetectorBatteryInsert(items, result, player)
  local totalCharge = 0

  for i=0, items:size() - 1 do
    local item = items:get(i)
    if item:getType() == "Battery" then
      totalCharge = totalCharge + item:getUsedDelta()
    end
  end

  if totalCharge > 0 then
    result:setUsedDelta(totalCharge / 2)
  end
end

function HazardousZones.OnTest.HZMakeshiftBodyRadiationDetectorBatteryRemove(sourceItem, result)
  return sourceItem:getUsedDelta() > 0;
end

function HazardousZones.OnCreate.HZMakeshiftBodyRadiationDetectorBatteryRemove(items, result, player)
  for i=0, items:size() - 1 do
		local item = items:get(i)
		if item:getType() == "HZMakeshiftBodyRadiationDetector" then
      local battery = InventoryItemFactory.CreateItem("Base.Battery");
			player:getInventory():AddItem("Battery"):setUsedDelta(item:getUsedDelta())
      result:setUsedDelta(item:getUsedDelta());
			item:setUsedDelta(0);
		end
	end
end