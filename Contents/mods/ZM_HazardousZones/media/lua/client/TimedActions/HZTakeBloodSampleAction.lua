require "TimedActions/ISBaseTimedAction"

local HZ = HazardousZones.Client
local HZConsts = HazardousZones.Constants
local HZItemSettings = HazardousZones.Settings.Items
local HZKnowledges = HazardousZones.Settings.Knowledges
local HZUtils = HazardousZones.Shared.Utils

HZTakeBloodSampleAction = ISBaseTimedAction:derive("HZTakeBloodSampleAction");

function HZTakeBloodSampleAction:isValid()
    return self.character:getInventory():contains(self.item);
end

function HZTakeBloodSampleAction:update()
    self.item:setJobDelta(self:getJobDelta());
    self:setActionAnim(CharacterActionAnims.Bandage);
    local bodyPart = self.character:getBodyDamage():getBodyPart(BodyPartType.ForeArm_L);
    self:setAnimVariable("BandageType", ISHealthPanel.getBandageType(bodyPart));
    self.character:reportEvent("EventBandage");
end

function HZTakeBloodSampleAction:start()
    self.item:setJobType(getText("ContextMenu_HZTakeBloodSample"));
    self.item:setJobDelta(0.0);
    self:setOverrideHandModels(nil, self.item);
end

function HZTakeBloodSampleAction:stop()
    ISBaseTimedAction.stop(self);
    self.item:setJobDelta(0.0);
end

function HZTakeBloodSampleAction:perform()
    self.item:getContainer():setDrawDirty(true);
    self.item:setJobDelta(0.0);
  
    self.character:getInventory():Remove(self.item)

    local item = self.character:getInventory():AddItem('HazardousZones.HZBloodSampleVial')
    local exposures = HZ:getPlayerExposures()
    local itemModData = item:getModData()
    local perkLevel = self.character:getPerkLevel(Perks.Doctor)
    local contaminatedChance = 50 - (perkLevel * 5)
    local bleedingChance = 50 - (perkLevel * 5)
    local userManualKnowledgeSettings = HZKnowledges["HZBloodTestKitUserManual"]
    local hasKnowledge = HZ:getKnowledgeData("HZBloodTestKitUserManual")
    if hasKnowledge then hasKnowledge = getGameTime():getWorldAgeHours() - hasKnowledge.createdAt < userManualKnowledgeSettings.duration end

    if ZombRand(1,100) < bleedingChance then
      local bd = self.character:getBodyDamage()
      local bp = BodyPartType.ForeArm_L
      local duration = ZombRandFloat(0.05, 0.5)
      bd:getBodyPart(bp):setScratchTime(duration)
      bd:getBodyPart(bp):setBleedingTime(duration)
      self.character:setHaloNote(getText("ContextMenu_HZOuch"), 255, 255, 0, 250)
    end

    -- local isContaminated = hasKnowledge and false or ZombRand(1,100) < contaminatedChance
    local isContaminated = false

    if not hasKnowledge and SandboxVars.HZ.BloodTestsCanFail then
      isContaminated = ZombRand(1,100) < contaminatedChance
    end

    if not itemModData.HazardousZones then
      itemModData.HazardousZones = {
        exposures = {
          biological = exposures.biological,
          radiation = exposures.radiation
        },
        patient = self.character:getUsername(),
        contaminated = isContaminated,
        createdAt = getGameTime():getWorldAgeHours()
      }
    end

    item:setName(item:getDisplayName().." (Patient: "..itemModData.HazardousZones.patient..")")

    ISBaseTimedAction.perform(self);
end

function HZTakeBloodSampleAction:new (character, item, time)
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
