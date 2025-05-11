require "TimedActions/ISBaseTimedAction"

local HZ = HazardousZones.Client
local HZConsts = HazardousZones.Constants

HZUseSyringeAction = ISBaseTimedAction:derive("HZUseSyringeAction");

function HZUseSyringeAction:isValid()
    return self.character:getInventory():contains(self.item);
end

function HZUseSyringeAction:update()
    self.item:setJobDelta(self:getJobDelta());
    self:setActionAnim("Loot")
    self.character:SetVariable("LootPosition", "Mid")
end

function HZUseSyringeAction:start()
    self.item:setJobType(getText("ContextMenu_HZUseSyringe"));
    self.item:setJobDelta(0.0);
    self:setOverrideHandModels(nil, self.item);
end

function HZUseSyringeAction:stop()
    ISBaseTimedAction.stop(self);
    self.item:setJobDelta(0.0);
end

function HZUseSyringeAction:perform()
    self.item:getContainer():setDrawDirty(true);
    self.item:setJobDelta(0.0);
    -- needed to remove from queue / start next.
    self.character:removeFromHands(self.item)
    self.character:getInventory():Remove(self.item)
    HZ:applyItemEffects(self.character, self.item);
    HZ:applyProtectionEffects(self.character, self.item);
    if self.item:hasTag("HZMedicineSyringe") then
        HZ:setConsumableMoodleByTimeDelta(self.item:getType(), 1)
    end
    ISBaseTimedAction.perform(self);
end

function HZUseSyringeAction:new (character, item, time)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    o.character = character;
    o.item = item;
    o.stopOnWalk = true;
    o.stopOnRun = true;
    
    if o.character:isTimedActionInstant() then 
        o.maxTime = 1; 
    else 
        o.maxTime = time;
    end
    
    return o
end
