-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||| --
-- ||||                          GLOBALES SKRIPT                         |||| --
-- ||||                    --------------------------                    |||| --
-- ||||                            Testmap 21                            |||| --
-- ||||                           totalwarANGEL                          |||| --
-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||| --

-- ========================================================================== --

function TestWarehouses()
    CreateWarehouse {
        ScriptName = "TP1",
        Costs      = {Goods.G_Gold, 150, Goods.G_Wood, 8},
        Offers     = {
            {Amount      = 2,
             GoodType    = Goods.G_Milk,
             GoodAmount  = 12,
             PaymentType = Goods.G_Grain,
             BasePrice   = 12,},
            {Amount      = 2,
             GoodType    = Goods.G_Cheese,
             GoodAmount  = 6,
             PaymentType = Goods.G_Gold,
             BasePrice   = 120,},
            {Amount      = 2,
             GoodType    = Entities.A_X_Cow01,
             PaymentType = Goods.G_Gold,
             BasePrice   = 300,},
            {Amount      = 1,
             GoodType    = Entities.U_CatapultCart,
             PaymentType = Goods.G_Gold,
             BasePrice   = 1000,},
            {Amount      = 2,
             GoodType    = Entities.U_MilitaryBandit_Melee_ME,
             PaymentType = Goods.G_Gold,
             BasePrice   = 90,},
        },
    }
end

-- ========================================================================== --

function TestTextDivision()
    Lib.Core.Text:GetAmountOfLines([[Dieser Modus schränkt die Baumöglichkeiten ein, sodass der Bau der Stadt bessere Planung erfordert.{cr}{cr}{cr}1. Das Heimatgebiet hat keine Einschränkungen.{cr}{cr}2. In anderen Territorien können nur 3 Gebäude gebaut werden. Jeder Gebäudetyp kann nur einmal auf dem Gebiet gebaut werden.{cr}{cr}3. Der Ausbau des Außenposten gewährt dauerhaft ein zusätzliches Gebäude. Außerdem können für Gold Gebäudetypen doppelt gebaut werden.{cr}{cr}4. Stadtgebäude können nur auf dem Heimatgebiet gebaut werden.{cr}{cr}5. Bienenstöcke, Felder und Ziergebäude zählen nicht als Gebäude.]],170)
end

-- ========================================================================== --

-- > TestQuestForCommands()
function TestQuestForCommands()
    SetupQuest {
        Name        = "TestQuest1",
        Suggestion  = "It just work's!",
        Receiver    = 1,

        Goal_NoChange(),
        Trigger_NeverTriggered(),
    }
end

-- ========================================================================== --

function TestConstructBuildingBlackList()
    BlackListHerbGatherer = BlacklistConstructTypeInTerritory(1, Entities.B_HerbGatherer, 1);
end

function TestConstructBuildingWhiteList()
    WhiteListCityBuilding = WhitelistConstructCategoryInTerritory(1, EntityCategories.CityBuilding, 1);
end

function TestKnockdownBuildingBlackList()
    BlackListBaker = BlacklistKnockdownTypeInTerritory(1, Entities.B_Baker, 1);
end

function TestKnockdownBuildingWhiteList()
    WhiteListButcher = WhitelistKnockdownTypeInTerritory(1, Entities.B_Butcher, 1);
end

function TestConstructRoadBlackList()
    BlacklstRoad = BlacklistConstructRoadInTerritory(1, true, 1);
end

function TestConstructRoadWhiteList()

end

function TestConstructWallBlackList()

end

function TestConstructWallWhiteList()
    PalisadesInHomeTerritory = WhitelistConstructWallInTerritory(1, false, 1);
    WallsInHomeTerritory = WhitelistConstructWallInTerritory(1, true, 1);
end

function TestCustomConstructPalisade()
    CustomRuleConstructWall(1, "BuildRule_Palisade", 1, Entities.B_Outpost_ME);
    CustomRuleConstructBuilding(1, "BuildRule_PalisadeGate", 1, Entities.B_Outpost_ME);
end

function TestCustomConstructWall()
    CustomRuleConstructWall(1, "BuildRule_Wall", 1);
    CustomRuleConstructBuilding(1, "BuildRule_WallGate", 1);
end

BuildRule_PalisadeGate = function(_PlayerID, _Type, _x, _y, _HomeTerritoryID, _OutpostType)
    local TerritoryID = Logic.GetTerritoryAtPosition(_x, _y);
    local n, OutpostID = Logic.GetPlayerEntitiesInArea(_PlayerID, _OutpostType, _x, _y, 1500, 1);
    if  Logic.IsEntityTypeInCategory(_Type, EntityCategories.Wall) == 1
    and TerritoryID ~= _HomeTerritoryID then
        return n > 0 and Logic.IsConstructionComplete(OutpostID) == 1;
    end
    return true;
end

BuildRule_WallGate = function(_PlayerID, _Type, _x, _y, _HomeTerritoryID)
    local TerritoryID = Logic.GetTerritoryAtPosition(_x, _y);
    if Logic.IsEntityTypeInCategory(_Type, EntityCategories.Wall) == 1 then
        return TerritoryID == _HomeTerritoryID;
    end
    return true;
end

-- ========================================================================== --

function ModeSelection_Done()
    RequireTitleToRefilCisterns(KnightTitles.Mayor);
    RequireTitleToRefilStoneMines(KnightTitles.Earl);
    RequireTitleToRefilIronMines(KnightTitles.Earl);
    RequireTitleToBreedCattle(KnightTitles.Marquees);
    RequireTitleToBreedSheep(KnightTitles.Marquees);

    ModeSelection_DifficultyEasy();
    ModeSelection_DifficultyNormal();
    ModeSelection_DifficultyHard();
    ModeSelection_DifficultyMercyless();
end

function ModeSelection_DifficultyEasy()
    ActivateSettlementLimitation(false);
    UseForceBallistaDistance(false);
    UseWallUpkeepCosts(false);
    UseWallDeteriation(false);
    ActivateOutpostLimit(false);

    SettlementSurvivalActivate(false);
    BanditsBlockClaimActivate(false);
    PredatorBlockClaimActivate(false);
    ClothesForOuterRimActivate(false);
    BaseConsumptionActivate(false);
    AnimalPlagueActivate(false);
    HotWeatherActivate(false);
    ColdWeatherActivate(false);
    FamineActivate(false);
    NegligenceActivate(false);
    PlagueActivate(false);
end

function ModeSelection_DifficultyNormal()
    ActivateSettlementLimitation(true);
    UseWallUpkeepCosts(true);
    UseWallDeteriation(true);

    SettlementSurvivalActivate(true);
    AnimalPlagueActivate(true);
    HotWeatherActivate(true);
    HotWeatherSetTemperature(30);
    ColdWeatherActivate(true);
    ColdWeatherSetTemperature(14);
end

function ModeSelection_DifficultyHard()
    -- Grain Farm Whitelist
    AddToBuildingTerritoryWhitelist(Entities.B_GrainFarm, 3);
    AddToBuildingTerritoryWhitelist(Entities.B_GrainField_SE, 3);
    AddToBuildingTerritoryWhitelist(Entities.B_GrainFarm, 7);
    AddToBuildingTerritoryWhitelist(Entities.B_GrainField_SE, 7);
    AddToBuildingTerritoryWhitelist(Entities.B_GrainFarm, 9);
    AddToBuildingTerritoryWhitelist(Entities.B_GrainField_SE, 9);
    AddToBuildingTerritoryWhitelist(Entities.B_GrainFarm, 14);
    AddToBuildingTerritoryWhitelist(Entities.B_GrainField_SE, 14);
    AddToBuildingTerritoryWhitelist(Entities.B_GrainFarm, 19);
    AddToBuildingTerritoryWhitelist(Entities.B_GrainField_SE, 19);
    AddToBuildingTerritoryWhitelist(Entities.B_GrainFarm, 23);
    AddToBuildingTerritoryWhitelist(Entities.B_GrainField_SE, 23);
    AddToBuildingTerritoryWhitelist(Entities.B_GrainFarm, 33);
    AddToBuildingTerritoryWhitelist(Entities.B_GrainField_SE, 33);
    AddToBuildingTerritoryWhitelist(Entities.B_GrainFarm, 35);
    AddToBuildingTerritoryWhitelist(Entities.B_GrainField_SE, 35);
    AddToBuildingTerritoryWhitelist(Entities.B_GrainFarm, 37);
    AddToBuildingTerritoryWhitelist(Entities.B_GrainField_SE, 37);
    -- Cattle Farm Whitelist
    AddToBuildingTerritoryWhitelist(Entities.B_CattleFarm, 6);
    AddToBuildingTerritoryWhitelist(Entities.B_CattlePasture, 6);
    AddToBuildingTerritoryWhitelist(Entities.B_CattleFarm, 22);
    AddToBuildingTerritoryWhitelist(Entities.B_CattlePasture, 22);
    AddToBuildingTerritoryWhitelist(Entities.B_CattleFarm, 24);
    AddToBuildingTerritoryWhitelist(Entities.B_CattlePasture, 24);
    AddToBuildingTerritoryWhitelist(Entities.B_CattleFarm, 27);
    AddToBuildingTerritoryWhitelist(Entities.B_CattlePasture, 27);
    AddToBuildingTerritoryWhitelist(Entities.B_CattleFarm, 39);
    AddToBuildingTerritoryWhitelist(Entities.B_CattlePasture, 39);
    AddToBuildingTerritoryWhitelist(Entities.B_CattleFarm, 40);
    AddToBuildingTerritoryWhitelist(Entities.B_CattlePasture, 40);
    -- Sheep Farm Whitelist
    AddToBuildingTerritoryWhitelist(Entities.B_SheepFarm, 6);
    AddToBuildingTerritoryWhitelist(Entities.B_SheepPasture, 6);
    AddToBuildingTerritoryWhitelist(Entities.B_SheepFarm, 22);
    AddToBuildingTerritoryWhitelist(Entities.B_SheepPasture, 22);
    AddToBuildingTerritoryWhitelist(Entities.B_SheepFarm, 24);
    AddToBuildingTerritoryWhitelist(Entities.B_SheepPasture, 24);
    AddToBuildingTerritoryWhitelist(Entities.B_SheepFarm, 27);
    AddToBuildingTerritoryWhitelist(Entities.B_SheepPasture, 27);
    AddToBuildingTerritoryWhitelist(Entities.B_SheepFarm, 39);
    AddToBuildingTerritoryWhitelist(Entities.B_SheepPasture, 39);
    AddToBuildingTerritoryWhitelist(Entities.B_SheepFarm, 40);
    AddToBuildingTerritoryWhitelist(Entities.B_SheepPasture, 40);
    -- Beekeeper Whitelist
    AddToBuildingTerritoryWhitelist(Entities.B_Beekeeper, 8);
    AddToBuildingTerritoryWhitelist(Entities.B_Beehive, 8);
    AddToBuildingTerritoryWhitelist(Entities.B_Beekeeper, 11);
    AddToBuildingTerritoryWhitelist(Entities.B_Beehive, 11);
    AddToBuildingTerritoryWhitelist(Entities.B_Beekeeper, 12);
    AddToBuildingTerritoryWhitelist(Entities.B_Beehive, 12);
    AddToBuildingTerritoryWhitelist(Entities.B_Beekeeper, 17);
    AddToBuildingTerritoryWhitelist(Entities.B_Beehive, 17);
    AddToBuildingTerritoryWhitelist(Entities.B_Beekeeper, 18);
    AddToBuildingTerritoryWhitelist(Entities.B_Beehive, 18);
    AddToBuildingTerritoryWhitelist(Entities.B_Beekeeper, 21);
    AddToBuildingTerritoryWhitelist(Entities.B_Beehive, 21);
    AddToBuildingTerritoryWhitelist(Entities.B_Beekeeper, 23);
    AddToBuildingTerritoryWhitelist(Entities.B_Beehive, 23);
    AddToBuildingTerritoryWhitelist(Entities.B_Beekeeper, 25);
    AddToBuildingTerritoryWhitelist(Entities.B_Beehive, 25);
    AddToBuildingTerritoryWhitelist(Entities.B_Beekeeper, 33);
    AddToBuildingTerritoryWhitelist(Entities.B_Beehive, 33);
    AddToBuildingTerritoryWhitelist(Entities.B_Beekeeper, 35);
    AddToBuildingTerritoryWhitelist(Entities.B_Beehive, 35);
    AddToBuildingTerritoryWhitelist(Entities.B_Beekeeper, 39);
    AddToBuildingTerritoryWhitelist(Entities.B_Beehive, 39);
    AddToBuildingTerritoryWhitelist(Entities.B_Beekeeper, 40);
    AddToBuildingTerritoryWhitelist(Entities.B_Beehive, 40);
    AddToBuildingTerritoryWhitelist(Entities.B_Beekeeper, 42);
    AddToBuildingTerritoryWhitelist(Entities.B_Beehive, 42);
    -- Herb Gatherer
    AddToBuildingTerritoryWhitelist(Entities.B_HerbGatherer, 28);
    AddToBuildingTerritoryWhitelist(Entities.B_HerbGatherer, 42);

    PlagueActivate(true);
    FamineActivate(true);
    BaseConsumptionActivate(true);
end

function ModeSelection_DifficultyMercyless()
    UseForceBallistaDistance(true);
    ActivateOutpostLimit(true);

    ClothesForOuterRimActivate(true);
    NegligenceActivate(true);
    BanditsBlockClaimActivate(true);
    PredatorBlockClaimActivate(true);
end

-- ========================================================================== --

function GameCallback_Lib_LoadingFinished()
    ActivateDebugMode(true, true, true, true, false);

    AddGood(Goods.G_Gold, 2500, 1);
    AddGood(Goods.G_Wood, 20, 1);
    AddGood(Goods.G_Stone, 25, 1);
    AddGood(Goods.G_Grain, 10, 1);
    AddGood(Goods.G_RawFish, 10, 1);
    AddGood(Goods.G_Milk, 10, 1);
    AddGood(Goods.G_Carcass, 10, 1);

    TestReport = CreateReport("Test");
end

