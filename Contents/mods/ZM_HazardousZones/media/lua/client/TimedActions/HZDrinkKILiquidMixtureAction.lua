require "TimedActions/ISBaseTimedAction"

local HZ = HazardousZones.Client
local HZConsts = HazardousZones.Constants
local HZItemSettings = HazardousZones.Settings.Items

local HZKILiquidMixtureItem = HZItemSettings.HZKILiquidMixture

HZDrinkKILiquidMixtureAction = ISBaseTimedAction:derive("HZDrinkKILiquidMixtureAction");

function HZDrinkKILiquidMixtureAction:isValid()
    return self.character:getInventory():contains(self.item);
end

function HZDrinkKILiquidMixtureAction:update()
    self.item:setJobDelta(self:getJobDelta());
    self:setActionAnim(CharacterActionAnims.Drink);
end

function HZDrinkKILiquidMixtureAction:start()
    self.item:setJobType(getText("ContextMenu_HZDrinkKILiquidMixture"));
    self.item:setJobDelta(0.0);
    self:setOverrideHandModels(nil, self.item);
    self:setAnimVariable("FoodType", "2handbowl");
    self.eatAudio = self.character:getEmitter():playSound("DrinkingFromGeneric");
end

function HZDrinkKILiquidMixtureAction:stop()
    ISBaseTimedAction.stop(self);
    self.item:setJobDelta(0.0);
    if self.eatAudio ~= 0 and self.character:getEmitter():isPlaying(self.eatAudio) then
        self.character:getEmitter():stopSound(self.eatAudio);
    end
end

function HZDrinkKILiquidMixtureAction:perform()
    self.item:getContainer():setDrawDirty(true);
    self.item:setJobDelta(0.0);
    self.character:getBodyDamage():JustTookPill(self.item);
    self.character:getInventory():Remove(self.item)
    self.character:getInventory():AddItem("Bowl")
    HZ:applyItemEffects(self.character, self.item);
    HZ:applyProtectionEffects(self.character, self.item);
    if self.eatAudio ~= 0 and self.character:getEmitter():isPlaying(self.eatAudio) then
        self.character:getEmitter():stopSound(self.eatAudio);
    end
    ISBaseTimedAction.perform(self);
end

function HZDrinkKILiquidMixtureAction:new (character, item, time)
    print(character)
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
