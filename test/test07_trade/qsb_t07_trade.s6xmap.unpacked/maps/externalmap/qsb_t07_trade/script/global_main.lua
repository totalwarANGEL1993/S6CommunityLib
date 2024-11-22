-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||| --
-- ||||                          GLOBALES SKRIPT                         |||| --
-- ||||                    --------------------------                    |||| --
-- ||||                            Testmap 07                            |||| --
-- ||||                           totalwarANGEL                          |||| --
-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||| --

-- ========================================================================== --

function GameCallback_Lib_LoadingFinished()
    ActivateDebugMode(true, true, true, true, false);
    SetPlayerPortrait(1);
    SetDiplomacyState(1, 2, 1);
end

-- ========================================================================== --

function CreatePlayer2Offers()
    local SHID = Logic.GetStoreHouse(2);
    AddOffer(SHID, 3, Goods.G_Wood, 3*60);
    AddOffer(SHID, 1, Goods.G_Bread, 3*60);
    AddMercenaryOffer(SHID, 2, Entities.U_MilitaryBandit_Melee_ME, 3*60);
    AddEntertainerOffer(SHID, Entities.U_Entertainer_NA_FireEater);
end

