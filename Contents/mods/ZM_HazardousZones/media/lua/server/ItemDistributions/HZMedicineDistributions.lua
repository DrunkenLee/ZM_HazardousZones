require 'Items/SuburbsDistributions'
require 'Vehicles/VehicleDistributions'
require "Items/ProceduralDistributions"
require 'Items/Distributions'
require 'Items/ItemPicker'

require 'Items/SuburbsDistributions'
require 'Vehicles/VehicleDistributions'
require "Items/ProceduralDistributions"
require 'Items/Distributions'
require 'Items/ItemPicker'

--ArmyStorageMedical/Iodine
table.insert(ProceduralDistributions.list["ArmyStorageMedical"].items, "HazardousZones.HZIodinePillSingle");
table.insert(ProceduralDistributions.list["ArmyStorageMedical"].items, 10);
table.insert(ProceduralDistributions.list["ArmyStorageMedical"].items, "HazardousZones.HZIodinePillsBottle");
table.insert(ProceduralDistributions.list["ArmyStorageMedical"].items, 2);
table.insert(ProceduralDistributions.list["ArmyStorageMedical"].items, "HazardousZones.HZIndralineSyringe");
table.insert(ProceduralDistributions.list["ArmyStorageMedical"].items, 1);

--ArmyStorageMedical/Toxiguard/BioShield
table.insert(ProceduralDistributions.list["ArmyStorageMedical"].items, "HazardousZones.HZToxiguardPillSingle");
table.insert(ProceduralDistributions.list["ArmyStorageMedical"].items, 10);
table.insert(ProceduralDistributions.list["ArmyStorageMedical"].items, "HazardousZones.HZToxiguardPack");
table.insert(ProceduralDistributions.list["ArmyStorageMedical"].items, 2);
table.insert(ProceduralDistributions.list["ArmyStorageMedical"].items, "HazardousZones.HZBioshieldRxSyringe");
table.insert(ProceduralDistributions.list["ArmyStorageMedical"].items, 1);

--ArmyStorageMedical/BloodTestKit
table.insert(ProceduralDistributions.list["ArmyStorageMedical"].items, "HazardousZones.HZBloodTestKit");
table.insert(ProceduralDistributions.list["ArmyStorageMedical"].items, 1);
table.insert(ProceduralDistributions.list["ArmyStorageMedical"].items, "HazardousZones.HZBloodCollectionSyringe");
table.insert(ProceduralDistributions.list["ArmyStorageMedical"].items, 2);
table.insert(ProceduralDistributions.list["ArmyStorageMedical"].items, "HazardousZones.HZBloodQuickTest");
table.insert(ProceduralDistributions.list["ArmyStorageMedical"].items, 2);

--DrugLabSupplies/Iodine
table.insert(ProceduralDistributions.list["DrugLabSupplies"].items, "HazardousZones.HZIodinePillSingle");
table.insert(ProceduralDistributions.list["DrugLabSupplies"].items, 5);
table.insert(ProceduralDistributions.list["DrugLabSupplies"].items, "HazardousZones.HZIodidePowder");
table.insert(ProceduralDistributions.list["DrugLabSupplies"].items, 2);
table.insert(ProceduralDistributions.list["DrugLabSupplies"].items, "HazardousZones.HZKILiquidMixture");
table.insert(ProceduralDistributions.list["DrugLabSupplies"].items, 2);
table.insert(ProceduralDistributions.list["DrugLabSupplies"].items, "HazardousZones.HZIodinePillsBottle");
table.insert(ProceduralDistributions.list["DrugLabSupplies"].items, 1);
table.insert(ProceduralDistributions.list["DrugLabSupplies"].items, "HazardousZones.HZIndralineSyringe");
table.insert(ProceduralDistributions.list["DrugLabSupplies"].items, 0.5);

--DrugLabSupplies/Toxiguard/Bioshield
table.insert(ProceduralDistributions.list["DrugLabSupplies"].items, "HazardousZones.HZToxiguardPillSingle");
table.insert(ProceduralDistributions.list["DrugLabSupplies"].items, 5);
table.insert(ProceduralDistributions.list["DrugLabSupplies"].items, "HazardousZones.HZToxiguardPack");
table.insert(ProceduralDistributions.list["DrugLabSupplies"].items, 1);
table.insert(ProceduralDistributions.list["DrugLabSupplies"].items, "HazardousZones.HZBioshieldRxSyringe");
table.insert(ProceduralDistributions.list["DrugLabSupplies"].items, 0.5);

--DrugLabSupplies/BloodTestKit
table.insert(ProceduralDistributions.list["DrugLabSupplies"].items, "HazardousZones.HZBloodTestKit");
table.insert(ProceduralDistributions.list["DrugLabSupplies"].items, 0.05);
table.insert(ProceduralDistributions.list["DrugLabSupplies"].items, "HazardousZones.HZBloodCollectionSyringe");
table.insert(ProceduralDistributions.list["DrugLabSupplies"].items, 1);
table.insert(ProceduralDistributions.list["DrugLabSupplies"].items, "HazardousZones.HZBloodQuickTest");
table.insert(ProceduralDistributions.list["DrugLabSupplies"].items, 1);

--DrugShackDrugs/Iodine
table.insert(ProceduralDistributions.list["DrugShackDrugs"].items, "HazardousZones.HZIodinePillSingle");
table.insert(ProceduralDistributions.list["DrugShackDrugs"].items, 1);
table.insert(ProceduralDistributions.list["DrugShackDrugs"].items, "HazardousZones.HZIodidePowder");
table.insert(ProceduralDistributions.list["DrugShackDrugs"].items, 0.4);
table.insert(ProceduralDistributions.list["DrugShackDrugs"].items, "HazardousZones.HZKILiquidMixture");
table.insert(ProceduralDistributions.list["DrugShackDrugs"].items, 0.4);
table.insert(ProceduralDistributions.list["DrugShackDrugs"].items, "HazardousZones.HZIodinePillsBottle");
table.insert(ProceduralDistributions.list["DrugShackDrugs"].items, 0.2);

--DrugShackDrugs/Toxiguard/Bioshield
table.insert(ProceduralDistributions.list["DrugShackDrugs"].items, "HazardousZones.HZToxiguardPillSingle");
table.insert(ProceduralDistributions.list["DrugShackDrugs"].items, 1);
table.insert(ProceduralDistributions.list["DrugShackDrugs"].items, "HazardousZones.HZToxiguardPack");
table.insert(ProceduralDistributions.list["DrugShackDrugs"].items, 0.2);
table.insert(ProceduralDistributions.list["DrugShackDrugs"].items, "HazardousZones.HZBioshieldRxSyringe");
table.insert(ProceduralDistributions.list["DrugShackDrugs"].items, 0.1);

--DrugShackDrugs/BloodTestKit
table.insert(ProceduralDistributions.list["DrugShackDrugs"].items, "HazardousZones.HZBloodTestKit");
table.insert(ProceduralDistributions.list["DrugShackDrugs"].items, 0.05);
table.insert(ProceduralDistributions.list["DrugShackDrugs"].items, "HazardousZones.HZBloodCollectionSyringe");
table.insert(ProceduralDistributions.list["DrugShackDrugs"].items, 1);
table.insert(ProceduralDistributions.list["DrugShackDrugs"].items, "HazardousZones.HZBloodQuickTest");
table.insert(ProceduralDistributions.list["DrugShackDrugs"].items, 1);

--FireDeptLockers/Iodine
table.insert(ProceduralDistributions.list["FireDeptLockers"].items, "HazardousZones.HZIodinePillSingle");
table.insert(ProceduralDistributions.list["FireDeptLockers"].items, 0.5);
table.insert(ProceduralDistributions.list["FireDeptLockers"].items, "HazardousZones.HZIndralineSyringe");
table.insert(ProceduralDistributions.list["FireDeptLockers"].items, 0.1);

--FireDeptLockers/Toxiguard/Bioshield
table.insert(ProceduralDistributions.list["FireDeptLockers"].items, "HazardousZones.HZToxiguardPillSingle");
table.insert(ProceduralDistributions.list["FireDeptLockers"].items, 0.5);
table.insert(ProceduralDistributions.list["FireDeptLockers"].items, "HazardousZones.HZToxiguardPack");
table.insert(ProceduralDistributions.list["FireDeptLockers"].items, 0.1);

--LockerArmyBedroom/Iodine
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "HazardousZones.HZIodinePillSingle");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 5);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "HazardousZones.HZIodinePillsBottle");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 1);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "HazardousZones.HZIndralineSyringe");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.1);

--LockerArmyBedroom/Toxiguard/Bioshield
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "HazardousZones.HZToxiguardPillSingle");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 5);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "HazardousZones.HZToxiguardPack");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 1);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "HazardousZones.HZBioshieldRxSyringe");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 0.1);

--MedicalStorageDrugs/Iodine
table.insert(ProceduralDistributions.list["MedicalStorageDrugs"].items, "HazardousZones.HZIodinePillSingle");
table.insert(ProceduralDistributions.list["MedicalStorageDrugs"].items, 5);
table.insert(ProceduralDistributions.list["MedicalStorageDrugs"].items, "HazardousZones.HZIodinePillsBottle");
table.insert(ProceduralDistributions.list["MedicalStorageDrugs"].items, 2);
table.insert(ProceduralDistributions.list["MedicalStorageDrugs"].items, "HazardousZones.HZIndralineSyringe");
table.insert(ProceduralDistributions.list["MedicalStorageDrugs"].items, 1);

--MedicalStorageDrugs/Toxiguard/Bioshield
table.insert(ProceduralDistributions.list["MedicalStorageDrugs"].items, "HazardousZones.HZToxiguardPillSingle");
table.insert(ProceduralDistributions.list["MedicalStorageDrugs"].items, 5);
table.insert(ProceduralDistributions.list["MedicalStorageDrugs"].items, "HazardousZones.HZToxiguardPack");
table.insert(ProceduralDistributions.list["MedicalStorageDrugs"].items, 2);
table.insert(ProceduralDistributions.list["MedicalStorageDrugs"].items, "HazardousZones.HZBioshieldRxSyringe");
table.insert(ProceduralDistributions.list["MedicalStorageDrugs"].items, 1);

--MedicalStorageDrugs/BloodTestKit
table.insert(ProceduralDistributions.list["MedicalStorageDrugs"].items, "HazardousZones.HZBloodTestKit");
table.insert(ProceduralDistributions.list["MedicalStorageDrugs"].items, 5);
table.insert(ProceduralDistributions.list["MedicalStorageDrugs"].items, "HazardousZones.HZBloodCollectionSyringe");
table.insert(ProceduralDistributions.list["MedicalStorageDrugs"].items, 2);
table.insert(ProceduralDistributions.list["MedicalStorageDrugs"].items, "HazardousZones.HZBloodQuickTest");
table.insert(ProceduralDistributions.list["MedicalStorageDrugs"].items, 1);

--MedicalClinicDrugs/Iodine
table.insert(ProceduralDistributions.list["MedicalClinicDrugs"].items, "HazardousZones.HZIodinePillSingle");
table.insert(ProceduralDistributions.list["MedicalClinicDrugs"].items, 5);
table.insert(ProceduralDistributions.list["MedicalClinicDrugs"].items, "HazardousZones.HZIodinePillsBottle");
table.insert(ProceduralDistributions.list["MedicalClinicDrugs"].items, 2);
table.insert(ProceduralDistributions.list["MedicalClinicDrugs"].items, "HazardousZones.HZIndralineSyringe");
table.insert(ProceduralDistributions.list["MedicalClinicDrugs"].items, 1);

--MedicalClinicDrugs/Toxiguard/Bioshield
table.insert(ProceduralDistributions.list["MedicalClinicDrugs"].items, "HazardousZones.HZToxiguardPillSingle");
table.insert(ProceduralDistributions.list["MedicalClinicDrugs"].items, 5);
table.insert(ProceduralDistributions.list["MedicalClinicDrugs"].items, "HazardousZones.HZToxiguardPack");
table.insert(ProceduralDistributions.list["MedicalClinicDrugs"].items, 2);
table.insert(ProceduralDistributions.list["MedicalClinicDrugs"].items, "HazardousZones.HZBioshieldRxSyringe");
table.insert(ProceduralDistributions.list["MedicalClinicDrugs"].items, 1);

--MedicalClinicDrugs/BloodTestKit
table.insert(ProceduralDistributions.list["MedicalClinicDrugs"].items, "HazardousZones.HZBloodTestKit");
table.insert(ProceduralDistributions.list["MedicalClinicDrugs"].items, 5);
table.insert(ProceduralDistributions.list["MedicalClinicDrugs"].items, "HazardousZones.HZBloodCollectionSyringe");
table.insert(ProceduralDistributions.list["MedicalClinicDrugs"].items, 2);
table.insert(ProceduralDistributions.list["MedicalClinicDrugs"].items, "HazardousZones.HZBloodQuickTest");
table.insert(ProceduralDistributions.list["MedicalClinicDrugs"].items, 1);

--MedicalStorageTools/Iodine
table.insert(ProceduralDistributions.list["MedicalStorageTools"].items, "HazardousZones.HZIodinePillSingle");
table.insert(ProceduralDistributions.list["MedicalStorageTools"].items, 10);
table.insert(ProceduralDistributions.list["MedicalStorageTools"].items, "HazardousZones.HZIodinePillsBottle");
table.insert(ProceduralDistributions.list["MedicalStorageTools"].items, 2);
table.insert(ProceduralDistributions.list["MedicalStorageTools"].items, "HazardousZones.HZIndralineSyringe");
table.insert(ProceduralDistributions.list["MedicalStorageTools"].items, 2);

--MedicalStorageTools/Toxiguard/Bioshield
table.insert(ProceduralDistributions.list["MedicalStorageTools"].items, "HazardousZones.HZToxiguardPillSingle");
table.insert(ProceduralDistributions.list["MedicalStorageTools"].items, 10);
table.insert(ProceduralDistributions.list["MedicalStorageTools"].items, "HazardousZones.HZToxiguardPack");
table.insert(ProceduralDistributions.list["MedicalStorageTools"].items, 2);
table.insert(ProceduralDistributions.list["MedicalStorageTools"].items, "HazardousZones.HZBioshieldRxSyringe");
table.insert(ProceduralDistributions.list["MedicalStorageTools"].items, 2);

--MedicalStorageTools/BloodTestKit
table.insert(ProceduralDistributions.list["MedicalStorageTools"].items, "HazardousZones.HZBloodTestKit");
table.insert(ProceduralDistributions.list["MedicalStorageTools"].items, 5);
table.insert(ProceduralDistributions.list["MedicalStorageTools"].items, "HazardousZones.HZBloodCollectionSyringe");
table.insert(ProceduralDistributions.list["MedicalStorageTools"].items, 2);
table.insert(ProceduralDistributions.list["MedicalStorageTools"].items, "HazardousZones.HZBloodQuickTest");
table.insert(ProceduralDistributions.list["MedicalStorageTools"].items, 1);

--PharmacyCosmetics/Iodine
table.insert(ProceduralDistributions.list["PharmacyCosmetics"].items, "HazardousZones.HZIodinePillSingle");
table.insert(ProceduralDistributions.list["PharmacyCosmetics"].items, 1);
table.insert(ProceduralDistributions.list["PharmacyCosmetics"].items, "HazardousZones.HZIndralineSyringe");
table.insert(ProceduralDistributions.list["PharmacyCosmetics"].items, 0.2);

--PharmacyCosmetics/Toxiguard/Bioshield
table.insert(ProceduralDistributions.list["PharmacyCosmetics"].items, "HazardousZones.HZToxiguardPillSingle");
table.insert(ProceduralDistributions.list["PharmacyCosmetics"].items, 1);
table.insert(ProceduralDistributions.list["PharmacyCosmetics"].items, "HazardousZones.HZBioshieldRxSyringe");
table.insert(ProceduralDistributions.list["PharmacyCosmetics"].items, 0.2);

--PharmacyCosmetics/BloodTestKit
table.insert(ProceduralDistributions.list["PharmacyCosmetics"].items, "HazardousZones.HZBloodCollectionSyringe");
table.insert(ProceduralDistributions.list["PharmacyCosmetics"].items, 0.2);
table.insert(ProceduralDistributions.list["PharmacyCosmetics"].items, "HazardousZones.HZBloodQuickTest");
table.insert(ProceduralDistributions.list["PharmacyCosmetics"].items, 0.2);

--SafehouseMedical/Iodine
table.insert(ProceduralDistributions.list["SafehouseMedical"].items, "HazardousZones.HZIodinePillSingle");
table.insert(ProceduralDistributions.list["SafehouseMedical"].items, 3);
table.insert(ProceduralDistributions.list["SafehouseMedical"].items, "HazardousZones.HZIodinePillsBottle");
table.insert(ProceduralDistributions.list["SafehouseMedical"].items, 0.5);
table.insert(ProceduralDistributions.list["SafehouseMedical"].items, "HazardousZones.HZIndralineSyringe");
table.insert(ProceduralDistributions.list["SafehouseMedical"].items, 0.5);

--SafehouseMedical/Toxiguard/Bioshield
table.insert(ProceduralDistributions.list["SafehouseMedical"].items, "HazardousZones.HZToxiguardPillSingle");
table.insert(ProceduralDistributions.list["SafehouseMedical"].items, 3);
table.insert(ProceduralDistributions.list["SafehouseMedical"].items, "HazardousZones.HZToxiguardPack");
table.insert(ProceduralDistributions.list["SafehouseMedical"].items, 0.5);
table.insert(ProceduralDistributions.list["MedicalStorageTools"].items, "HazardousZones.HZBioshieldRxSyringe");
table.insert(ProceduralDistributions.list["MedicalStorageTools"].items, 0.5);

--SafehouseMedical/BloodTestKit
table.insert(ProceduralDistributions.list["SafehouseMedical"].items, "HazardousZones.HZBloodTestKit");
table.insert(ProceduralDistributions.list["SafehouseMedical"].items, 0.5);
table.insert(ProceduralDistributions.list["SafehouseMedical"].items, "HazardousZones.HZBloodCollectionSyringe");
table.insert(ProceduralDistributions.list["SafehouseMedical"].items, 1);
table.insert(ProceduralDistributions.list["SafehouseMedical"].items, "HazardousZones.HZBloodQuickTest");
table.insert(ProceduralDistributions.list["SafehouseMedical"].items, 1);

--PoliceEvidence/Iodine
table.insert(ProceduralDistributions.list["PoliceEvidence"].items, "HazardousZones.HZIodinePillSingle");
table.insert(ProceduralDistributions.list["PoliceEvidence"].items, 1);

--PoliceEvidence/Toxiguard/Bioshield
table.insert(ProceduralDistributions.list["PoliceEvidence"].items, "HazardousZones.HZToxiguardPillSingle");
table.insert(ProceduralDistributions.list["PoliceEvidence"].items, 1);

--PoliceLockers/Iodine
table.insert(ProceduralDistributions.list["PoliceLockers"].items, "HazardousZones.HZIodinePillSingle");
table.insert(ProceduralDistributions.list["PoliceLockers"].items, 1);
table.insert(ProceduralDistributions.list["PoliceLockers"].items, "HazardousZones.HZIndralineSyringe");
table.insert(ProceduralDistributions.list["PoliceLockers"].items, 0.5);

--PoliceLockers/Toxiguard/Bioshield
table.insert(ProceduralDistributions.list["PoliceLockers"].items, "HazardousZones.HZToxiguardPillSingle");
table.insert(ProceduralDistributions.list["PoliceLockers"].items, 1);
table.insert(ProceduralDistributions.list["PoliceLockers"].items, "HazardousZones.HZBioshieldRxSyringe");
table.insert(ProceduralDistributions.list["PoliceLockers"].items, 0.5);

--PoliceLockers/BloodTestKit
table.insert(ProceduralDistributions.list["PoliceLockers"].items, "HazardousZones.HZBloodTestKit");
table.insert(ProceduralDistributions.list["PoliceLockers"].items, 0.05);
table.insert(ProceduralDistributions.list["PoliceLockers"].items, "HazardousZones.HZBloodCollectionSyringe");
table.insert(ProceduralDistributions.list["PoliceLockers"].items, 1);
table.insert(ProceduralDistributions.list["PoliceLockers"].items, "HazardousZones.HZBloodQuickTest");
table.insert(ProceduralDistributions.list["PoliceLockers"].items, 0.5);

--PoolLockers/Iodine
table.insert(ProceduralDistributions.list["PoolLockers"].items, "HazardousZones.HZIodinePillSingle");
table.insert(ProceduralDistributions.list["PoolLockers"].items, 0.5);
table.insert(ProceduralDistributions.list["PoolLockers"].items, "HazardousZones.HZIodinePillsBottle");
table.insert(ProceduralDistributions.list["PoolLockers"].items, 0.05);
table.insert(ProceduralDistributions.list["PoolLockers"].items, "HazardousZones.HZIndralineSyringe");
table.insert(ProceduralDistributions.list["PoolLockers"].items, 0.05);

--PoolLockers/Toxiguard/Bioshield
table.insert(ProceduralDistributions.list["PoolLockers"].items, "HazardousZones.HZToxiguardPillSingle");
table.insert(ProceduralDistributions.list["PoolLockers"].items, 0.5);
table.insert(ProceduralDistributions.list["PoolLockers"].items, "HazardousZones.HZToxiguardPack");
table.insert(ProceduralDistributions.list["PoolLockers"].items, 0.05);
table.insert(ProceduralDistributions.list["PoolLockers"].items, "HazardousZones.HZBioshieldRxSyringe");
table.insert(ProceduralDistributions.list["PoolLockers"].items, 0.05);

--PrisonGuardLockers/Iodine
table.insert(ProceduralDistributions.list["PrisonGuardLockers"].items, "HazardousZones.HZIodinePillSingle");
table.insert(ProceduralDistributions.list["PrisonGuardLockers"].items, 2);
table.insert(ProceduralDistributions.list["PrisonGuardLockers"].items, "HazardousZones.HZIodinePillsBottle");
table.insert(ProceduralDistributions.list["PrisonGuardLockers"].items, 0.5);
table.insert(ProceduralDistributions.list["PrisonGuardLockers"].items, "HazardousZones.HZIndralineSyringe");
table.insert(ProceduralDistributions.list["PrisonGuardLockers"].items, 0.05);

--PrisonGuardLockers/Toxiguard/Bioshield
table.insert(ProceduralDistributions.list["PrisonGuardLockers"].items, "HazardousZones.HZToxiguardPillSingle");
table.insert(ProceduralDistributions.list["PrisonGuardLockers"].items, 2);
table.insert(ProceduralDistributions.list["PrisonGuardLockers"].items, "HazardousZones.HZToxiguardPack");
table.insert(ProceduralDistributions.list["PrisonGuardLockers"].items, 0.5);
table.insert(ProceduralDistributions.list["PrisonGuardLockers"].items, "HazardousZones.HZBioshieldRxSyringe");
table.insert(ProceduralDistributions.list["PrisonGuardLockers"].items, 0.05);

--StoreShelfMedical/Iodine
table.insert(ProceduralDistributions.list["StoreShelfMedical"].items, "HazardousZones.HZIodinePillSingle");
table.insert(ProceduralDistributions.list["StoreShelfMedical"].items, 5);
table.insert(ProceduralDistributions.list["StoreShelfMedical"].items, "HazardousZones.HZIodinePillsBottle");
table.insert(ProceduralDistributions.list["StoreShelfMedical"].items, 1);
table.insert(ProceduralDistributions.list["StoreShelfMedical"].items, "HazardousZones.HZIndralineSyringe");
table.insert(ProceduralDistributions.list["StoreShelfMedical"].items, 1);

--StoreShelfMedical/Toxiguard/Bioshield
table.insert(ProceduralDistributions.list["StoreShelfMedical"].items, "HazardousZones.HZToxiguardPillSingle");
table.insert(ProceduralDistributions.list["StoreShelfMedical"].items, 5);
table.insert(ProceduralDistributions.list["StoreShelfMedical"].items, "HazardousZones.HZToxiguardPack");
table.insert(ProceduralDistributions.list["StoreShelfMedical"].items, 1);
table.insert(ProceduralDistributions.list["StoreShelfMedical"].items, "HazardousZones.HZBioshieldRxSyringe");
table.insert(ProceduralDistributions.list["StoreShelfMedical"].items, 1);

--StoreShelfMedical/BloodTestKit
table.insert(ProceduralDistributions.list["StoreShelfMedical"].items, "HazardousZones.HZBloodTestKit");
table.insert(ProceduralDistributions.list["StoreShelfMedical"].items, 1);
table.insert(ProceduralDistributions.list["StoreShelfMedical"].items, "HazardousZones.HZBloodCollectionSyringe");
table.insert(ProceduralDistributions.list["StoreShelfMedical"].items, 3);
table.insert(ProceduralDistributions.list["StoreShelfMedical"].items, "HazardousZones.HZBloodQuickTest");
table.insert(ProceduralDistributions.list["StoreShelfMedical"].items, 3);

--TestingLab/Iodine
table.insert(ProceduralDistributions.list["TestingLab"].items, "HazardousZones.HZIodinePillSingle");
table.insert(ProceduralDistributions.list["TestingLab"].items, 5);
table.insert(ProceduralDistributions.list["TestingLab"].items, "HazardousZones.HZIodinePillsBottle");
table.insert(ProceduralDistributions.list["TestingLab"].items, 1);
table.insert(ProceduralDistributions.list["TestingLab"].items, "HazardousZones.HZIndralineSyringe");
table.insert(ProceduralDistributions.list["TestingLab"].items, 1);

--TestingLab/Toxiguard/Bioshield
table.insert(ProceduralDistributions.list["TestingLab"].items, "HazardousZones.HZToxiguardPillSingle");
table.insert(ProceduralDistributions.list["TestingLab"].items, 5);
table.insert(ProceduralDistributions.list["TestingLab"].items, "HazardousZones.HZToxiguardPack");
table.insert(ProceduralDistributions.list["TestingLab"].items, 1);
table.insert(ProceduralDistributions.list["TestingLab"].items, "HazardousZones.HZBioshieldRxSyringe");
table.insert(ProceduralDistributions.list["TestingLab"].items, 1);

--TestingLab/BloodTestKit
table.insert(ProceduralDistributions.list["TestingLab"].items, "HazardousZones.HZBloodTestKit");
table.insert(ProceduralDistributions.list["TestingLab"].items, 1);
table.insert(ProceduralDistributions.list["TestingLab"].items, "HazardousZones.HZBloodCollectionSyringe");
table.insert(ProceduralDistributions.list["TestingLab"].items, 3);
table.insert(ProceduralDistributions.list["TestingLab"].items, "HazardousZones.HZBloodQuickTest");
table.insert(ProceduralDistributions.list["TestingLab"].items, 3);

--SurvivalGear/Iodine
table.insert(ProceduralDistributions.list["SurvivalGear"].items, "HazardousZones.HZIodinePillSingle");
table.insert(ProceduralDistributions.list["SurvivalGear"].items, 10);
table.insert(ProceduralDistributions.list["SurvivalGear"].items, "HazardousZones.HZIodinePillsBottle");
table.insert(ProceduralDistributions.list["SurvivalGear"].items, 2);
table.insert(ProceduralDistributions.list["SurvivalGear"].items, "HazardousZones.HZIndralineSyringe");
table.insert(ProceduralDistributions.list["SurvivalGear"].items, 5);

table.insert(ProceduralDistributions.list["SurvivalGear"].items, "HazardousZones.HZIodidePowder");
table.insert(ProceduralDistributions.list["SurvivalGear"].items, 5);
table.insert(ProceduralDistributions.list["SurvivalGear"].items, "HazardousZones.HZKILiquidMixture");
table.insert(ProceduralDistributions.list["SurvivalGear"].items, 5);

--SurvivalGear/Toxiguard/Bioshield
table.insert(ProceduralDistributions.list["SurvivalGear"].items, "HazardousZones.HZToxiguardPillSingle");
table.insert(ProceduralDistributions.list["SurvivalGear"].items, 10);
table.insert(ProceduralDistributions.list["SurvivalGear"].items, "HazardousZones.HZToxiguardPack");
table.insert(ProceduralDistributions.list["SurvivalGear"].items, 2);
table.insert(ProceduralDistributions.list["SurvivalGear"].items, "HazardousZones.HZBioshieldRxSyringe");
table.insert(ProceduralDistributions.list["SurvivalGear"].items, 5);

--BathroomCabinet/Iodine
table.insert(ProceduralDistributions.list["BathroomCabinet"].items, "HazardousZones.HZIodinePillSingle");
table.insert(ProceduralDistributions.list["BathroomCabinet"].items, 2);
table.insert(ProceduralDistributions.list["BathroomCabinet"].items, "HazardousZones.HZIodinePillsBottle");
table.insert(ProceduralDistributions.list["BathroomCabinet"].items, 0.4);
table.insert(ProceduralDistributions.list["BathroomCabinet"].items, "HazardousZones.HZIndralineSyringe");
table.insert(ProceduralDistributions.list["BathroomCabinet"].items, 1);

--BathroomCabinet/Toxiguard/Bioshield
table.insert(ProceduralDistributions.list["BathroomCabinet"].items, "HazardousZones.HZToxiguardPillSingle");
table.insert(ProceduralDistributions.list["BathroomCabinet"].items, 2);
table.insert(ProceduralDistributions.list["BathroomCabinet"].items, "HazardousZones.HZToxiguardPack");
table.insert(ProceduralDistributions.list["BathroomCabinet"].items, 0.4);
table.insert(ProceduralDistributions.list["BathroomCabinet"].items, "HazardousZones.HZBioshieldRxSyringe");
table.insert(ProceduralDistributions.list["BathroomCabinet"].items, 1);

--BathroomCabinet/BloodTestKit
table.insert(ProceduralDistributions.list["BathroomCabinet"].items, "HazardousZones.HZBloodTestKit");
table.insert(ProceduralDistributions.list["BathroomCabinet"].items, 0.05);
table.insert(ProceduralDistributions.list["BathroomCabinet"].items, "HazardousZones.HZBloodCollectionSyringe");
table.insert(ProceduralDistributions.list["BathroomCabinet"].items, 0.5);
table.insert(ProceduralDistributions.list["BathroomCabinet"].items, "HazardousZones.HZBloodQuickTest");
table.insert(ProceduralDistributions.list["BathroomCabinet"].items, 0.5);

--BathroomCounter/Iodine
table.insert(ProceduralDistributions.list["BathroomCounter"].items, "HazardousZones.HZIodinePillSingle");
table.insert(ProceduralDistributions.list["BathroomCounter"].items, 1);
table.insert(ProceduralDistributions.list["BathroomCounter"].items, "HazardousZones.HZIodinePillsBottle");
table.insert(ProceduralDistributions.list["BathroomCounter"].items, 0.05);
table.insert(ProceduralDistributions.list["BathroomCounter"].items, "HazardousZones.HZIndralineSyringe");
table.insert(ProceduralDistributions.list["BathroomCounter"].items, 0.05);

--BathroomCounter/Toxiguard/Bioshield
table.insert(ProceduralDistributions.list["BathroomCounter"].items, "HazardousZones.HZToxiguardPillSingle");
table.insert(ProceduralDistributions.list["BathroomCounter"].items, 1);
table.insert(ProceduralDistributions.list["BathroomCounter"].items, "HazardousZones.HZToxiguardPack");
table.insert(ProceduralDistributions.list["BathroomCounter"].items, 0.05);
table.insert(ProceduralDistributions.list["BathroomCounter"].items, "HazardousZones.HZBioshieldRxSyringe");
table.insert(ProceduralDistributions.list["BathroomCounter"].items, 0.05);

--BathroomCounter/BloodTestKit
table.insert(ProceduralDistributions.list["BathroomCounter"].items, "HazardousZones.HZBloodTestKit");
table.insert(ProceduralDistributions.list["BathroomCounter"].items, 0.05);
table.insert(ProceduralDistributions.list["BathroomCounter"].items, "HazardousZones.HZBloodCollectionSyringe");
table.insert(ProceduralDistributions.list["BathroomCounter"].items, 0.5);
table.insert(ProceduralDistributions.list["BathroomCounter"].items, "HazardousZones.HZBloodQuickTest");
table.insert(ProceduralDistributions.list["BathroomCounter"].items, 0.5);

--BedroomSideTable/Iodine
table.insert(ProceduralDistributions.list["BedroomSideTable"].items, "HazardousZones.HZIodinePillSingle");
table.insert(ProceduralDistributions.list["BedroomSideTable"].items, 1);
table.insert(ProceduralDistributions.list["BedroomSideTable"].items, "HazardousZones.HZIodinePillsBottle");
table.insert(ProceduralDistributions.list["BedroomSideTable"].items, 0.05);
table.insert(ProceduralDistributions.list["BedroomSideTable"].items, "HazardousZones.HZIndralineSyringe");
table.insert(ProceduralDistributions.list["BedroomSideTable"].items, 0.05);

--BedroomSideTable/Toxiguard/Bioshield
table.insert(ProceduralDistributions.list["BedroomSideTable"].items, "HazardousZones.HZToxiguardPillSingle");
table.insert(ProceduralDistributions.list["BedroomSideTable"].items, 1);
table.insert(ProceduralDistributions.list["BedroomSideTable"].items, "HazardousZones.HZToxiguardPack");
table.insert(ProceduralDistributions.list["BedroomSideTable"].items, 0.05);
table.insert(ProceduralDistributions.list["BedroomSideTable"].items, "HazardousZones.HZBioshieldRxSyringe");
table.insert(ProceduralDistributions.list["BedroomSideTable"].items, 0.05);

--OfficeDrawers/Iodine
table.insert(ProceduralDistributions.list["OfficeDrawers"].items, "HazardousZones.HZIodinePillSingle");
table.insert(ProceduralDistributions.list["OfficeDrawers"].items, 1);
table.insert(ProceduralDistributions.list["OfficeDrawers"].items, "HazardousZones.HZIodinePillsBottle");
table.insert(ProceduralDistributions.list["OfficeDrawers"].items, 0.05);
table.insert(ProceduralDistributions.list["OfficeDrawers"].items, "HazardousZones.HZIndralineSyringe");
table.insert(ProceduralDistributions.list["OfficeDrawers"].items, 0.05);

--OfficeDrawers/Toxiguard/Bioshield
table.insert(ProceduralDistributions.list["OfficeDrawers"].items, "HazardousZones.HZToxiguardPillSingle");
table.insert(ProceduralDistributions.list["OfficeDrawers"].items, 1);
table.insert(ProceduralDistributions.list["OfficeDrawers"].items, "HazardousZones.HZToxiguardPack");
table.insert(ProceduralDistributions.list["OfficeDrawers"].items, 0.05);
table.insert(ProceduralDistributions.list["OfficeDrawers"].items, "HazardousZones.HZBioshieldRxSyringe");
table.insert(ProceduralDistributions.list["OfficeDrawers"].items, 0.05);

--GloveBox/Iodine
table.insert(VehicleDistributions["GloveBox"].items, "HazardousZones.HZIodinePillSingle");
table.insert(VehicleDistributions["GloveBox"].items, 0.5);
table.insert(VehicleDistributions["GloveBox"].items, "HazardousZones.HZIodinePillsBottle");
table.insert(VehicleDistributions["GloveBox"].items, 0.01);
table.insert(VehicleDistributions["GloveBox"].items, "HazardousZones.HZIndralineSyringe");
table.insert(VehicleDistributions["GloveBox"].items, 0.01);

--GloveBox/Toxiguard/Bioshield
table.insert(VehicleDistributions["GloveBox"].items, "HazardousZones.HZToxiguardPillSingle");
table.insert(VehicleDistributions["GloveBox"].items, 0.5);
table.insert(VehicleDistributions["GloveBox"].items, "HazardousZones.HZToxiguardPack");
table.insert(VehicleDistributions["GloveBox"].items, 0.01);
table.insert(VehicleDistributions["GloveBox"].items, "HazardousZones.HZBioshieldRxSyringe");
table.insert(VehicleDistributions["GloveBox"].items, 0.01);

-- Suburbs/Iodine/Male
table.insert(SuburbsDistributions["all"]["inventorymale"].items, "HazardousZones.HZIodinePillSingle");
table.insert(SuburbsDistributions["all"]["inventorymale"].items, 0.5);
table.insert(SuburbsDistributions["all"]["inventorymale"].items, "HazardousZones.HZIodinePillsBottle");
table.insert(SuburbsDistributions["all"]["inventorymale"].items, 0.01);
table.insert(SuburbsDistributions["all"]["inventorymale"].items, "HazardousZones.HZIndralineSyringe");
table.insert(SuburbsDistributions["all"]["inventorymale"].items, 0.01);

-- Suburbs/Iodine/Female
table.insert(SuburbsDistributions["all"]["inventoryfemale"].items, "HazardousZones.HZIodinePillSingle");
table.insert(SuburbsDistributions["all"]["inventoryfemale"].items, 0.5);
table.insert(SuburbsDistributions["all"]["inventoryfemale"].items, "HazardousZones.HZIodinePillsBottle");
table.insert(SuburbsDistributions["all"]["inventoryfemale"].items, 0.01);
table.insert(SuburbsDistributions["all"]["inventoryfemale"].items, "HazardousZones.HZIndralineSyringe");
table.insert(SuburbsDistributions["all"]["inventoryfemale"].items, 0.01);

--Suburbs/Toxiguard/Bioshield/Male
table.insert(SuburbsDistributions["all"]["inventorymale"].items, "HazardousZones.HZToxiguardPillSingle");
table.insert(SuburbsDistributions["all"]["inventorymale"].items, 0.5);
table.insert(SuburbsDistributions["all"]["inventorymale"].items, "HazardousZones.HZToxiguardPack");
table.insert(SuburbsDistributions["all"]["inventorymale"].items, 0.01);
table.insert(SuburbsDistributions["all"]["inventorymale"].items, "HazardousZones.HZBioshieldRxSyringe");
table.insert(SuburbsDistributions["all"]["inventorymale"].items, 0.01);

--Suburbs/Toxiguard/Bioshield/Female
table.insert(SuburbsDistributions["all"]["inventoryfemale"].items, "HazardousZones.HZToxiguardPillSingle");
table.insert(SuburbsDistributions["all"]["inventoryfemale"].items, 0.5);
table.insert(SuburbsDistributions["all"]["inventoryfemale"].items, "HazardousZones.HZToxiguardPack");
table.insert(SuburbsDistributions["all"]["inventoryfemale"].items, 0.01);
table.insert(SuburbsDistributions["all"]["inventoryfemale"].items, "HazardousZones.HZBioshieldRxSyringe");
table.insert(SuburbsDistributions["all"]["inventoryfemale"].items, 0.01);

-- Suburbs/BloodTestKit/Male
table.insert(SuburbsDistributions["all"]["inventorymale"].items, "HazardousZones.HZBloodCollectionSyringe");
table.insert(SuburbsDistributions["all"]["inventorymale"].items, 0.01);
table.insert(SuburbsDistributions["all"]["inventorymale"].items, "HazardousZones.HZBloodQuickTest");
table.insert(SuburbsDistributions["all"]["inventorymale"].items, 0.01);
table.insert(SuburbsDistributions["all"]["inventorymale"].items, "HazardousZones.HZBloodTestKitUserManual");
table.insert(SuburbsDistributions["all"]["inventorymale"].items, 0.01);

-- Suburbs/BloodTestKit/Female
table.insert(SuburbsDistributions["all"]["inventoryfemale"].items, "HazardousZones.HZBloodCollectionSyringe");
table.insert(SuburbsDistributions["all"]["inventoryfemale"].items, 0.01);
table.insert(SuburbsDistributions["all"]["inventoryfemale"].items, "HazardousZones.HZBloodQuickTest");
table.insert(SuburbsDistributions["all"]["inventoryfemale"].items, 0.01);
table.insert(SuburbsDistributions["all"]["inventoryfemale"].items, "HazardousZones.HZBloodTestKitUserManual");
table.insert(SuburbsDistributions["all"]["inventoryfemale"].items, 0.01);