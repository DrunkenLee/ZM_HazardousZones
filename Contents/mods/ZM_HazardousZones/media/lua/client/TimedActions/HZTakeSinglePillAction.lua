require "TimedActions/ISBaseTimedAction"

local HZ = HazardousZones.Client
local HZConsts = HazardousZones.Constants
local HZItemSettings = HazardousZones.Settings.Items

local HZIodinePillSettings = HZItemSettings.HZIodinePillSingle

HZTakeSinglePillAction = ISBaseTimedAction:derive("HZTakeSinglePillAction");

function HZTakeSinglePillAction:isValid()
    return self.character:getInventory():contains(self.item);
end

function HZTakeSinglePillAction:update()
    self.item:setJobDelta(self:getJobDelta());
    self:setActionAnim(CharacterActionAnims.TakePills);
end

function HZTakeSinglePillAction:start()
    self.item:setJobType(getText("ContextMenu_HZTakeIodinePills"));
    self.item:setJobDelta(0.0);
    self:setOverrideHandModels(nil, self.item);
    self.eatAudio = self.character:getEmitter():playSound("EatingFruit");
end

function HZTakeSinglePillAction:stop()
    ISBaseTimedAction.stop(self);
    self.item:setJobDelta(0.0);
    if self.eatAudio ~= 0 and self.character:getEmitter():isPlaying(self.eatAudio) then
        self.character:getEmitter():stopSound(self.eatAudio);
    end
end

function HZTakeSinglePillAction:perform()
    self.item:getContainer():setDrawDirty(true);
    self.item:setJobDelta(0.0);
    self.character:getBodyDamage():JustTookPill(self.item);
    self.character:getInventory():Remove(self.item)
    HZ:applyItemEffects(self.character, self.item);
    HZ:applyProtectionEffects(self.character, self.item);
    -- if self.item:getType() == "HZIodinePillSingle" or self.item:getType() == "HZToxiguardPillSingle" then
    if self.item:hasTag("HZMedicineSinglePill") then
        HZ:setConsumableMoodleByTimeDelta(self.item:getType(), 1)
    end
    -- if self.item:getType() == "HZ" then
    --     HZ:setIodineMoodle(1)
    -- end
    if self.eatAudio ~= 0 and self.character:getEmitter():isPlaying(self.eatAudio) then
        self.character:getEmitter():stopSound(self.eatAudio);
    end
    ISBaseTimedAction.perform(self);
end

function HZTakeSinglePillAction:new (character, item, time)
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
