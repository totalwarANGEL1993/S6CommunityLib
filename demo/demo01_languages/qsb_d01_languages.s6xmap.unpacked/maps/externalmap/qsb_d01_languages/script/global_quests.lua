-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||| --
-- ||||                           GLOBAL QUESTS                          |||| --
-- ||||                    --------------------------                    |||| --
-- ||||                              Demo 01                             |||| --
-- ||||                           totalwarANGEL                          |||| --
-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||| --

-- ========================================================================== --

function StartQuests()
    StartMainQuest();
    StartCloisterQuests();
    StartVillageQuests();
end

-- ========================================================================== --

function StartMainQuest()
    SetupQuest {
        Name        = "Quest_Intro",
        Suggestion  = "Translation/Quest_Intro_1_Suggestion",
        Success     = "Translation/Quest_Intro_1_Success",

        Goal_InstantSuccess(),
        Reward_ObjectInit("IronRuin", 1000, 0, "G_Iron", 18, "-", 0, "-", 0, "Knight only"),
        Reward_Diplomacy(1, 7, "Enemy"),
        Reward_Resources("G_Gold", 250),
        Reward_Resources("G_Wood", 20),
        Reward_Resources("G_Stone", 20),
        Reward_Resources("G_Carcass", 10),
        Reward_Resources("G_Grain", 10),
        Reward_Resources("G_Milk", 10),
        Reward_Resources("G_RawFish", 10),
        Trigger_Time(0),
    }

    SetupQuest {
        Name        = "Quest_DestroyPlayer7",
        Suggestion  = "Translation/Quest_DestroyPlayer7_1_Suggestion",
        Success     = "Translation/Quest_DestroyPlayer7_1_Success",
        Description = "Translation/Quest_DestroyPlayer7_1_Description",

        Goal_UnitsOnTerritory("Black Wood Hollow", 7, "BanditsCamp", "<", 1),
        Reward_FakeVictory(),
        Trigger_OnQuestSuccess("Quest_Intro", 10),
    }

    SetupQuest {
        Name        = "Quest_Victory",

        Goal_InstantSuccess(),
        Reward_VictoryWithParty(),
        Trigger_OnQuestSuccess("Quest_DestroyPlayer7", 10),
    }
end

-- ========================================================================== --

function StartCloisterQuests()
    SetupQuest {
        Name        = "Quest_DiscoverPlayer2",
        Suggestion  = "Translation/Quest_DiscoverPlayer2_1_Suggestion",
        Success     = "Translation/Quest_DiscoverPlayer2_1_Success",

        Goal_DiscoverPlayer(2),
        Reward_Diplomacy(1, 2, "EstablishedContact"),
        Trigger_OnQuestActive("Quest_DestroyPlayer7", 10),
    }

    SetupQuest {
        Name        = "Quest_Player2SendSupport",
        Sender      = 2,
        Suggestion  = "Translation/Quest_Player2SendSupport_1_Suggestion",
        Success     = "Translation/Quest_Player2SendSupport_1_Success",
        Description = "Translation/Quest_Player2SendSupport_1_Description",

        Goal_UnitsOnTerritory("East Forrest Chapel", 1, "Leader", ">=", 2),
        Reward_ObjectActivate("TP2"),
        Reward_Diplomacy(1, 2, "TradeContact"),
        Reward_MapScriptFunction("Quest_RewardTransferUnits"),
        Trigger_OnQuestSuccess("Quest_DiscoverPlayer2", 10),
    }

    SetupQuest {
        Name        = "Quest_Player2BuildTP",
        Suggestion  = "Translation/Quest_Player2BuildTP_1_Suggestion",
        Success     = "Translation/Quest_Player2BuildTP_1_Success",

        Goal_Create("B_TradePost", 1, "East Forrest Chapel"),
        Trigger_OnQuestSuccess("Quest_Player2SendSupport", 10),
    }
end

function Quest_RewardTransferUnits()
    local Index = 0;
    for _,ID in pairs(SearchEntitiesOfCategoryInTerritory(6, EntityCategories.Leader, 1)) do
        Logic.ChangeSettlerPlayerID(ID, 2);
        Index = Index + 1;
        if Index >= 2 then
            break;
        end
    end
end

-- ========================================================================== --

function StartVillageQuests()
    SetupQuest {
        Name        = "Quest_DiscoverPlayer3",
        Suggestion  = "Translation/Quest_DiscoverPlayer3_1_Suggestion",
        Success     = "Translation/Quest_DiscoverPlayer3_1_Success",

        Goal_DiscoverPlayer(3),
        Reward_Diplomacy(1, 3, "EstablishedContact"),
        Trigger_OnQuestActive("Quest_DestroyPlayer7", 10),
    }

    SetupQuest {
        Name        = "Quest_Player3SendStone",
        Sender      = 3,
        Suggestion  = "Translation/Quest_Player3SendStone_1_Suggestion",
        Success     = "Translation/Quest_Player3SendStone_1_Success",
        Description = "Translation/Quest_Player3SendStone_1_Description",

        Goal_Deliver("G_Stone", 30),
        Reward_AI_SetNumericalFact(3, "BPMX", 2),
        Trigger_OnQuestSuccess("Quest_DiscoverPlayer3", 10),
    }

    SetupQuest {
        Name        = "Quest_Player3Close",
        Sender      = 3,
        Success     = "Translation/Quest_Player3Close_1_Success",

        Goal_InstantSuccess(),
        Reward_Diplomacy(1, 3, "TradeContact"),
        Trigger_OnQuestSuccess("Quest_Player3SendStone", 10),
    }
end

