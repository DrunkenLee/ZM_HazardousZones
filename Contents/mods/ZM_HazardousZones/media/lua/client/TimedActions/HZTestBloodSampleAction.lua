require "TimedActions/ISBaseTimedAction"

local HZ = HazardousZones.Client
local HZConsts = HazardousZones.Constants
local HZItemSettings = HazardousZones.Settings.Items
local HZKnowledges = HazardousZones.Settings.Knowledges

HZTestBloodSampleAction = ISBaseTimedAction:derive("HZTestBloodSampleAction");

function HZTestBloodSampleAction:isValid()
    return self.character:getInventory():contains(self.item);
end

function HZTestBloodSampleAction:update()
    self.item:setJobDelta(self:getJobDelta());

    self:setActionAnim("Loot")
    self.character:SetVariable("LootPosition", "Mid")
    self.character:reportEvent("EventLootItem");
end

function HZTestBloodSampleAction:start()
    self.item:setJobType(getText("ContextMenu_HZTestBloodSample"));
    self.item:setJobDelta(0.0);
    self:setOverrideHandModels(nil, self.item);
end

function HZTestBloodSampleAction:stop()
    ISBaseTimedAction.stop(self);
    self.item:setJobDelta(0.0);
end

function HZTestBloodSampleAction:perform()
    self.item:getContainer():setDrawDirty(true);
    self.item:setJobDelta(0.0);

    local itemModData = self.item:getModData().HazardousZones;
    local userManualKnowledgeSettings = HZKnowledges["HZBloodTestKitUserManual"]

    if itemModData.contaminated then
        self.character:setHaloNote(getText("ContextMenu_HZBloodTestFailedContaminated"), 255, 150, 150, 250)
    else
        local hasKnowledge = HZ:getKnowledgeData("HZBloodTestKitUserManual")

        if hasKnowledge then hasKnowledge = getGameTime():getWorldAgeHours() - hasKnowledge.createdAt < userManualKnowledgeSettings.duration end

        local perkLevel = self.character:getPerkLevel(Perks.Doctor)
        
        if perkLevel < userManualKnowledgeSettings.perkBonus and hasKnowledge then
            perkLevel = userManualKnowledgeSettings.perkBonus
        end

        local failChance = 100 - (perkLevel * 10)
        local measurementModifier = 300 - (perkLevel * 30)
        local measurementMistakeChance = 100 - (perkLevel * 10)

        local testResult = itemModData.exposures[self.hazardType] or 0

        if ZombRand(1, 100) < measurementMistakeChance then
            testResult = testResult + ZombRand(-measurementModifier, measurementModifier)
        end

        local isFailed = ZombRand(1, 100) < failChance

        local text = nil

        if isFailed and SandboxVars.HZ.BloodTestsCanFail then
            text = string.format(getText("ContextMenu_HZBloodTestFailed"))
            self.character:setHaloNote(text, 255, 150, 150, 250)
        else
            text = string.format(getText("ContextMenu_HZBloodTestResult"), itemModData.patient, math.abs(testResult), self.hazardType == "radiation" and "RAD" or "BHX")
            self.character:setHaloNote(text, 150, 255, 150, 500)
        end
    end

    self.character:getInventory():Remove(self.item)
    self.character:getInventory():Remove(self.quickTestItem)

    ISBaseTimedAction.perform(self);
end

function HZTestBloodSampleAction:new (character, item, quickTestItem, hazardType, time)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    o.character = character;
    o.item = item;
    o.quickTestItem = quickTestItem;
    o.hazardType = hazardType;
    o.stopOnWalk = true;
    o.stopOnRun = true;
    
    if o.character:isTimedActionInstant() then 
        o.maxTime = 1; 
    else 
        o.maxTime = time;
    end
    
    return o
end