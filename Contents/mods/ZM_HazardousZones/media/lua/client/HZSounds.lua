local HZ = HazardousZones.Client

local currentSound

function HZ:getVolumeBySoundName(soundName)
    local soundNameLC = string.lower(soundName)
    
    if string.find(soundNameLC, "low") then return 10 end
    if string.find(soundNameLC, "medium") then return 30 end
    if string.find(soundNameLC, "high") then return 50 end
    if string.find(soundNameLC, "beep") then return 50 end
end

function HZ:getSoundRadiusBySoundName(soundName)
    local soundNameLC = string.lower(soundName)
    
    if string.find(soundNameLC, "low") then return 1 end
    if string.find(soundNameLC, "medium") then return 5 end
    if string.find(soundNameLC, "high") then return 10 end
    if string.find(soundNameLC, "beep") then return 10 end
end

function HZ:playSound(player, sound)
    if not sound then return end
    
    if not currentSound then
        currentSound = player:playSoundLocal(sound)
    elseif currentSound and not player:getEmitter():isPlaying(sound) then
        currentSound = player:playSoundLocal(sound)
    end
    
    if SandboxVars.HZ.ZombiesReactToDetectors then
        local square = player:getCurrentSquare()
        local sRadius = HZ:getSoundRadiusBySoundName(sound)
        local sVolume = HZ:getVolumeBySoundName(sound)
        
        -- sometimes it pops an error after teleporting to a zone
        if not square then return end
        
        addSound(player, square:getX(), square:getY(), square:getZ(), sRadius, sVolume)
    end
end

function HZ:stopSoundByName(player, sound) 
    player:getEmitter():stopSoundByName(sound)
    currentSound = nil
end

function HZ:stopAllGeigerSound(player)
    HZ:stopSoundByName(player, "GeigerLow")
    HZ:stopSoundByName(player, "GeigerMedium")
    HZ:stopSoundByName(player, "GeigerHigh")
    HZ:stopSoundByName(player, "GeigerHighestAlert")
end

function HZ:stopAllGasDetectorSound(player)
    HZ:stopSoundByName(player, "GasDetectorLow")
    HZ:stopSoundByName(player, "GasDetectorMedium")
    HZ:stopSoundByName(player, "GasDetectorHigh")
end

function HZ:stopAllSound(player) 
    HZ:stopAllGeigerSound(player)
    HZ:stopAllGasDetectorSound(player)
end