-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||| --
-- ||||                          GLOBALES SKRIPT                         |||| --
-- ||||                    --------------------------                    |||| --
-- ||||                              Demo 01                             |||| --
-- ||||                           totalwarANGEL                          |||| --
-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||| --

-- ========================================================================== --

GlobalPath = "maps/externalmap/" ..Framework.GetCurrentMapName() .."/";
LibPath = "maps/externalmap/" ..Framework.GetCurrentMapName() .."/";

CONST_IS_IN_DEV = false;
if CONST_IS_IN_DEV then
    GlobalPath = "E:/Repositories/S6CommunityLib/demo/demo01_languages/qsb_d01_languages.s6xmap.unpacked/" ..GlobalPath;
    LibPath = "E:/Repositories/";
end
Script.Load(LibPath.. "S6CommunityLib/lua/loader.lua");
Script.Load(GlobalPath.. "script/imports.lua");
Script.Load(GlobalPath.. "script/global_main.lua");
Script.Load(GlobalPath.. "script/global_quests.lua");

-- ========================================================================== --

function Mission_FirstMapAction()
    -- Mapeditor-Einstellungen werden geladen
    if Framework.IsNetworkGame() ~= true then
        Startup_Player();
        Startup_StartGoods();
        Startup_Diplomacy();
    end
    PrepareLibrary();
    AICore.SetNumericalFact(3, "BPMX", 1);
end

function Mission_InitPlayers()
end

function Mission_SetStartingMonth()
    Logic.SetMonthOffset(3);
end

function Mission_InitMerchants()
end