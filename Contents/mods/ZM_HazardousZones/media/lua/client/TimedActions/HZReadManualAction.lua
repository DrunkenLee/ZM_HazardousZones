require "TimedActions/ISBaseTimedAction"

local HZ = HazardousZones.Client
local HZConsts = HazardousZones.Constants
local HZItemSettings = HazardousZones.Settings.Items

HZReadManualAction = ISBaseTimedAction:derive("HZReadManualAction");

function HZReadManualAction:isValid()
    return self.character:getInventory():contains(self.item);
end

function HZReadManualAction:update()
    self.item:setJobDelta(self:getJobDelta());
end

function HZReadManualAction:start()
    self.item:setJobType(getText("ContextMenu_HZReadManual"));
    self.item:setJobDelta(0.0);
    self:setOverrideHandModels(nil, self.item);
end

function HZReadManualAction:stop()
    ISBaseTimedAction.stop(self);
    self.item:setJobDelta(0.0);
end

function HZReadManualAction:perform()
    self.item:getContainer():setDrawDirty(true);
    self.item:setJobDelta(0.0);

    local modData = HZ:setKnowledgeData(self.item:getType())
    self.character:getInventory():Remove(self.item)
    ISBaseTimedAction.perform(self);
end

function HZReadManualAction:new (character, item, time)
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
