-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||| --
-- ||||                          GLOBALES SKRIPT                         |||| --
-- ||||                    --------------------------                    |||| --
-- ||||                            Testmap 11                            |||| --
-- ||||                           totalwarANGEL                          |||| --
-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||| --

-- ========================================================================== --

function ActivateHarborPlayer2()
    InitHarbor(2);
end

function DeactivateHarborPlayer2()
    DisposeHarbor(2);
end

function AddTradeRoute1Player2()
    AddTradeRoute(2, {
        Name = "Route1_P2",
        Path = {"Spawn1", "Arrived1"},
        Interval = 10*60,
        Duration = 2*60,
        Amount = 1,
        Offers = {
            {"G_Wool", 5},
            {"U_CatapultCart", 1},
            {"G_Beer", 2},
            {"G_Herb", 5},
            {"U_Entertainer_NA_StiltWalker", 1},
        }
    });
end

function AddTradeRoute2Player2()
    AddTradeRoute(2, {
        Name = "Route2_P2",
        Path = {"Spawn2", "Arrived2"},
        Interval = 4*60,
        Duration = 2*60,
        Amount = 2,
        Offers = {
            {"G_Iron", 5},
            {"U_MilitaryBow", 3},
            {"G_Salt", 2},
            {"G_RawFish", 5},
            {"U_MilitarySword", 1},
        }
    });
end

function AddTradeRoute3Player2()
    AddTradeRoute(2, {
        Name = "Route3_P2",
        Path = {"Spawn3", "Arrived3"},
        Interval = 6*60,
        Duration = 2*60,
        Amount = 1,
        Offers = {
            {"G_Stone", 5},
            {"U_BatteringRamCart", 1},
            {"G_Dye", 2},
            {"G_Milk", 5},
            {"U_AmmunitionCart", 2},
        }
    });
end

function AddTradeRoute4Player2()
    AddTradeRoute(2, {
        Name = "Route4_P2",
        Path = {"Spawn4", "Arrived4"},
        Interval = 12*60,
        Duration = 2*60,
        Amount = 3,
        Offers = {
            {"G_Grain", 5},
            {"U_SiegeTowerCart", 3},
            {"G_Clothes", 2},
            {"G_Medicine", 1},
            {"U_Entertainer_NE_StrongestMan_Stone", 1},
        }
    });
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

    SetDiplomacyState(1, 2, 1);
end

