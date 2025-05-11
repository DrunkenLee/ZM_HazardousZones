require "ISUI/ISPanelJoypad"

local HZUtils = HazardousZones.Shared.Utils
local HZData = HazardousZones.Data

HZZonePresetsUI = ISCollapsableWindow:derive("HZZonePresetsUI")

function HZZonePresetsUI:createChildren()
    local btnWid = 100
    local btnHgt = 25
    local padBottom = 20
    local f = 0.8
    
    ISCollapsableWindow.createChildren(self)
    
    self.datas = ISScrollingListBox:new(10, 50, self.width - 20, self.height - 120);
    self.datas:initialise();
    self.datas:instantiate();
    self.datas.itemheight = 22;
    self.datas.selected = 0;
    self.datas.joypadParent = self;
    self.datas.font = UIFont.NewSmall;
    self.datas.doDrawItem = self.drawDatas;
    self.datas.drawBorder = true;
    self:addChild(self.datas);
    self.datas:addColumn("Preset name", 0);
   
    -- populating list with data
    self:populateList();

    self.loadPreset = ISButton:new(10, self:getHeight() - padBottom - btnHgt, btnWid, btnHgt, "Load Preset", self, HZZonePresetsUI.onLoadPreset);
    self.loadPreset.anchorTop = false
    self.loadPreset.anchorBottom = true
    self.loadPreset:initialise();
    self.loadPreset:instantiate();
    self.loadPreset.borderColor = {r=1, g=1, b=1, a=0.1};
    self:addChild(self.loadPreset);

    self.loadAllPreset = ISButton:new(20 + btnWid, self:getHeight() - padBottom - btnHgt, btnWid, btnHgt, "Load All Presets", self, HZZonePresetsUI.onloadAllPreset);
    self.loadAllPreset.anchorTop = false
    self.loadAllPreset.anchorBottom = true
    self.loadAllPreset:initialise();
    self.loadAllPreset:instantiate();
    self.loadAllPreset.borderColor = {r=1, g=1, b=1, a=0.1};
    self:addChild(self.loadAllPreset);
end

function HZZonePresetsUI:populateList()
	self.datas:clear();

    for i, z in pairs(HZData.Presets) do
        local zone = HZData.Presets[i]

        self.datas:addItem(i, {
            index = i,
            text = zone.name, 
        })
    end
end

function HZZonePresetsUI:drawDatas(y, item, alt)
	local a = 0.9;
	
	self:drawRectBorder(0, (y), self:getWidth(), self.itemheight - 1, a, self.borderColor.r, self.borderColor.g, self.borderColor.b);
	
	if self.selected == item.index then
		self:drawRect(0, (y), self:getWidth(), self.itemheight - 1, 0.3, 0.7, 0.35, 0.15);
        self.selectedIndex = item.index
	end
	
	  self:drawText(item.item.text, 10, y + 2, 1, 1, 1, a, self.font);
	
	return y + self.itemheight;
end

function HZZonePresetsUI:onLoadPreset()
    local index = self.datas.items[self.datas.selected].item.index
    local zoneData = HZData.Presets[index]
    
    if not zoneData then return end

    sendClientCommand(getPlayer(), "HazardousZones", "AddZone", { zone = zoneData, spawnZeds = false, 0 })
end

function HZZonePresetsUI:onloadAllPreset()
  for i, z in pairs(HZData.Presets) do
    local zoneData = HZData.Presets[i]

    if not zoneData then return end

    sendClientCommand(getPlayer(), "HazardousZones", "AddZone", { zone = zoneData, spawnZeds = false, 0 })
  end
end

function HZZonePresetsUI:render()
	ISCollapsableWindow.render(self);
end

function HZZonePresetsUI:close()
	self:setVisible(false);
	self:removeFromUIManager();
end

function HZZonePresetsUI:new(x, y, character)
	local o = {}
	local width = 230;
	local height = 350;
	o = ISCollapsableWindow:new(x, y, width, height);
	setmetatable(o, self)
	self.__index = self
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
	o.character = character;
	o.chr = character;
	o.moveWithMouse = true;
	o.anchorLeft = true;
	o.anchorRight = true;
	o.anchorTop = true;
	o.anchorBottom = true;
	return o;
end