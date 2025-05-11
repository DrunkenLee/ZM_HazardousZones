require "TimedActions/ISBaseTimedAction"

local HZ = HazardousZones.Client
local HZConsts = HazardousZones.Constants
local HZItemSettings = HazardousZones.Settings.Items

local HZMakeshiftBodyRadiationDetectorSettings = HZItemSettings.HZMakeshiftBodyRadiationDetector

HZMeasureBodyRadiationAction = ISBaseTimedAction:derive("HZMeasureBodyRadiationAction");

function HZMeasureBodyRadiationAction:isValid()
    return self.character:getInventory():contains(self.item);
end

function HZMeasureBodyRadiationAction:update()
    self.item:setJobDelta(self:getJobDelta());
    self:setActionAnim(CharacterActionAnims.Bandage);
    local bodyPart = self.character:getBodyDamage():getBodyPart(BodyPartType.Torso_Upper);
    self:setAnimVariable("BandageType", ISHealthPanel.getBandageType(bodyPart));
    self.character:reportEvent("EventBandage");
end

function HZMeasureBodyRadiationAction:start()
    self.item:setJobType(getText("ContextMenu_HZMeasureBodyRadiation"));
    self.item:setJobDelta(0.0);
    self:setOverrideHandModels(nil, self.item);
    HZ:playSound(self.character, "BRDBeep")
end

function HZMeasureBodyRadiationAction:stop()
    ISBaseTimedAction.stop(self);
    self.item:setJobDelta(0.0);
    HZ:stopSoundByName(self.character, "BRDBeep")
end

function HZMeasureBodyRadiationAction:perform()
    self.item:getContainer():setDrawDirty(true);
    self.item:setJobDelta(0.0);

    if self.item:getType() == "HZMilitaryGeiger" then
        self.item:setUsedDelta(self.item:getUsedDelta() - 0.1)
    else
        self.item:Use();
        self.item:setUsedDelta(self.item:getUsedDelta() - 0.2)
    end
    --


    local exposure = HZ:getPlayerExposures().radiation or 0

    local interferenceChance = 25

    if self.item:getType() == "HZMilitaryGeiger" then
        interferenceChance = 5
    end

    local d100 = ZombRand(0, 100)

    if d100 <= interferenceChance then
        local interference = ZombRand(
            HZMakeshiftBodyRadiationDetectorSettings.MeasurementInterferenceMin,
            HZMakeshiftBodyRadiationDetectorSettings.MeasurementInterferenceMax
        );

        exposure = exposure + interference

        if isDebugEnabled() then

        end
    end

    self.character:setHaloNote(string.format(getText("ContextMenu_HZMeasurementResult"), tostring(HZUtils:toFixedNumber(math.abs(exposure), 1))), 255, 255, 0, 500)
    HZ:stopSoundByName(self.character, "BRDBeep")
    ISBaseTimedAction.perform(self);
end

function HZMeasureBodyRadiationAction:new (character, item, time)
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
