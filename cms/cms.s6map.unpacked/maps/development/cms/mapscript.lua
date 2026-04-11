-- Default modules if user didn't include any
Lib.Require("core/Core");
Lib.Require("module/mode/SettlementMultiplayer");

-- ========================================================================== --

function Mission_FirstMapAction()
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
end

function Mission_InitMerchants()
end

