require "TimedActions/ISBaseTimedAction"

HZOpenKitItemAction = ISBaseTimedAction:derive("HZOpenKitItemAction");

function HZOpenKitItemAction:isValid()
    return self.character:getInventory():contains(self.item);
end

function HZOpenKitItemAction:update()
    self.item:setJobDelta(self:getJobDelta());
end

function HZOpenKitItemAction:start()
    self.item:setJobType(getText("ContextMenu_HZOpenKitItem"));
    self.item:setJobDelta(0.0);
    self:setOverrideHandModels(nil, self.item);
end

function HZOpenKitItemAction:stop()
    ISBaseTimedAction.stop(self);
    self.item:setJobDelta(0.0);
end

function HZOpenKitItemAction:perform()
    self.item:getContainer():setDrawDirty(true);
    self.item:setJobDelta(0.0);

    local playerInv = self.character:getInventory()
    local isEmpty = false

    playerInv:Remove(self.item);
    
    if self.kitSettings.EmptyChance then
        local d100 = ZombRand(1, 100)
        isEmpty = d100 <= self.kitSettings.EmptyChance
    end

    if not isEmpty then
        for itemType, itemCount in pairs(self.kitItems) do
            local fullType = string.format("HazardousZones.%s", itemType)
            playerInv:AddItem(fullType, itemCount)
        end
    else
        self.character:setHaloNote(getText("ContextMenu_HZKitWasEmpty"), 255, 150, 150, 250)
    end

    ISBaseTimedAction.perform(self);
end

function HZOpenKitItemAction:new (character, item, kitSettings, kitItems, time)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    o.character = character;
    o.item = item;
    o.kitSettings = kitSettings;
    o.kitItems = kitItems;
    o.stopOnWalk = false;
    o.stopOnRun = true;
    
    if o.character:isTimedActionInstant() then 
        o.maxTime = 1; 
    else 
        o.maxTime = time;
    end
    
    return o
end
