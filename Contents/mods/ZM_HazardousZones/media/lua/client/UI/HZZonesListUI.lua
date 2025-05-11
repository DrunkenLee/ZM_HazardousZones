require "ISUI/ISPanelJoypad"

local HZUtils = HazardousZones.Shared.Utils
local HZData = HazardousZones.Data

HZZonesListUI = ISCollapsableWindow:derive("HZZonesListUI")

function HZZonesListUI:createChildren()
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
    self.datas:addColumn("Zone identifier", 0);
    self.datas:addColumn("Location", 250);
    self.datas:addColumn("Radius", 400);
    self.datas:addColumn("Type", 455);
    self.datas:addColumn("Exposure", 525);
    self.datas:addColumn("Gradual", 600);

    -- populating list with data
    self:populateList();

    -- delete zone button
    self.delete = ISButton:new(10, self:getHeight() - padBottom - btnHgt, btnWid, btnHgt, "Remove selected", self, HZZonesListUI.onRemove);
    self.delete.anchorTop = false
    self.delete.anchorBottom = true
    self.delete:initialise();
    self.delete:instantiate();
    self.delete.borderColor = {r=1, g=0, b=0, a=0.1};
    self:addChild(self.delete);

    -- presets

    self.presets = ISButton:new(120, self:getHeight() - padBottom - btnHgt, btnWid, btnHgt, "Presets", self, HZZonesListUI.onPresets);
    self.presets.anchorTop = false
    self.presets.anchorBottom = true
    self.presets:initialise();
    self.presets:instantiate();
    self.presets.borderColor = {r=1, g=1, b=1, a=0.1};
    self:addChild(self.presets);

    -- export / import

    self.exportImport = ISButton:new(230, self:getHeight() - padBottom - btnHgt, btnWid, btnHgt, "Export / Import", self, HZZonesListUI.onExportImport);
    self.exportImport.anchorTop = false
    self.exportImport.anchorBottom = true
    self.exportImport:initialise();
    self.exportImport:instantiate();
    self.exportImport.borderColor = {r=1, g=1, b=1, a=0.1};
    self:addChild(self.exportImport);

    -- refresh

    self.refresh = ISButton:new(350, self:getHeight() - padBottom - btnHgt, btnWid, btnHgt, "Refresh", self, HZZonesListUI.onRefresh);
    self.refresh.anchorTop = false
    self.refresh.anchorBottom = true
    self.refresh:initialise();
    self.refresh:instantiate();
    self.refresh.borderColor = {r=1, g=1, b=1, a=0.1};
    self:addChild(self.refresh);

    -- teleport to zone button
    self.teleport = ISButton:new(self.width - btnWid - btnWid - 20, self:getHeight() - padBottom - btnHgt, btnWid, btnHgt, "Teleport", self, HZZonesListUI.onTeleport);
    self.teleport.anchorTop = false
    self.teleport.anchorBottom = true
    self.teleport:initialise();
    self.teleport:instantiate();
    self.teleport.borderColor = {r=1, g=1, b=1, a=0.1};
    self:addChild(self.teleport);

    -- edit zone button
    self.edit = ISButton:new(self.width - btnWid - 10, self:getHeight() - padBottom - btnHgt, btnWid, btnHgt, "Edit selected", self, HZZonesListUI.onEdit);
    self.edit.anchorTop = false
    self.edit.anchorBottom = true
    self.edit:initialise();
    self.edit:instantiate();
    self.edit.borderColor = {r=1, g=1, b=1, a=0.1};
    self:addChild(self.edit);
end

function HZZonesListUI:populateList()
    self.datas:clear();

    for i, z in pairs(HZData.Zones) do
        local zone = HZData.Zones[i]

        self.datas:addItem(i, {
            index = i,
            text = zone.name, 
            location = string.format("%s, %s, %s", zone.epicentre.x, zone.epicentre.y,zone.epicentre.z), 
            type = zone.hazard.type,
            radius = tostring(zone.radius),
            exp = tostring(zone.hazard.exposurePerInGameMinute),
            isGradual = tostring(zone.gradualExposure)
        })
    end

    self.datas.selected = math.min(1, #self.datas.items);
end

function HZZonesListUI:drawDatas(y, item, alt)
    local a = 0.9;
    
    self:drawRectBorder(0, (y), self:getWidth(), self.itemheight - 1, a, self.borderColor.r, self.borderColor.g, self.borderColor.b);
    
    if self.selected == item.index then
        self:drawRect(0, (y), self:getWidth(), self.itemheight - 1, 0.3, 0.7, 0.35, 0.15);
        self.selectedIndex = item.index
    end
    
    self:drawText(item.item.text, 10, y + 2, 1, 1, 1, a, self.font);
    self:drawText(item.item.location, self.columns[2].size + 10, y + 2, 1, 1, 1, a, self.font);
    self:drawText(item.item.radius, self.columns[3].size + 10, y + 2, 1, 1, 1, a, self.font);
    self:drawText(item.item.type, self.columns[4].size + 10, y + 2, 1, 1, 1, a, self.font);
    self:drawText(item.item.exp, self.columns[5].size + 10, y + 2, 1, 1, 1, a, self.font);
    self:drawText(item.item.isGradual, self.columns[6].size + 10, y + 2, 1, 1, 1, a, self.font);
    
    return y + self.itemheight;
end

function HZZonesListUI:onTeleport()
    if self.datas.selected <= 0 then
        return;
    end

    local index = self.datas.items[self.datas.selected].item.index;
    
    local zone = HZData.Zones[index]

    if not zone then return end;

    local playerObj = getSpecificPlayer(0)
    if not playerObj then return end
    
    playerObj:setX(zone.epicentre.x)
    playerObj:setY(zone.epicentre.y)
    playerObj:setZ(0.0)
    playerObj:setLx(zone.epicentre.x)
    playerObj:setLy(zone.epicentre.y)
end

function HZZonesListUI:onRemove()
    if self.datas.selected <= 0 then
        return;
    end

    local index = self.datas.items[self.datas.selected].item.index;
    
    local zone = HZData.Zones[index]

    if not zone then return end;

    if isClient() then
        table.remove(HZData.Zones, index)
    else
        HZData.Zones[index] = nil
    end
    
    sendClientCommand(getPlayer(), "HazardousZones", "RemoveZone", { index = index })

    self:populateList()
end

function HZZonesListUI:onEdit()
    if self.datas.selected <= 0 then
        return;
    end

    local player = getSpecificPlayer(0)

    local index = self.datas.items[self.datas.selected].item.index;

    local ui = HZEditZoneUI:new(self, 0, 0, player, index);
    
    ui:initialise();
    ui:addToUIManager();
end

function HZZonesListUI:onRefresh()
    self:populateList()
end

function HZZonesListUI:update()
    ISCollapsableWindow.update(self);
    self.delete.enable = false;
    self.teleport.enable = false;
    self.edit.enable = false;

    if self.datas.selected > 0 then
        self.delete.enable = true;
        self.teleport.enable = true;
        self.edit.enable = true;
    end
end

function HZZonesListUI:onPresets()
    local ui = HZZonePresetsUI:new(self.width + self.x + 10, 0, self.character)
    ui:initialise();
    ui:addToUIManager();
end

function HZZonesListUI:render()
    ISCollapsableWindow.render(self);
end

function HZZonesListUI:close()
    self:setVisible(false);
    self:removeFromUIManager();
end

function HZZonesListUI:onExportImport()
    local ui = HZExportImportUI:new(0, 0, self.character)
    ui:initialise()
    ui:addToUIManager()
end

function HZZonesListUI:new(x, y, character)
    local o = {}
    local width = 820;
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