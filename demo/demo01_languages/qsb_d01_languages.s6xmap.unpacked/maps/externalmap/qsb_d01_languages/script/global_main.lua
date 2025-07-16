-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||| --
-- ||||                          GLOBALES SKRIPT                         |||| --
-- ||||                    --------------------------                    |||| --
-- ||||                            Testmap 23                            |||| --
-- ||||                           totalwarANGEL                          |||| --
-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||| --

-- ========================================================================== --

function GameCallback_Lib_LoadingFinished()
    ActivateDebugMode(true, true, true, true, false);
end

function DiscoverTerritoriesQuest()
    SetupQuest {
        Name        = "DiscoverTerritories1",
        Suggestion  = "Find your neighbors!",
        Receiver    = 1,

        Goal_DiscoverTerritories(4, 2, 3, 4, 5),
        Trigger_Time(0),
    }
end

function DiscoverPlayersQuest()
    SetupQuest {
        Name        = "DiscoverPlayers1",
        Suggestion  = "Find your neighbors!",
        Receiver    = 1,

        Goal_DiscoverPlayers(4, 2, 3, 4, 5),
        Trigger_Time(0),
    }
end

