require "TimedActions/ISBaseTimedAction"

local HZ = HazardousZones.Client
local HZConsts = HazardousZones.Constants
local HZItemSettings = HazardousZones.Settings.Items

local HZIodinePillSettings = HZItemSettings.HZIodinePillSingle

HZTakePillOutOfBottleAction = ISBaseTimedAction:derive("HZTakePillOutOfBottleAction");

function HZTakePillOutOfBottleAction:isValid()
    return self.character:getInventory():contains(self.item);
end

function HZTakePillOutOfBottleAction:update()
    self.item:setJobDelta(self:getJobDelta());
    self:setActionAnim(CharacterActionAnims.TakePills);
end

function HZTakePillOutOfBottleAction:start()
    self.item:setJobType(getText("ContextMenu_HZTakeIodinePills"));
    self.item:setJobDelta(0.0);
    self:setOverrideHandModels(nil, self.item);
end

function HZTakePillOutOfBottleAction:stop()
    ISBaseTimedAction.stop(self);
    self.item:setJobDelta(0.0);
end

function HZTakePillOutOfBottleAction:perform()
    self.item:getContainer():setDrawDirty(true);
    self.item:setJobDelta(0.0);
    -- self.character:getBodyDamage():JustTookPill(self.item);
    -- needed to remove from queue / start next.
    self.item:setUseDelta(self.item:getUseDelta());
    self.item:Use();

    ISBaseTimedAction.perform(self);
    self.character:getInventory():AddItem("HazardousZones.HZIodinePillSingle")
end

function HZTakePillOutOfBottleAction:new (character, item, time)
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
