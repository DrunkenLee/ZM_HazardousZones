HZDebugContextMenu = {}

HZ = HazardousZones.Client
HZSettings = HazardousZones.Settings
HZUtils = HazardousZones.Shared.Utils
HZData = HazardousZones.Data

local markers = {}

local function removeDuplicates(list)
  local result = {}
  local seen = {}
  for _,item in ipairs(list) do
      if not seen[item] then
          seen[item] = true
          table.insert(result, item)
      end
  end
  return result
end

local function getISOPlayer(worldobjects, playerObj)
  for k,v in ipairs(worldobjects) do
    local sq = v:getSquare();

    if instanceof(v, "IsoPlayer") and (v ~= playerObj) then
      return v
    end

    for j=0, sq:getStaticMovingObjects():size()-1 do
      local o = sq:getStaticMovingObjects():get(j)
      if instanceof(o, "IsoPlayer") and o ~= playerObj then
        return o
      end
    end

    for j=0, sq:getMovingObjects():size()-1 do
      local o = sq:getMovingObjects():get(j)
      if instanceof(o, "IsoPlayer") and o ~= playerObj then
        return o
      end
    end

    -- detecting a player on the nearby squares

    for x=v:getSquare():getX()-1,v:getSquare():getX()+1 do
      for y=v:getSquare():getY()-1,v:getSquare():getY()+1 do
          local sq = getCell():getGridSquare(x,y,v:getSquare():getZ());
          if sq then
              for i=0,sq:getMovingObjects():size()-1 do
                  local o = sq:getMovingObjects():get(i)
                  if instanceof(o, "IsoPlayer") and (o ~= playerObj) then
                      return o
                  end
              end
          end
      end
    end
  end

  return nil
end

function HZDebugContextMenu.doMenu(player, context, worldobjects, test)
  if isClient() then
    if not isAdmin() then return end
  else
    if not isDebugEnabled() then return end
  end
  
  if test and ISWorldObjectContextMenu.Test then return true end
  
  local square = nil;
  
  for i,v in ipairs(worldobjects) do
      square = v:getSquare();
      break;
  end
  
  local playerObj = getSpecificPlayer(player)
  local playerInv = playerObj:getInventory()

  local clickedPlayer = getISOPlayer(worldobjects, playerObj)

  -- Hazardous Zones menu

  local HZMenu = context:addDebugOption("Hazardous Zones", worldobjects, nil);
  local HZSubMenu = ISContextMenu:getNew(context);
  context:addSubMenu(HZMenu, HZSubMenu);

  -- Zones

  local HZZonesOptions = HZSubMenu:addOption("Zones", worldobjects, nil);
  local HZZonesSubMenu = HZSubMenu:getNew(HZSubMenu)
  context:addSubMenu(HZZonesOptions, HZZonesSubMenu)

  HZZonesSubMenu:addOption("Create new zone", square, HZDebugContextMenu.onCreateZoneUI, playerObj)
  HZZonesSubMenu:addOption("Zones list", playerObj, HZDebugContextMenu.onZonesListUI)
  
  -- RND Zones

  local HZRndZonesOptions = HZSubMenu:addOption("Random Zones", worldobjects, nil);

  HZRndZonesOptions.notAvailable = not SandboxVars.HZ.RandomZones

  if not SandboxVars.HZ.RandomZones then
    local tooltip = ISWorldObjectContextMenu.addToolTip()
    tooltip:setName("Random Zones are disabled");
    tooltip.description = "This feature is disabled in the Sandbox Options. You have to enable it first.";
    HZRndZonesOptions.toolTip = tooltip
  else
    local HZRndZonesSubMenu = HZSubMenu:getNew(HZSubMenu)
    context:addSubMenu(HZRndZonesOptions, HZRndZonesSubMenu)
    HZRndZonesSubMenu:addOption("Create new random zone", playerObj, HZDebugContextMenu.onCreateRndZone)
    HZRndZonesSubMenu:addOption("Random Zones list", playerObj, HZDebugContextMenu.onRndZonesListUI)
  end

  local targetPlayer = clickedPlayer or playerObj

  -- Player settings
  local HZPlayerOptions = HZSubMenu:addOption("Player settings for: ".. targetPlayer:getUsername(), worldobjects, nil);
  local HZPlayerSubMenu = HZSubMenu:getNew(HZSubMenu)
  context:addSubMenu(HZPlayerOptions, HZPlayerSubMenu)

  local HZSetPlayerExpOptions = HZPlayerSubMenu:addOption("Set exposure level", worldobjects, nil);
  local HZSetPlayerExpSubMenu = HZSubMenu:getNew(HZPlayerSubMenu);
  context:addSubMenu(HZSetPlayerExpOptions, HZSetPlayerExpSubMenu);

  local HZSetRadiationExposureOptions = HZSetPlayerExpSubMenu:addOption("Nuclear radiation", worldobjects, nil);
  local HZSetRadiationExposureSubMenu = HZSubMenu:getNew(HZSetPlayerExpSubMenu);
  context:addSubMenu(HZSetRadiationExposureOptions, HZSetRadiationExposureSubMenu);

  HZSetRadiationExposureSubMenu:addOption("None (0 RAD)", { player = targetPlayer, isRemotePlayer = clickedPlayer, rad = 0 }, HZDebugContextMenu.onSetRadiationExposureUI)
  HZSetRadiationExposureSubMenu:addOption("Minor (100 RAD)", { player = targetPlayer, isRemotePlayer = clickedPlayer, rad = 100 }, HZDebugContextMenu.onSetRadiationExposureUI)
  HZSetRadiationExposureSubMenu:addOption("Major (300 RAD)", { player = targetPlayer, isRemotePlayer = clickedPlayer, rad = 300 }, HZDebugContextMenu.onSetRadiationExposureUI)
  HZSetRadiationExposureSubMenu:addOption("Moderate (600 RAD)", { player = targetPlayer, isRemotePlayer = clickedPlayer, rad = 600 }, HZDebugContextMenu.onSetRadiationExposureUI)
  HZSetRadiationExposureSubMenu:addOption("Severe (900 RAD)", { player = targetPlayer, isRemotePlayer = clickedPlayer, rad = 900 }, HZDebugContextMenu.onSetRadiationExposureUI)
  HZSetRadiationExposureSubMenu:addOption("Heavy (1200 RAD)", { player = targetPlayer, isRemotePlayer = clickedPlayer, rad = 1200 }, HZDebugContextMenu.onSetRadiationExposureUI)
  HZSetRadiationExposureSubMenu:addOption("Deadly (1800 RAD)", { player = targetPlayer, isRemotePlayer = clickedPlayer, rad = 1800 }, HZDebugContextMenu.onSetRadiationExposureUI)
  

  local HZSetBiohazardExposureOptions = HZSetPlayerExpSubMenu:addOption("Biohazard infection", worldobjects, nil);
  local HZSetBiohazardExposureSubMenu = HZSubMenu:getNew(HZSetPlayerExpSubMenu);
  context:addSubMenu(HZSetBiohazardExposureOptions, HZSetBiohazardExposureSubMenu);

  HZSetBiohazardExposureSubMenu:addOption("None (0 BHX)", { player = targetPlayer, isRemotePlayer = clickedPlayer, bhx = 0 }, HZDebugContextMenu.onSetBiohazardExposureUI)
  HZSetBiohazardExposureSubMenu:addOption("Minor (100 BHX)", { player = targetPlayer, isRemotePlayer = clickedPlayer, bhx = 100 }, HZDebugContextMenu.onSetBiohazardExposureUI)
  HZSetBiohazardExposureSubMenu:addOption("Major (300 BHX)", { player = targetPlayer, isRemotePlayer = clickedPlayer, bhx = 300 }, HZDebugContextMenu.onSetBiohazardExposureUI)
  HZSetBiohazardExposureSubMenu:addOption("Moderate (600 BHX)", { player = targetPlayer, isRemotePlayer = clickedPlayer, bhx = 600 }, HZDebugContextMenu.onSetBiohazardExposureUI)
  HZSetBiohazardExposureSubMenu:addOption("Severe (900 BHX)", { player = targetPlayer, isRemotePlayer = clickedPlayer, bhx = 900 }, HZDebugContextMenu.onSetBiohazardExposureUI)
  HZSetBiohazardExposureSubMenu:addOption("Heavy (1200 BHX)", { player = targetPlayer, isRemotePlayer = clickedPlayer, bhx = 1200 }, HZDebugContextMenu.onSetBiohazardExposureUI)
  HZSetBiohazardExposureSubMenu:addOption("Deadly (1800 BHX)", { player = targetPlayer, isRemotePlayer = clickedPlayer, bhx = 1800 }, HZDebugContextMenu.onSetBiohazardExposureUI)  
end


function HZDebugContextMenu.onCreateZoneUI(square, player)
  local ui = HZCreateZoneUI:new(0, 0, player, square);
	ui:initialise();
	ui:addToUIManager();
end

function HZDebugContextMenu.onCreateRndZone(player)
  local zone = HZUtils:createRandomZone()
  
  sendClientCommand(getPlayer(), "HazardousZones", "AddRndZone", { zone = zone, spawnZeds = false, zedCount = 0 })

  player:setHaloNote(getText("ContextMenu_HZAdminRandomZoneCreated"), 250)

end

function HZDebugContextMenu.onHideZonesUI(player)
  HZSettings.Debug.ShowZones = false
  if markers then
    for i, marker in ipairs(markers) do
		  marker:remove();
		  marker = nil;
    end
	end
end

function HZDebugContextMenu.onRemoveExposureUI(player)
  if player then
    player:setHaloNote(getText("ContextMenu_HZAdminExposuresRemoved"), 250)
    HZ:removePlayerExposures("all")
  end
end

function HZDebugContextMenu.onRemoteRemoveExposureUI(remotePlayer)
  if remotePlayer and getPlayer():getAccessLevel() == "Admin" then
    sendClientCommand(getPlayer(), "HazardousZones", "RemoteRemoveExposure", { remotePlayer = remotePlayer:getUsername() })
    getPlayer():setHaloNote(string.format(getText("ContextMenu_HZAdminExposuresRemovedFrom").." %s", remotePlayer:getUsername()), 250)
  end
end

function HZDebugContextMenu.onZonesListUI(player)
  local ui = HZZonesListUI:new(0, 0, player);
	ui:initialise();
	ui:addToUIManager();
end

function HZDebugContextMenu.onRndZonesListUI(player)
  local ui = HZRndZonesListUI:new(0, 0, player);
	ui:initialise();
	ui:addToUIManager();
end

function HZDebugContextMenu.onSetRadiationExposureUI(data)
  local text = nil
  if data.isRemotePlayer then
    sendClientCommand(getPlayer(), "HazardousZones", "RemoteSetExposure", { remotePlayer = data.player:getUsername(), type = "radiation", value = data.rad })
    text = string.format(getText("ContextMenu_HZAdminRemoteSetExposureTextRad"), tostring(data.rad), data.player:getUsername())
  else
    HZ:setPlayerExposure("radiation", data.rad)
    text = string.format(getText("ContextMenu_HZAdminSetExposureTextRad"), tostring(data.rad))
  end

  if text then
    getPlayer():setHaloNote(text, 250)
  end
end

function HZDebugContextMenu.onSetBiohazardExposureUI(data)
  local text = nil
  if data.isRemotePlayer then
    sendClientCommand(getPlayer(), "HazardousZones", "RemoteSetExposure", { remotePlayer = data.player:getUsername(), type = "biological", value = data.bhx })
    text = string.format(getText("ContextMenu_HZAdminRemoteSetExposureTextBhx"), tostring(data.bhx), data.player:getUsername())
  else
    HZ:setPlayerExposure("biological", data.bhx)
    text = string.format(getText("ContextMenu_HZAdminSetExposureTextBhx"), tostring(data.bhx))
  end

  if text then
    getPlayer():setHaloNote(text, 250)
  end
end

Events.OnFillWorldObjectContextMenu.Add(HZDebugContextMenu.doMenu)