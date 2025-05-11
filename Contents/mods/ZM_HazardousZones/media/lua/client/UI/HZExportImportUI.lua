require "ISUI/ISPanelJoypad"

local HZUtils = HazardousZones.Shared.Utils
local HZData = HazardousZones.Data

HZExportImportUI = ISCollapsableWindow:derive("HZExportImportUI")

local normalBg = {r = 0, g = 0, b = 0, a = 0.2}
local selectedBg = {r = 1, g = 1, b = 1, a = 0.2} 

function HZExportImportUI:createChildren()
    local btnWid = 100
    local btnHgt = 25
    local padBottom = 20
    local f = 0.8

    ISCollapsableWindow.createChildren(self)

    self.importPanel = ISPanel:new(0, 40, self.width, self.height - 40)
    self.exportPanel = ISPanel:new(0, 40, self.width, self.height - 40)

    self.importTabButton = ISButton:new(0, 15, self.width / 2, btnHgt, "Import Zones", self, HZExportImportUI.onImportTabButton)
    self.exportTabButton = ISButton:new(self.width / 2, 15, self.width / 2, btnHgt, "Export Zones", self, HZExportImportUI.onExportTabButton)

    self.selectedTab = "import"

    self.importTabButton.backgroundColor = selectedBg
    self.importTabButton.borderColor = {r = 1, g = 1, b = 1, a = 0}
    self.exportTabButton.backgroundColor = normalBg
    self.exportTabButton.borderColor = {r = 1, g = 1, b = 1, a = 0}

    self.exportPanel:setVisible(false)

    self:addChild(self.importPanel)
    self:addChild(self.exportPanel)
    self:addChild(self.importTabButton)
    self:addChild(self.exportTabButton)

    local fileName = string.format("hz-export-%s-%s", os.date("%H-%M-%S"), os.date("%d-%m-%Y"))

    self.importTitleLabel = ISLabel:new(10, 10, 10, "Hazardous Zones Importer" ,1,1,1,1,UIFont.Medium, true);
	  self.importPanel:addChild(self.importTitleLabel);

    self.exportTitleLabel = ISLabel:new(10, 10, 10, "Hazardous Zones Exporter" ,1,1,1,1,UIFont.Medium, true);
	  self.exportPanel:addChild(self.exportTitleLabel);

    self.fileNameLabel = ISLabel:new(10, 35, 10, "Filename" ,1,1,1,1,UIFont.Small, true);
	  self.importPanel:addChild(self.fileNameLabel);
    self.exportPanel:addChild(self.fileNameLabel);

    self.fileName = ISTextEntryBox:new(fileName, self.fileNameLabel.x, self.fileNameLabel.y + 15, 280, 20);
	  self.fileName:initialise();
	  self.fileName:instantiate();
	  self.importPanel:addChild(self.fileName);
    self.exportPanel:addChild(self.fileName);

    self.importBoolOpts = ISTickBox:new(10, 75, 200, 20, "", self);
    self.importBoolOpts:initialise()
    self.importPanel:addChild(self.importBoolOpts)
    self.importBoolOpts:addOption("Clear registered zones before import");
    self.importBoolOpts:addOption("Import random zones too");
    
    self.statusLabel = ISLabel:new(10, 125, 10, "Status: None" ,1,1,1,1,UIFont.Small, true);
	  self.importPanel:addChild(self.statusLabel);
    self.exportPanel:addChild(self.statusLabel);

    self.importButton = ISButton:new(10, 150, self.width - 20, btnHgt, "Start Import", self, HZExportImportUI.onImport);
    self.importButton.anchorTop = false
    self.importButton.anchorBottom = true
    self.importButton:initialise();
    self.importButton:instantiate();
    self.importButton.borderColor = {r=1, g=1, b=1, a=0.1};
    self.importPanel:addChild(self.importButton);

    self.exportInfoLabel = ISLabel:new(10, 80, 10, "Useful information:", 1, 1, 1, 1, UIFont.Small, true);
    self.exportPanel:addChild(self.exportInfoLabel)

    self.exportInfoLabel = ISLabel:new(10, 100, 10, "File will be stored in the mod data folder.", 1, 1, 1, 1, UIFont.Small, true);
    self.exportPanel:addChild(self.exportInfoLabel)

    self.exportButton = ISButton:new(10, 150, self.width - 20, btnHgt, "Start Export", self, HZExportImportUI.onExport);
    self.exportButton.anchorTop = false
    self.exportButton.anchorBottom = true
    self.exportButton:initialise();
    self.exportButton:instantiate();
    self.exportButton.borderColor = {r=1, g=1, b=1, a=0.1};
    self.exportPanel:addChild(self.exportButton);
    
end

function HZExportImportUI:initialise()
  self.resizable = false
end

function HZExportImportUI:render()
    ISCollapsableWindow.render(self);
end

function HZExportImportUI:close()
    self:setVisible(false);
    self:removeFromUIManager();
end

function HZExportImportUI:onExport()
  local fname = HZUtils:getFullFilename(self.fileName:getInternalText())
  
  local exportData = {
    zones = HZData.Zones,
    rndZones = HZData.RndZones
  }

  HZUtils:writeJSON(fname, exportData)

  self.statusLabel:setName("Status: Success.")
  self.statusLabel:setColor(0, 1, 0)
end

function HZExportImportUI:onImport()
  local fname = HZUtils:getFullFilename(self.fileName:getInternalText())
  local importData = HZUtils:readJSON(fname)

  if not importData then 
    print("[HZ_IMPORT_FAILED] Import failed.")
    self.statusLabel:setName("Status: Failed.")
    self.statusLabel:setColor(1, 0, 0)
    return
  else
    print("[HZ_IMPORT_SUCCESS] Import succeeded.")
    self.statusLabel:setName("Status: Success.")
    self.statusLabel:setColor(0, 1, 0)
  end

  sendClientCommand(getPlayer(), "HazardousZones", "ImportZones", { data = importData, removeZones = self.importBoolOpts.selected[1], importRndZones = self.importBoolOpts.selected[2]})
end

function HZExportImportUI:onImportTabButton()
  self.importPanel:setVisible(true)
  self.exportPanel:setVisible(false)
  self.selectedTab = "import"

  self.statusLabel:setName("Status: None")
  self.statusLabel:setColor(1, 1, 1)

  self.importTabButton.backgroundColor = selectedBg
  self.exportTabButton.backgroundColor = normalBg
end

function HZExportImportUI:onExportTabButton()
  self.importPanel:setVisible(false)
  self.exportPanel:setVisible(true)
  self.selectedTab = "export"

  self.statusLabel:setName("Status: None")
  self.statusLabel:setColor(1, 1, 1)

  self.importTabButton.backgroundColor = normalBg
  self.exportTabButton.backgroundColor = selectedBg
end

function HZExportImportUI:new(x, y, character)
    local o = {}
    local width = 300;
    local height = 225;
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