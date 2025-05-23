local HZ = HazardousZones.Client
local HZShared = HazardousZones.Shared
local HZItemSettings = HazardousZones.Settings.Items

function HZ:executeEffect(effect)
    local player = getPlayer()
    local pBodyDamage = player:getBodyDamage()
    local pBodyPart
    local pStats = player:getStats()
    local currentSquare = player:getCurrentSquare()
    local d100 = ZombRand(100)
    local bloodyCoughing = false

    if player:isAsleep() then
        if isDebugEnabled() then
        end

        return
    end

    -- Thirst

    if (effect.moodles.thirst ~= nil) then
        d100 = ZombRand(100)

        if d100 > effect.moodles.thirst.chance then
        else
            pStats:setThirst(pStats:getThirst() + effect.moodles.thirst.value)
        end
    end

    -- Stress

    if (effect.moodles.stress ~= nil) then
        d100 = ZombRand(100)

        if d100 > effect.moodles.stress.chance then

        else

            pStats:setStress(pStats:getStress() +effect.moodles.stress.value)
        end
    end

    -- Fatigue

    if (effect.moodles.fatigue ~= nil) then
        d100 = ZombRand(100)

        if d100 > effect.moodles.fatigue.chance then

        else

            pStats:setFatigue(pStats:getFatigue() + effect.moodles.fatigue.value)
        end
    end

    -- Endurance

    if (effect.moodles.endurance ~= nil) then
        d100 = ZombRand(100)

        if d100 > effect.moodles.endurance.chance then

        else

            pStats:setEndurance(pStats:getEndurance() + effect.moodles.endurance.value)
        end
    end

    -- Sanity

    if (effect.moodles.sanity ~= nil) then
        d100 = ZombRand(100)

        if d100 > effect.moodles.sanity.chance then

        else

            pStats:setSanity(pStats:getSanity() + effect.moodles.sanity.value)
        end
    end

    -- Disorientation

    if (effect.moodles.disorientation ~= nil) then
        d100 = ZombRand(100)

        if d100 > effect.moodles.disorientation.chance then

        else

            pStats:setDrunkenness(pStats:getDrunkenness() + effect.moodles.disorientation.value)
        end
    end

    -- Fear

    if (effect.moodles.fear ~= nil) then
        d100 = ZombRand(100)

        if d100 > effect.moodles.fear.chance then

        else

            pStats:setFear(pStats:getFear() + effect.moodles.fear.value)
        end
    end

    -- Panic

    if (effect.moodles.panic ~= nil) then
        d100 = ZombRand(100)

        if d100 > effect.moodles.panic.chance then

        else

            pStats:setPanic(pStats:getPanic() + effect.moodles.panic.value)
        end
    end

    -- Anger

    if (effect.moodles.anger ~= nil) then
        d100 = ZombRand(100)

        if d100 > effect.moodles.anger.chance then

        else

            pStats:setAnger(pStats:getAnger() + effect.moodles.anger.value)
        end
    end

    -- HeartAttack

    if (effect.moodles.heartAttack ~= nil) then
        d100 = ZombRand(100)

        if d100 > effect.moodles.heartAttack.chance then

        else

            pBodyDamage:setFoodSicknessLevel(100);
            pBodyPart = HZShared.Utils:getSpecificBodyPart(player, 'Torso_Upper')
            pBodyPart:setAdditionalPain(100)
        end
    end

    -- Nausea

    if (effect.moodles.nausea ~= nil) then
        d100 = ZombRand(100)
        if d100 > effect.moodles.nausea.chance then

        else
            -- Bloody coughing
            d100 = ZombRand(100)
            if effect.moodles.nausea.bloodyCoughing ~= nil and d100 > effect.moodles.nausea.bloodyCoughing.chance then

            else

                addBloodSplat(currentSquare, effect.moodles.nausea.bloodyCoughing.value)
            end

            pBodyDamage:setHasACold(true)
        end
    end

    -- Pain

    if (effect.moodles.pain ~= nil) then
        d100 = ZombRand(100)

        if (effect.moodles.pain.bodyPart == nil or effect.moodles.pain.bodyPart == "random") then
            pBodyPart = HZShared.Utils:getRandomBodyPart(player)
        else
            pBodyPart = HZShared.Utils:getSpecificBodyPart(player, effect.moodles.pain.bodyPart)
        end

        if d100 > effect.moodles.pain.chance then

        else

            pBodyPart:setAdditionalPain(effect.moodles.pain.value)
        end
    end

    -- Burn

    if (effect.moodles.burn ~= nil) then
        d100 = ZombRand(100)

        if (effect.moodles.burn.bodyPart == nil or effect.moodles.burn.bodyPart == "random") then
            pBodyPart = HZShared.Utils:getRandomBodyPart(player)
        else
            pBodyPart = HZShared.Utils:getSpecificBodyPart(player, effect.moodles.burn.bodyPart)
        end

        if d100 > effect.moodles.burn.chance then

        else

            pBodyPart:setBurnTime(effect.moodles.burn.value)
        end
    end

    -- Burn

    if (effect.moodles.bleeding ~= nil) then
        d100 = ZombRand(100)

        if (effect.moodles.bleeding.bodyPart == nil or effect.moodles.bleeding.bodyPart == "random") then
            pBodyPart = HZShared.Utils:getRandomBodyPart(player)
        else
            pBodyPart = HZShared.Utils:getSpecificBodyPart(player, effect.moodles.bleeding.bodyPart)
        end

        if d100 > effect.moodles.bleeding.chance then
        else
            pBodyPart:setBleedingTime(effect.moodles.bleeding.value)
        end
    end
end

function HZ:applyEffectModifiers(player, baseValue, modifiers)
    if not modifiers then return baseValue end

    local moddedValue = baseValue
    local modifierSum = 0

    -- checking modifiers by traits
    if modifiers.bytraits then
        for trait, modifier in pairs(modifiers.bytraits) do
            if player:HasTrait(string.lower(trait)) then
                modifierSum = modifierSum + modifier
            end
        end
        moddedValue = moddedValue + (moddedValue * modifierSum)
    end

    return moddedValue
end

local function _applyEffect(player, effect, data)
    local bd = player:getBodyDamage()
    local stats = player:getStats()

    local value = data.value

    if data.modifiers then
        value = HZ:applyEffectModifiers(player, value, data.modifiers)
    end

    if effect == "foodSickness" then
        bd:setFoodSicknessLevel(player:getBodyDamage():getFoodSicknessLevel() + value);
    end

    if effect == "thirst" then
        stats:setThirst(stats:getThirst() + value)
    end

    if effect == "hunger" then
        stats:setHunger(stats:getHunger() + value)
    end

    if effect == "fatigue" then
        stats:setFatigue(stats:getFatigue() + value)
    end

    if effect == "panic" then
        stats:setPanic(stats:getPanic() + value)
    end
end

local function _applyProtection(player, item, protection, data)
    local protections = HZ:getPlayerProtections()

    local value = data.value

    local itemType = item:getType()

    if data.modifiers then
        value = HZ:applyEffectModifiers(player, value, data.modifiers)
    end

    if not protections[protection] then
        protections[protection] = {}
    end

    if not protections[protection][itemType] then
        protections[protection][itemType] = {}
    end

    protections[protection][itemType] = {
        value = value,
        usedAt = getGameTime():getWorldAgeHours()
    }
end

function HZ:applyProtectionEffects(player, item)
    local itemSettings = HZItemSettings[item:getType()]
    if not itemSettings then return end

    local itemProtections = itemSettings.protections
    if not itemProtections then return end

    for protection, data in pairs(itemProtections) do
        if isDebugEnabled() then
        end
        _applyProtection(player, item, protection, data)
    end
end

function HZ:applyItemEffects(player, item)
    local itemSettings = HZItemSettings[item:getType()]
    if not itemSettings then return end

    local itemEffects = itemSettings.effects
    if not itemEffects then return end

    for effect, data in pairs(itemEffects) do
        if isDebugEnabled() then

        end
        _applyEffect(player, effect, data)
    end
end