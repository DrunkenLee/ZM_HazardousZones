local HZData = HazardousZones.Data
local HZSettings = HazardousZones.Settings

ISWorldMap._createChildren = ISWorldMap.createChildren;
ISWorldMap._render = ISWorldMap.render;
ISWorldMap._close = ISWorldMap.close;

ISWorldMap.drawZones = function(self)
  local pSettings = HZ:getPlayerSettings()

  if isClient() and not isAdmin() and not pSettings.knowZoneLocations then return end
  
  if not HZSettings.Debug.ShowZones and not pSettings.knowZoneLocations then return end

  if not self.mapAPI:getBoolean("ImagePyramid") then
    self.mapAPI:setBoolean("ImagePyramid", true)
    self.mapAPI:setBoolean("Features", false)
  end

  -- force iso mode turn off when displaying zones

  if self.isometric then self:setIsometric(false) end

  for i, zone in pairs(HZData.Zones) do

    local a, r, g, b = 0.1, 1, 0, 0

    if zone.hazard.type == 'biological' then
      r = 1
      g = 0.7
    end

    local x = tonumber(zone.epicentre.x - zone.radius)
    local y = tonumber(zone.epicentre.y - zone.radius)
    local w = zone.radius * 2  * self.mapAPI:getWorldScale()
    local h = zone.radius * 2  * self.mapAPI:getWorldScale()

    local mx = self.mapAPI:worldToUIX(x, y)
		local my = self.mapAPI:worldToUIY(x, y)

    self:drawRectBorder(mx, my, w, h, 1, r, g, b)
    self:drawRect(mx, my, w, h, a, r, g, b)
  end

  -- Show random zones only for admins only when clicked on the show zones button on the world map

  if not HZSettings.Debug.ShowZones then return end

  if not SandboxVars.HZ.RandomZones then return end

  for i, zone in pairs(HZData.RndZones) do

    local a, r, g, b = 0.1, 0, 0, 1

    if zone.hazard.type == 'biological' then
      r = 0.7
      g = 0
    end

    local x = tonumber(zone.epicentre.x - zone.radius)
    local y = tonumber(zone.epicentre.y - zone.radius)
    local w = zone.radius * 2  * self.mapAPI:getWorldScale()
    local h = zone.radius * 2  * self.mapAPI:getWorldScale()

    local mx = self.mapAPI:worldToUIX(x, y)
		local my = self.mapAPI:worldToUIY(x, y)

    self:drawRectBorder(mx, my, w, h, 1, r, g, b)
    self:drawRect(mx, my, w, h, a, r, g, b)
  end
end

ISWorldMap.onRadButtonClick = function(self)
  HZSettings.Debug.ShowZones = not HZSettings.Debug.ShowZones
  if 
    not HZSettings.Debug.ShowZones 
    and self.mapAPI:getBoolean("ImagePyramid") 
  then
      self.mapAPI:setBoolean("ImagePyramid", false)
      self.mapAPI:setBoolean("Features", true)
  end
end

ISWorldMap.render = function(self)
  local pSettings = HZ:getPlayerSettings()
  self:_render()

  if isClient() then
    if isAdmin() then
      self:createShowZonesButton(self)
    else
      self:removeShowZonesButton(self)
    end
  else
    if isDebugEnabled() then
      self:createShowZonesButton(self)
    else
      self:removeShowZonesButton(self)
    end
  end

  if isClient() then
    if not isAdmin() and not pSettings.knowZoneLocations then return end
  else
    if not isDebugEnabled() and not pSettings.knowZoneLocations then return end  
  end

  ISWorldMap.drawZones(self)
end

ISWorldMap.createChildren = function(self)
  self:_createChildren(self)
end

ISWorldMap.createShowZonesButton = function(self)
  if self.zonesBtn then return end
  self.zonesBtn = ISButton:new(20, 20, 100, 32, "Show Zones", self, self.onRadButtonClick)
	self:addChild(self.zonesBtn)
end

ISWorldMap.removeShowZonesButton = function(self)
  if not self.zonesBtn then return end
  self:removeChild(self.zonesBtn)
  self.zonesBtn = nil
end

ISWorldMap.close = function(self)
  self:_close()

  local pSettings = HZ:getPlayerSettings()
  pSettings.knowZoneLocations = false
  
  if self.mapAPI:getBoolean("ImagePyramid") then
    self.mapAPI:setBoolean("ImagePyramid", false)
    self.mapAPI:setBoolean("Features", true)
  end
  
end