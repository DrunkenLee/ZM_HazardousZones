require "ISUI/ISPanelJoypad"

HZCreateZoneUI = ISCollapsableWindow:derive("HZCreateZoneUI");
HZServer = HazardousZones.Server

function HZCreateZoneUI:createChildren()
	local btnWid = 100
	local btnHgt = 25
	local padBottom = 0
	local y = 60
	local f = 0.8
	
	ISCollapsableWindow.createChildren(self)
	
  self.nameLabel = ISLabel:new(10, y, 10, "Zone identifier / name" ,1,1,1,1,UIFont.Small, true);
	self:addChild(self.nameLabel);

  self.name = ISTextEntryBox:new("New Zone", self.nameLabel.x, self.nameLabel.y + 15, 280, 20);
	self.name:initialise();
	self.name:instantiate();
	self:addChild(self.name);

  y = y + 45

	self.exposurePerInGameMinuteLabel = ISLabel:new(10, y, 10, "Exposure / minute" ,1,1,1,1,UIFont.Small, true);
	self:addChild(self.exposurePerInGameMinuteLabel);

	self.exposurePerInGameMinute = ISTextEntryBox:new("5.0", self.exposurePerInGameMinuteLabel.x, self.exposurePerInGameMinuteLabel.y + 15, 130, 20);
	self.exposurePerInGameMinute:initialise();
	self.exposurePerInGameMinute:instantiate();
	self.exposurePerInGameMinute:setOnlyNumbers(true);
	self:addChild(self.exposurePerInGameMinute);
	
	self.radiusLbl = ISLabel:new(160, y, 10, "Radius" ,1,1,1,1,UIFont.Small, true);
	self:addChild(self.radiusLbl);
	y = y + 15
	
	self.radius = ISTextEntryBox:new("5", self.radiusLbl.x, y, 130, 20);
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
	

  
	self.boolOptions = ISTickBox:new(10, y, 200, 20, "", self, HZCreateZoneUI.onBoolOptionsChange);
	self.boolOptions:initialise()
	self:addChild(self.boolOptions)
	self.boolOptions:addOption("Gradual exposure");
	y = y + self.boolOptions:getHeight()+10

	self.boolOptions:addOption("Spawn zombies within the zone");
	y = y + self.boolOptions:getHeight()+10

	self.pickNewSq = ISButton:new(self.width - btnWid*f - 30, 20, btnWid, btnHgt, "Pick new square", self, HZCreateZoneUI.onSelectNewSquare);
	self.pickNewSq.anchorTop = false
	self.pickNewSq.anchorBottom = true
	self.pickNewSq:initialise();
	self.pickNewSq:instantiate();
	self.pickNewSq.borderColor = {r=1, g=1, b=1, a=0.1};
	self:addChild(self.pickNewSq);

	self.add = ISButton:new(10, self:getHeight() - padBottom - btnHgt - 18, btnWid*f, btnHgt, "Create", self, HZCreateZoneUI.onCreateZone);
	self.add.anchorTop = false
	self.add.anchorBottom = true
	self.add:initialise();
	self.add:instantiate();
	self.add.borderColor = {r=1, g=1, b=1, a=0.1};
	self:addChild(self.add);
	
	self.closeButton2 = ISButton:new(self.width - btnWid*f - 10, self.add.y, btnWid*f, btnHgt, "Close", self, HZCreateZoneUI.close);
	self.closeButton2.anchorTop = false
	self.closeButton2.anchorBottom = true
	self.closeButton2:initialise();
	self.closeButton2:instantiate();
	self.closeButton2.borderColor = {r=1, g=1, b=1, a=0.1};
	self:addChild(self.closeButton2);
end

function HZCreateZoneUI:onBoolOptionsChange(index, selected)
	-- 
end

function HZCreateZoneUI:getRadius()
	local r = self.radius:getInternalText();
  local radius = tonumber(r)
  if not (tonumber(r) and tonumber(r) > 0) then radius = 5 end
	return radius
end

function HZCreateZoneUI:onCreateZone()
  local exposureValue = self:getExposureValue()
  local radiusValue = self:getRadius()
  local hazardTypeValue = self:getHazardType()
  local isGradualValue = false
  local nameValue = self:getNameValue()

  if self.boolOptions.selected[1] then isGradualValue = true end

  local zoneData = {
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
    gradualExposure = isGradualValue
  }

	local spawnZombies = self.boolOptions.selected[2]

	sendClientCommand(getPlayer(), "HazardousZones", "AddZone", { zone = zoneData, spawnZeds = spawnZombies })
end

function HZCreateZoneUI:getNameValue()
	local str = self.name:getInternalText();
	return tostring(str) or "New Zone";
end

function HZCreateZoneUI:getExposureValue()
	local nbr = self.exposurePerInGameMinute:getInternalText();
	return tonumber(nbr) or 5;
end

function HZCreateZoneUI:getHazardType()
	return self.hazardType.options[self.hazardType.selected].data;
end

function HZCreateZoneUI:onSelectNewSquare()
	self.cursor = ISSelectCursor:new(self.chr, self, self.onSquareSelected)
	getCell():setDrag(self.cursor, self.chr:getPlayerNum())
end

function HZCreateZoneUI:onSquareSelected(square)
	self.cursor = nil;
	self:removeMarker();
	self.selectX = square:getX();
	self.selectY = square:getY();
	self.selectZ = square:getZ();
	self:addMarker(square, self:getRadius() + 1);
end

function HZCreateZoneUI:prerender()
	ISCollapsableWindow.prerender(self);
	local radius = (self:getRadius() + 1);
	if self.marker and (self.marker:getSize() ~= radius) then
		self.marker:setSize(radius)
	end
end

function HZCreateZoneUI:render()
	ISCollapsableWindow.render(self);
	
	self:drawText("Epicentre: " .. self.selectX .. "," .. self.selectY .. "," .. self.selectZ, 10, 25, 1, 1, 1, 1, self.font);
end

function HZCreateZoneUI:addMarker(square, radius)
	self.marker = getWorldMarkers():addGridSquareMarker(square, 1, 0.1, 0.0, true, radius);
	self.marker:setScaleCircleTexture(true);
	local texName = nil; -- use default
	self.arrow = getWorldMarkers():addDirectionArrow(self.chr, self.selectX, self.selectY, self.selectZ, texName, 1.0, 1.0, 1.0, 1.0);
end

function HZCreateZoneUI:removeMarker()
	if self.marker then
		self.marker:remove();
		self.marker = nil;
	end
	if self.arrow then
		self.arrow:remove();
		self.arrow = nil;
	end
end

function HZCreateZoneUI:close()
	self:removeMarker();
	self:setVisible(false);
	self:removeFromUIManager();
end

function HZCreateZoneUI:new(x, y, character, square)
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
	o.width = width;
	o.height = height;
	o.chr = character;
	o.moveWithMouse = true;
	o.selectX = square:getX();
	o.selectY = square:getY();
	o.selectZ = square:getZ();
	o.anchorLeft = true;
	o.anchorRight = true;
	o.anchorTop = true;
	o.anchorBottom = true;
	o:addMarker(square, 5);
	return o;
end