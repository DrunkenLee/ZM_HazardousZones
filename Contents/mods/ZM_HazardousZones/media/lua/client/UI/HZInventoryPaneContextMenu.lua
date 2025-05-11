HZInventoryPaneContextMenu = {}

local HZKits = HazardousZones.Settings.Kits

local function onFillInventoryObjectContextMenu(player, context, items) 
  local playerObj = getSpecificPlayer(player)
  
  for i, v in ipairs(items) do
    local item = v
    local itemType
    if not instanceof(v, "InventoryItem") then
      item = v.items[1]
    end

    if item:getType() then
      itemType = item:getType()

      if item:hasTag("GeigerCounter") or item:hasTag("GasDetector") then
        if item:getUsedDelta() >= item:getUseDelta() and item:isActivated() then
          context:addOption(getText("ContextMenu_HZLookAtDetectorDevice"), item, lookAtDetectorDevice, player)
        end
      end

      if itemType == "HZMilitaryMap" then
        context:addOption(getText("ContextMenu_HZCheckMilitaryMap"), item, checkMilitaryMap, player)
      end

      if item:hasTag("HZMedicineSinglePill") then
        context:addOption(getText("ContextMenu_HZTakeIodinePills"), item, takeIodinePillSingle, player)
      end

      if item:hasTag("HZKitItem") then
        context:addOption(getText("ContextMenu_HZOpenKitItem"), item, openKitItem, player)
      end

      if item:hasTag("HZBloodCollectionSyringe") then
        local collectBloodOpt = context:addOption(getText("ContextMenu_HZTakeBloodSample"), item, useBloodCollectionSyringe, player)

        if playerObj:HasTrait("hemophobic") then
          collectBloodOpt.notAvailable = true

          local tooltip = ISWorldObjectContextMenu.addToolTip()
          tooltip:setName("Taking Blood Sample");
          tooltip.description = "You cannot perform this action because you are hemophobic";
          collectBloodOpt.toolTip = tooltip
        end
      end

      if item:hasTag("HZBloodTestKitUserManual") then
        context:addOption(getText("ContextMenu_HZReadManual"), item, readManual, player)
      end

      if item:hasTag("HZBloodSampleVial") then
        local hasQuickTest = getPlayer():getInventory():getItemFromType("HazardousZones.HZBloodQuickTest")

        local testBloodRadOpt = context:addOption(getText("ContextMenu_HZTestBloodRadiation"), item, analyzeBloodSample, hasQuickTest, player, "radiation")
        local testBloodToxOpt = context:addOption(getText("ContextMenu_HZTestBloodToxicity"), item, analyzeBloodSample, hasQuickTest, player, "biological")
        
        testBloodRadOpt.notAvailable = not hasQuickTest
        testBloodToxOpt.notAvailable = not hasQuickTest
        
        if not hasQuickTest then
          local tooltip = ISWorldObjectContextMenu.addToolTip()
          tooltip:setName("Rapid Blood Test");
          tooltip.description = "You cannot perform this action without a specific item";
          testBloodRadOpt.toolTip = tooltip
          testBloodToxOpt.toolTip = tooltip
        elseif playerObj:HasTrait("hemophobic") then
          testBloodRadOpt.notAvailable = true
          testBloodToxOpt.notAvailable = true

          local tooltip = ISWorldObjectContextMenu.addToolTip()
          tooltip:setName("Rapid Blood Test");
          tooltip.description = "You cannot perform this action because you are hemophobic";
          testBloodRadOpt.toolTip = tooltip
          testBloodToxOpt.toolTip = tooltip
        end
      end

      if item:hasTag("HZMedicineSyringe") then
          context:addOption(getText("ContextMenu_HZUseSyringe"), item, useSyringe, player)
      end

      if itemType == "HZKILiquidMixture" then
        context:addOption(getText("ContextMenu_HZDrinkKILiquidMixture"), item, drinkKILiquidMixture, player)
      end

      if item:hasTag("HZBodyRadiationDetectorItem") then
        if item:getUsedDelta() >= item:getUseDelta() and item:isActivated() then 
          context:addOption(getText("ContextMenu_HZMeasureBodyRadiation"), item, measureBodyRadiation, player)
        end
      end
    end
  end
end

function lookAtDetectorDevice(item, player)
  local playerObj = getSpecificPlayer(player)
  
  ISInventoryPaneContextMenu.transferIfNeeded(playerObj, item)
  
  ISTimedActionQueue.add(HZLookAtDetectorDeviceAction:new(playerObj, item, 30))
end

function takeIodinePillSingle(item, player)
  local playerObj = getSpecificPlayer(player)
  
  ISInventoryPaneContextMenu.transferIfNeeded(playerObj, item)
  
  ISTimedActionQueue.add(HZTakeSinglePillAction:new(playerObj, item, 165))
end

function useSyringe(item, player)
  local playerObj = getSpecificPlayer(player)

  ISInventoryPaneContextMenu.transferIfNeeded(playerObj, item)

  ISTimedActionQueue.add(HZUseSyringeAction:new(playerObj, item, 100))
end

function openKitItem(item, player)
  local playerObj = getSpecificPlayer(player)
  local kitSettings = HZKits[item:getType()] 
  
  if not kitSettings or not kitSettings.Items then
    print("There is no kit definition with type="..item:getType())
    playerObj:getInventory():Remove(item)
    return
  end

  ISInventoryPaneContextMenu.transferIfNeeded(playerObj, item)
  ISTimedActionQueue.add(HZOpenKitItemAction:new(playerObj, item, kitSettings, kitSettings.Items, 100))
end

function readManual(item, player)
  local playerObj = getSpecificPlayer(player)

  ISInventoryPaneContextMenu.transferIfNeeded(playerObj, item)
  ISTimedActionQueue.add(HZReadManualAction:new(playerObj, item, 250))
end

function useBloodCollectionSyringe(item, player)
  local playerObj = getSpecificPlayer(player)

  ISInventoryPaneContextMenu.transferIfNeeded(playerObj, item)

  ISTimedActionQueue.add(HZTakeBloodSampleAction:new(playerObj, item, 250))
end

function analyzeBloodSample(item, quickTestItem, player, hazardType)
  local playerObj = getSpecificPlayer(player)

  local itemModData = item:getModData().HazardousZones

  if not itemModData then
    playerObj:setHaloNote(getText("ContextMenu_HZBloodTestFailedContaminated"), 255, 150, 150, 250)
    playerObj:getInventory():Remove(item)
    return
  end

  if not itemModData.createdAt or getGameTime():getWorldAgeHours() - itemModData.createdAt > 24 then
    itemModData.contaminated = true
  end

  ISInventoryPaneContextMenu.transferIfNeeded(playerObj, item)

  ISTimedActionQueue.add(HZTestBloodSampleAction:new(playerObj, item, quickTestItem, hazardType, 600))
end

function takePillOutOfBottle(item, player)
  local playerObj = getSpecificPlayer(player)

  ISInventoryPaneContextMenu.transferIfNeeded(playerObj, item)

  ISTimedActionQueue.add(HZTakePillOutOfBottleAction:new(playerObj, item, 15))
end

function takeEveryPillOutOfBottle(item, player)
  local playerObj = getSpecificPlayer(player)

  ISInventoryPaneContextMenu.transferIfNeeded(playerObj, item)
  
  local itemNum = item:getUsedDelta() / item:getUseDelta()

  for i=1,itemNum do
    ISTimedActionQueue.add(HZTakePillOutOfBottleAction:new(playerObj, item, 15))
  end
end

function drinkKILiquidMixture(item, player)
  local playerObj = getSpecificPlayer(player)
  
  ISInventoryPaneContextMenu.transferIfNeeded(playerObj, item)
  
  ISTimedActionQueue.add(HZDrinkKILiquidMixtureAction:new(playerObj, item, 165))
end

function measureBodyRadiation(item, player)
  local playerObj = getSpecificPlayer(player)

  if item:getUsedDelta() < item:getUseDelta() then return end

  ISInventoryPaneContextMenu.transferIfNeeded(playerObj, item)

  ISTimedActionQueue.add(HZMeasureBodyRadiationAction:new(playerObj, item, 300))
end

function checkMilitaryMap(item, player)
  local playerObj = getSpecificPlayer(player)

  ISInventoryPaneContextMenu.transferIfNeeded(playerObj, item)

  ISTimedActionQueue.add(HZCheckMilitaryMapAction:new(playerObj, item, 60))
end

Events.OnFillInventoryObjectContextMenu.Add(onFillInventoryObjectContextMenu)