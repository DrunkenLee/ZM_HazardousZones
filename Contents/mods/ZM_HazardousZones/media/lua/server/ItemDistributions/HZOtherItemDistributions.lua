require 'Items/SuburbsDistributions'
require 'Vehicles/VehicleDistributions'
require "Items/ProceduralDistributions"
require 'Items/Distributions'
require 'Items/ItemPicker'

--FilingCabinetGeneric
table.insert(ProceduralDistributions.list["FilingCabinetGeneric"].items, "HazardousZones.HZMilitaryMapPieces");
table.insert(ProceduralDistributions.list["FilingCabinetGeneric"].items, 0.001);

table.insert(ProceduralDistributions.list["PoliceLockers"].items, "HazardousZones.HZMilitaryMapPieces");
table.insert(ProceduralDistributions.list["PoliceLockers"].items, 0.001);

table.insert(ProceduralDistributions.list["PrisonGuardLockers"].items, "HazardousZones.HZMilitaryMapPieces");
table.insert(ProceduralDistributions.list["PrisonGuardLockers"].items, 0.001);

table.insert(ProceduralDistributions.list["SecurityLockers"].items, "HazardousZones.HZMilitaryMapPieces");
table.insert(ProceduralDistributions.list["SecurityLockers"].items, 0.001);

table.insert(SuburbsDistributions["all"]["Outfit_ArmyCamoDesert"].items, "HazardousZones.HZMilitaryMapPieces");
table.insert(SuburbsDistributions["all"]["Outfit_ArmyCamoDesert"].items, 0.01);

table.insert(SuburbsDistributions["all"]["Outfit_ArmyCamoGreen"].items, "HazardousZones.HZMilitaryMapPieces");
table.insert(SuburbsDistributions["all"]["Outfit_ArmyCamoGreen"].items, 0.01);

table.insert(SuburbsDistributions["all"]["Outfit_Bandit"].items, "HazardousZones.HZMilitaryMapPieces");
table.insert(SuburbsDistributions["all"]["Outfit_Bandit"].items, 0.001);

table.insert(SuburbsDistributions["all"]["Outfit_Ghillie"].items, "HazardousZones.HZMilitaryMapPieces");
table.insert(SuburbsDistributions["all"]["Outfit_Ghillie"].items, 0.1);

table.insert(SuburbsDistributions["all"]["Outfit_PrivateMilitia"].items, "HazardousZones.HZMilitaryMapPieces");
table.insert(SuburbsDistributions["all"]["Outfit_PrivateMilitia"].items, 0.1);

table.insert(SuburbsDistributions["all"]["Outfit_Survivalist"].items, "HazardousZones.HZMilitaryMapPieces");
table.insert(SuburbsDistributions["all"]["Outfit_Survivalist"].items, 0.01);

table.insert(SuburbsDistributions["all"]["Outfit_Survivalist02"].items, "HazardousZones.HZMilitaryMapPieces");
table.insert(SuburbsDistributions["all"]["Outfit_Survivalist02"].items, 0.01);

table.insert(SuburbsDistributions["all"]["Outfit_Survivalist03"].items, "HazardousZones.HZMilitaryMapPieces");
table.insert(SuburbsDistributions["all"]["Outfit_Survivalist03"].items, 0.01);