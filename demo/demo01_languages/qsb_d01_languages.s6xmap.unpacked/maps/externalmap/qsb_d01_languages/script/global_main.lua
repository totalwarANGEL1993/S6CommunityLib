-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||| --
-- ||||                          GLOBALES SKRIPT                         |||| --
-- ||||                    --------------------------                    |||| --
-- ||||                              Demo 01                             |||| --
-- ||||                           totalwarANGEL                          |||| --
-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||| --

-- ========================================================================== --

function GameCallback_Lib_LoadingFinished()
    ActivateDebugMode(true, true, true, true, false);

    InteractiveObjectDeactivate("TP2");
    Logic.SetResourceDoodadGoodAmount(GetID("P3_Mine1"), 2500);
    SetupTradeOffers();

    CreateLanguageSelectedListener();
    ActivateColoredScreen(1, 0, 0, 0, 255);
    DeactivateNormalInterface(1);

    -- Diese Sprachen müssen neu definiert werden
    DefineLanguage("cs", "Čeština", "en");
    DefineLanguage("pl", "Polski", "en");
    DefineLanguage("es", "Español", "en");
    -- Sprachwahl anzeigen
    DialogLanguageSelection(1);
end

function SetupTradeOffers()
    -- Player 2
    local P2TP = GetID("TP2");
    Logic.TradePost_SetTradePartnerGenerateGoodsFlag(P2TP, true);
    Logic.TradePost_SetTradePartnerPlayerID(P2TP, 2);
    Logic.TradePost_SetTradeDefinition(P2TP, 0, Goods.G_Carcass, 18, Goods.G_Herb, 18);
    Logic.TradePost_SetTradeDefinition(P2TP, 1, Goods.G_Grain, 18, Goods.G_Herb, 18);
    Logic.TradePost_SetTradeDefinition(P2TP, 2, Goods.G_Wood, 18, Goods.G_Herb, 18);
    Logic.TradePost_SetTradeDefinition(P2TP, 3, Goods.G_RawFish, 18, Goods.G_Herb, 18);

    -- Player 3
    local P2SH = GetID("SH3");
    AddMercenaryOffer(P2SH, 2, Entities.U_MilitaryBandit_Melee_ME, 5*60);
    AddMercenaryOffer(P2SH, 2, Entities.U_MilitaryBandit_Ranged_ME, 5*60);
end

function CreateLanguageSelectedListener()
    CreateReportReceiver(Report.LanguageSelectionClosed, function(_PlayerID, _IsGuiPlayer, _Selected)
        LoadStringTextFromFile(GlobalPath.. "text/translation_" .._Selected.. ".lua");
        DeactivateColoredScreen(1);
        ActivateNormalInterface(1);
        SetupPlayerNames();
        StartQuests();
    end);
end

function SetupPlayerNames()
    local Hero = Helper_GetKnight();
    -- Umgang mit Platzhaltern an einem Beispiel:
    ExecuteLocal([[FlavorHero = GetStringText("Translation/Flavor_%s")]], Hero);

    -- Lokal, da keys nur lokal verwendet werden können!
    ExecuteLocal([[SetPlayerName(1, GetStringText("Translation/Names_Player1_%s"))]], Hero);
    ExecuteLocal([[SetPlayerName(2, GetStringText("Translation/Names_Player2"))]]);
    ExecuteLocal([[SetPlayerName(3, GetStringText("Translation/Names_Player3"))]]);
    ExecuteLocal([[SetPlayerName(7, GetStringText("Translation/Names_Player7"))]]);
end

function Helper_GetKnight()
    local KnightType = Logic.GetEntityType(Logic.GetKnightID(1));
    local Hero = "Saraya";
    if KnightType == Entities.U_KnightChivalry then
        Hero = "Marcus";
    elseif KnightType == Entities.U_KnightWisdom then
        Hero = "Hakim";
    elseif KnightType == Entities.U_KnightTrading then
        Hero = "Elias";
    end
    return Hero;
end

