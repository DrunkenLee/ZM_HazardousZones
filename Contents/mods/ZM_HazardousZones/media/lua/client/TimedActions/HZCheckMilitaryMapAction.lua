require "TimedActions/ISBaseTimedAction"

local HZ = HazardousZones.Client
local HZConsts = HazardousZones.Constants
local HZItemSettings = HazardousZones.Settings.Items

HZCheckMilitaryMapAction = ISBaseTimedAction:derive("HZCheckMilitaryMapAction");

function HZCheckMilitaryMapAction:isValid()
    return self.character:getInventory():contains(self.item);
end

function HZCheckMilitaryMapAction:update()
    self.item:setJobDelta(self:getJobDelta());
end

function HZCheckMilitaryMapAction:start()
    self.item:setJobType(getText("ContextMenu_HZCheckMilitaryMap"));
    self.item:setJobDelta(0.0);
    self:setOverrideHandModels(nil, self.item);
end

function HZCheckMilitaryMapAction:stop()
    ISBaseTimedAction.stop(self);
    self.item:setJobDelta(0.0);
end

function HZCheckMilitaryMapAction:perform()
    self.item:getContainer():setDrawDirty(true);
    self.item:setJobDelta(0.0);

    if SandboxVars.HZ.MilitaryMapShowZones then

    local pSettings = HZ:getPlayerSettings();

    pSettings.knowZoneLocations = true;

    ISWorldMap.ToggleWorldMap(self.character:getPlayerNum())
    else
      self.character:setHaloNote(getText("ContextMenu_HZMilitaryMapIsDisabled"), 255, 255, 0, 250)
    end

    ISBaseTimedAction.perform(self);
end

function HZCheckMilitaryMapAction:new (character, item, time)
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
