-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||| --
-- ||||                          GLOBALES SKRIPT                         |||| --
-- ||||                    --------------------------                    |||| --
-- ||||                            Testmap 07                            |||| --
-- ||||                           totalwarANGEL                          |||| --
-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||| --

-- ========================================================================== --

GlobalPath = "maps/externalmap/" ..Framework.GetCurrentMapName() .."/";
LibPath = "maps/externalmap/" ..Framework.GetCurrentMapName() .."/";

CONST_IS_IN_DEV = true;
if CONST_IS_IN_DEV then
    GlobalPath = "D:/Projects/Settlers/libertica/test/test07_trade/qsb_t07_trade.s6xmap.unpacked/" ..GlobalPath;
    LibPath = "D:/Projects/Settlers/libertica/release/";
end
Script.Load(LibPath.. "libertica/librarian.lua");
Script.Load(GlobalPath.. "/script/imports.lua");
Script.Load(GlobalPath.. "script/global_main.lua");

-- ========================================================================== --

function Mission_FirstMapAction()

    -- Mapeditor-Einstellungen werden geladen
    if Framework.IsNetworkGame() ~= true then
        Startup_Player();
        Startup_StartGoods();
        Startup_Diplomacy();
    end
    PrepareLibrary();
end

function Mission_InitPlayers()
end

function Mission_SetStartingMonth()
    Logic.SetMonthOffset(3);
end

function Mission_InitMerchants()
end

