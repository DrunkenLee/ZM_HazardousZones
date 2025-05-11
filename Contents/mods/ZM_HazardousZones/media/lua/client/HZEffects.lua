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
            print("[EFFECTS] Effects execution has been disabled when the player is sleeping")
        end    

        return
    end

    -- Thirst
    
    if (effect.moodles.thirst ~= nil) then
        d100 = ZombRand(100)
        
        if d100 > effect.moodles.thirst.chance then
            print("[THIRST] Player was lucky. [roll="..d100..", dc="..effect.moodles.thirst.chance.."]")
        else
            print("[THIRST] Player was unlucky that time. [roll="..d100..", dc="..effect.moodles.thirst.chance.."]")
            pStats:setThirst(pStats:getThirst() + effect.moodles.thirst.value)
        end
    end
    
    -- Stress
    
    if (effect.moodles.stress ~= nil) then
        d100 = ZombRand(100)
        
        if d100 > effect.moodles.stress.chance then
            print("[STRESS] Player was lucky. [roll="..d100..", dc="..effect.moodles.stress.chance.."]")
        else
            print("[STRESS] Player was unlucky that time. [roll="..d100..", dc="..effect.moodles.stress.chance.."]")
            pStats:setStress(pStats:getStress() +effect.moodles.stress.value)
        end
    end
    
    -- Fatigue
    
    if (effect.moodles.fatigue ~= nil) then
        d100 = ZombRand(100)
        
        if d100 > effect.moodles.fatigue.chance then
            print("[FATIGUE] Player was lucky. [roll="..d100..", dc="..effect.moodles.fatigue.chance.."]")
        else
            print("[FATIGUE] Player was unlucky that time. [roll="..d100..", dc="..effect.moodles.fatigue.chance.."]")
            pStats:setFatigue(pStats:getFatigue() + effect.moodles.fatigue.value)
        end
    end
    
    -- Endurance
    
    if (effect.moodles.endurance ~= nil) then
        d100 = ZombRand(100)
        
        if d100 > effect.moodles.endurance.chance then
            print("[ENDURANCE] Player was lucky. [roll="..d100..", dc="..effect.moodles.endurance.chance.."]")
        else
            print("[ENDURANCE] Player was unlucky that time. [roll="..d100..", dc="..effect.moodles.endurance.chance.."]")
            pStats:setEndurance(pStats:getEndurance() + effect.moodles.endurance.value)
        end
    end
    
    -- Sanity
    
    if (effect.moodles.sanity ~= nil) then
        d100 = ZombRand(100)
        
        if d100 > effect.moodles.sanity.chance then
            print("[SANITY] Player was lucky. [roll="..d100..", dc="..effect.moodles.sanity.chance.."]")
        else
            print("[SANITY] Player was unlucky that time. [roll="..d100..", dc="..effect.moodles.sanity.chance.."]")
            pStats:setSanity(pStats:getSanity() + effect.moodles.sanity.value)
        end
    end
    
    -- Disorientation
    
    if (effect.moodles.disorientation ~= nil) then
        d100 = ZombRand(100)
        
        if d100 > effect.moodles.disorientation.chance then
            print("[DISORIENTATION] Player was lucky. [roll="..d100..", dc="..effect.moodles.disorientation.chance.."]")
        else
            print("[DISORIENTATION] Player was unlucky that time. [roll="..d100..", dc="..effect.moodles.disorientation.chance.."]")
            pStats:setDrunkenness(pStats:getDrunkenness() + effect.moodles.disorientation.value)
        end
    end
    
    -- Fear
    
    if (effect.moodles.fear ~= nil) then
        d100 = ZombRand(100)
        
        if d100 > effect.moodles.fear.chance then
            print("[FEAR] Player was lucky. [roll="..d100..", dc="..effect.moodles.fear.chance.."]")
        else
            print("[FEAR] Player was unlucky that time. [roll="..d100..", dc="..effect.moodles.fear.chance.."]")
            pStats:setFear(pStats:getFear() + effect.moodles.fear.value)
        end
    end
    
    -- Panic
    
    if (effect.moodles.panic ~= nil) then
        d100 = ZombRand(100)
        
        if d100 > effect.moodles.panic.chance then
            print("[PANIC] Player was lucky. [roll="..d100..", dc="..effect.moodles.panic.chance.."]")
        else
            print("[PANIC] Player was unlucky that time. [roll="..d100..", dc="..effect.moodles.panic.chance.."]")
            pStats:setPanic(pStats:getPanic() + effect.moodles.panic.value)
        end
    end
    
    -- Anger
    
    if (effect.moodles.anger ~= nil) then
        d100 = ZombRand(100)
        
        if d100 > effect.moodles.anger.chance then
            print("[ANGER] Player was lucky. [roll="..d100..", dc="..effect.moodles.anger.chance.."]")
        else
            print("[ANGER] Player was unlucky that time. [roll="..d100..", dc="..effect.moodles.anger.chance.."]")
            pStats:setAnger(pStats:getAnger() + effect.moodles.anger.value)
        end
    end
    
    -- HeartAttack
    
    if (effect.moodles.heartAttack ~= nil) then
        d100 = ZombRand(100)
        
        if d100 > effect.moodles.heartAttack.chance then
            print("[HEARTATTACK] Player was lucky. [roll="..d100..", dc="..effect.moodles.heartAttack.chance.."]")
        else
            print("[HEARTATTACK] Player was unlucky that time. [roll="..d100..", dc="..effect.moodles.heartAttack.chance.."]")
            pBodyDamage:setFoodSicknessLevel(100);
            pBodyPart = HZShared.Utils:getSpecificBodyPart(player, 'Torso_Upper')
            pBodyPart:setAdditionalPain(100)
        end
    end
    
    -- Nausea
    
    if (effect.moodles.nausea ~= nil) then
        d100 = ZombRand(100)
        if d100 > effect.moodles.nausea.chance then
            print("[NAUSEA] Player was lucky. [roll="..d100..", dc="..effect.moodles.nausea.chance.."]")
        else
            -- Bloody coughing
            d100 = ZombRand(100)
            if effect.moodles.nausea.bloodyCoughing ~= nil and d100 > effect.moodles.nausea.bloodyCoughing.chance then
                print("[NAUSEA] Player was unlucky that time. [roll="..d100..", dc="..effect.moodles.nausea.chance.."]")
            else
                print("[NAUSEA(BloodyCaughing)] Player was very unlucky that time. [roll="..d100..", dc="..effect.moodles.nausea.chance.."]")
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
            print("[PAIN] Player was lucky. [roll="..d100..", dc="..effect.moodles.pain.chance..", bodyPart="..effect.moodles.pain.bodyPart.."]")
        else
            print("[PAIN] Player was unlucky that time. [roll="..d100..", dc="..effect.moodles.pain.chance..", bodyPart="..effect.moodles.pain.bodyPart.."]")
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
            print("[BURN] Player was lucky. [roll="..d100..", dc="..effect.moodles.burn.chance..", bodyPart="..effect.moodles.burn.bodyPart.."]")
        else
            print("[BURN] Player was unlucky that time. [roll="..d100..", dc="..effect.moodles.burn.chance..", bodyPart="..effect.moodles.burn.bodyPart.."]")
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
            print("[BLEEDING] Player was lucky. [roll="..d100..", dc="..effect.moodles.bleeding.chance..", bodyPart="..effect.moodles.bleeding.bodyPart.."]")
        else
            print("[BLEEDING] Player was unlucky that time. [roll="..d100..", dc="..effect.moodles.bleeding.chance..", bodyPart="..effect.moodles.bleeding.bodyPart.."]")
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
            print("[APPLYING PROTECTIONS] "..protection);
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
            print("[APPLYING ITEM EFFECTS] "..effect);
        end
        _applyEffect(player, effect, data)
    end
end