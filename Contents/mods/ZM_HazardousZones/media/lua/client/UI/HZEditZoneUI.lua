require "ISUI/ISPanelJoypad"

HZEditZoneUI = ISCollapsableWindow:derive("HZEditZoneUI");
-- HZServer = HazardousZones.Server
HZData = HazardousZones.Data
HZUtils = HazardousZones.Shared.Utils

local zone
local zoneData
local zoneIndex
local parentWindow
local isRandomZone = false

function HZEditZoneUI:createChildren()
    local btnWid = 100
    local btnHgt = 25
    local padBottom = 0
    local y = 60
    local f = 0.8
    
    ISCollapsableWindow.createChildren(self)
    
    self.nameLabel = ISLabel:new(10, y, 10, "Zone identifier / name" ,1,1,1,1,UIFont.Small, true);
    self:addChild(self.nameLabel);
    
    self.name = ISTextEntryBox:new(zoneData.name, self.nameLabel.x, self.nameLabel.y + 15, 280, 20);
    self.name:initialise();
    self.name:instantiate();
    self:addChild(self.name);
    
    y = y + 45
    
    self.exposurePerInGameMinuteLabel = ISLabel:new(10, y, 10, "Exposure / minute" ,1,1,1,1,UIFont.Small, true);
    self:addChild(self.exposurePerInGameMinuteLabel);
    
    self.exposurePerInGameMinute = ISTextEntryBox:new(tostring(zoneData.hazard.exposurePerInGameMinute), self.exposurePerInGameMinuteLabel.x, self.exposurePerInGameMinuteLabel.y + 15, 130, 20);
    self.exposurePerInGameMinute:initialise();
    self.exposurePerInGameMinute:instantiate();
    self.exposurePerInGameMinute:setOnlyNumbers(true);
    self:addChild(self.exposurePerInGameMinute);
    
    self.radiusLbl = ISLabel:new(160, y, 10, "Radius" ,1,1,1,1,UIFont.Small, true);
    self:addChild(self.radiusLbl);
    y = y + 15
    
    self.radius = ISTextEntryBox:new(tostring(zoneData.radius), self.radiusLbl.x, y, 130, 20);
    self.radius:initialise();
    self.radius:instantiate();
    self.radius:setOnlyNumbers(true);
    self:addChild(self.radius);
    y = y + 30
    
    self.hazardTypeLabel = ISLabel:new(10, y, 10, "Hazard Type" ,1,1,1,1,UIFont.Small, true);
    self:addChild(self.hazardTypeLabel);
    y = y + 15
    
    self.hazardType = ISComboBox:new(self.hazardTypeLabel.x, y, 280, 20)
    self.hazardType:initialise()
    self:addChild(self.hazardType)
    self.hazardType:addOptionWithData("Nuclear Radiation", "radiation");
    self.hazardType:addOptionWithData("Biological Hazard", "biological");
    y = y + 30
    
    self.hazardType:selectData(zoneData.hazard.type)
    
    self.boolOptions = ISTickBox:new(10, y, 200, 20, "", self, HZEditZoneUI.onBoolOptionsChange);
    self.boolOptions:initialise()
    self:addChild(self.boolOptions)
    self.boolOptions:addOption("Gradual exposure");
    y = y + self.boolOptions:getHeight()+10

    self.boolOptions:setSelected(1, zoneData.gradualExposure or false)
    
    self.pickNewSq = ISButton:new(self.width - btnWid*f - 30, 20, btnWid, btnHgt, "Pick new square", self, HZEditZoneUI.onSelectNewSquare);
    self.pickNewSq.anchorTop = false
    self.pickNewSq.anchorBottom = true
    self.pickNewSq:initialise();
    self.pickNewSq:instantiate();
    self.pickNewSq.borderColor = {r=1, g=1, b=1, a=0.1};
    self:addChild(self.pickNewSq);
    
    self.save = ISButton:new(10, self:getHeight() - padBottom - btnHgt - 18, btnWid*f, btnHgt, "Save", self, HZEditZoneUI.onSaveZone);
    self.save.anchorTop = false
    self.save.anchorBottom = true
    self.save:initialise();
    self.save:instantiate();
    self.save.borderColor = {r=1, g=1, b=1, a=0.1};
    self:addChild(self.save);
    
    self.closeButton2 = ISButton:new(self.width - btnWid*f - 10, self.save.y, btnWid*f, btnHgt, "Close", self, HZEditZoneUI.close);
    self.closeButton2.anchorTop = false
    self.closeButton2.anchorBottom = true
    self.closeButton2:initialise();
    self.closeButton2:instantiate();
    self.closeButton2.borderColor = {r=1, g=1, b=1, a=0.1};
    self:addChild(self.closeButton2);
end

function HZEditZoneUI:onBoolOptionsChange(index, selected)
    -- 
end

function HZEditZoneUI:getRadius()
    local r = self.radius:getInternalText();
    local radius = tonumber(r)
    if not (tonumber(r) and tonumber(r) > 0) then radius = 5 end
    return radius
end

function HZEditZoneUI:onSaveZone()
    local exposureValue = self:getExposureValue()
    local radiusValue = self:getRadius()
    local hazardTypeValue = self:getHazardType()
    local isGradualValue = false
    local nameValue = self:getNameValue()
    
    if self.boolOptions.selected[1] then isGradualValue = true end
    
    local zoneDataNew = {
        name = nameValue,
        epicentre = {
            x = self.selectX,
            y = self.selectY,
            z = self.selectZ
        },
        radius = radiusValue,
        hazard = {
            type = hazardTypeValue,
            exposurePerInGameMinute = exposureValue
        },
        gradualExposure = isGradualValue,
        createdAt = zone.createdAt
    }

    if isRandomZone then
        sendClientCommand(getPlayer(), "HazardousZones", "EditRndZone", { zoneIndex = zoneIndex, zoneData = zoneDataNew})
    else
        sendClientCommand(getPlayer(), "HazardousZones", "EditZone", { zoneIndex = zoneIndex, zoneData = zoneDataNew})
    end
    

    if parentWindow then 
        parentWindow:populateList()
    end

    self:close()
end

function HZEditZoneUI:getNameValue()
    local str = self.name:getInternalText();
    return tostring(str) or "New Zone";
end

function HZEditZoneUI:getExposureValue()
    local nbr = self.exposurePerInGameMinute:getInternalText();
    return tonumber(nbr) or 5;
end

function HZEditZoneUI:getHazardType()
    return self.hazardType.options[self.hazardType.selected].data;
end

function HZEditZoneUI:onSelectNewSquare()
    self.cursor = ISSelectCursor:new(self.chr, self, self.onSquareSelected)
    getCell():setDrag(self.cursor, self.chr:getPlayerNum())
end

function HZEditZoneUI:onSquareSelected(square)
    self.cursor = nil;
    self:removeMarker();
    self.selectX = square:getX();
    self.selectY = square:getY();
    self.selectZ = square:getZ();
    self:addMarker(square, self:getRadius() + 1);
end

function HZEditZoneUI:prerender()
    ISCollapsableWindow.prerender(self);
    local radius = (self:getRadius() + 1);
    if self.marker and (self.marker:getSize() ~= radius) then
        self.marker:setSize(radius)
    end
end

function HZEditZoneUI:render()
    ISCollapsableWindow.render(self);
    
    self:drawText("Epicentre: " .. self.selectX .. "," .. self.selectY .. "," .. self.selectZ, 10, 25, 1, 1, 1, 1, self.font);
end

function HZEditZoneUI:addMarker(square, radius)
    self.marker = getWorldMarkers():addGridSquareMarker(square, 1, 0.1, 0.0, true, radius);
    self.marker:setScaleCircleTexture(true);
    local texName = nil; -- use default
    self.arrow = getWorldMarkers():addDirectionArrow(self.chr, self.selectX, self.selectY, self.selectZ, texName, 1.0, 1.0, 1.0, 1.0);
end

function HZEditZoneUI:removeMarker()
    if self.marker then
        self.marker:remove();
        self.marker = nil;
    end
    if self.arrow then
        self.arrow:remove();
        self.arrow = nil;
    end
end

function HZEditZoneUI:close()
    self:removeMarker();
    self:setVisible(false);
    self:removeFromUIManager();
end

function HZEditZoneUI:updateData()
    self:setNameValue("gegaeg")
end

--************************************************************************--
--** HZEditZoneUI:new
--**
--************************************************************************--
function HZEditZoneUI:new(parentWin, x, y, character, zIndex, isRnd)
    local width = 300;
    local height = 300;
    local o = ISCollapsableWindow.new(self, x, y, width, height);
    o.playerNum = character:getPlayerNum()
    if y == 0 then
        o.y = getPlayerScreenTop(o.playerNum) + (getPlayerScreenHeight(o.playerNum) - height) / 2
        o:setY(o.y)
    end
    if x == 0 then
        o.x = getPlayerScreenLeft(o.playerNum) + (getPlayerScreenWidth(o.playerNum) - width) / 2
        o:setX(o.x)
    end
    
    isRandomZone = isRnd

    zone = HZData.Zones[zIndex]

    if isRandomZone then
        zone = HZData.RndZones[zIndex]
    end
    
    if not zone then return end
    
    o.width = width;
    o.height = height;
    o.chr = character;
    o.moveWithMouse = true;
    o.selectX = zone.epicentre.x;
    o.selectY = zone.epicentre.y;
    o.selectZ = zone.epicentre.z;
    o.anchorLeft = true;
    o.anchorRight = true;
    o.anchorTop = true;
    o.anchorBottom = true;
    zoneData = zone
    zoneIndex = zIndex
    parentWindow = parentWin
    
    return o;
end
