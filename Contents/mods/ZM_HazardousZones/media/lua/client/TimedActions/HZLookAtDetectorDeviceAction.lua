require "TimedActions/ISBaseTimedAction"

local HZ = HazardousZones.Client
local HZConsts = HazardousZones.Constants
local HZItemSettings = HazardousZones.Settings.Items

HZLookAtDetectorDeviceAction = ISBaseTimedAction:derive("HZLookAtDetectorDeviceAction");

function HZLookAtDetectorDeviceAction:isValid()
    return self.character:getInventory():contains(self.item);
end

function HZLookAtDetectorDeviceAction:update()
    self.item:setJobDelta(self:getJobDelta());
end

function HZLookAtDetectorDeviceAction:start()
    self.item:setJobType(getText("ContextMenu_HZLookAtDetectorDevice"));
    self.item:setJobDelta(0.0);
    self:setOverrideHandModels(nil, self.item);
end

function HZLookAtDetectorDeviceAction:stop()
    ISBaseTimedAction.stop(self);
    self.item:setJobDelta(0.0);
end

function HZLookAtDetectorDeviceAction:perform()
    self.item:getContainer():setDrawDirty(true);
    self.item:setJobDelta(0.0);
    
    local expData = HZ:getExpData()
    local rad = 0
    local bhx = 0

    local text = ""
    
    if not self.item:isActivated() then
      self.character:setHaloNote(getText("ContextMenu_HZTurnOnDeviceFirst"), 255, 255, 0, 250)
    end

    if self.item:hasTag('GeigerCounter') then
      rad = expData.radiation or 0

      -- DP-5V dosimeters in chernobyl were limited to measure maximum 3.6 Roentgen / hour so lets make it the max

      if rad > 3.6 and self.item:hasTag('GeigerCounterLimited') then
        rad = 3.6
      end

      text = string.format(getText("ContextMenu_HZNuclearRadiationLevel"), tostring(HZUtils:toFixedNumber(rad, 1)))
      -- Chernobyl reference
    elseif self.item:hasTag('GasDetector') then
      bhx = expData.biological or 0
      text = string.format(getText("ContextMenu_HZAirToxicityLevel"), tostring(HZUtils:toFixedNumber(bhx, 1)))
    end

    self.character:setHaloNote(text, 255, 255, 0 ,500)

    if rad == 3.6 and ZombRand(100) > 50 then
        HaloTextHelper.forceNextAddText()
        HaloTextHelper.addText(getPlayer(), getText("ContextMenu_HZNotGreatNotTerrible"), HaloTextHelper.getColorWhite())
      end

    ISBaseTimedAction.perform(self);
end

function HZLookAtDetectorDeviceAction:new (character, item, time)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    o.character = character;
    o.item = item;
    o.stopOnWalk = false;
    o.stopOnRun = true;
    
    if o.character:isTimedActionInstant() then 
        o.maxTime = 1; 
    else 
        o.maxTime = time;
    end
    
    return o
end
