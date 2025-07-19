Lib.Register("module/ui/UITools_Speed");

Lib.UITools = Lib.UITools or {};
Lib.UITools.Speed = {
    SpeedLimit = 1,
};

function Lib.UITools.Speed:SetSpeedLimit(_Limit)
    if Framework.IsNetworkGame() then
        log("Lib.UITools.Speed: Detect network game. Aborting!");
        return;
    end
    _Limit = (_Limit < 1 and 1) or math.floor(_Limit);
    log("Lib.UITools.Speed: Setting speed limit to " .._Limit);
    self.SpeedLimit = _Limit;
end

function Lib.UITools.Speed:ActivateSpeedLimit(_Flag)
    if Framework.IsNetworkGame() then
        log("Lib.UITools.Speed: Detect network game. Aborting!");
        return;
    end
    self.UseSpeedLimit = _Flag == true;
    if _Flag and Game.GameTimeGetFactor(GUI.GetPlayerID()) > self.SpeedLimit then
        log("Lib.UITools.Speed: Speed is capped at " ..self.SpeedLimit);
        Game.GameTimeSetFactor(GUI.GetPlayerID(), self.SpeedLimit);
        g_GameSpeed = 1;
    end
end

function Lib.UITools.Speed:InitForbidSpeedUp()
    self.Orig_GameCallback_GameSpeedChanged = GameCallback_GameSpeedChanged;
    GameCallback_GameSpeedChanged = function(_Speed)
        Lib.UITools.Speed.Orig_GameCallback_GameSpeedChanged(_Speed);
        if Lib.UITools.Speed.UseSpeedLimit == true then
            log("Lib.UITools.Speed: Checking speed limit.");
            if _Speed > Lib.UITools.Speed.SpeedLimit then
                log("Lib.UITools.Speed: Speed is capped at " ..tostring(_Speed).. ".");
                Game.GameTimeSetFactor(GUI.GetPlayerID(), Lib.UITools.Speed.SpeedLimit);
                g_GameSpeed = 1;
                Message("Lib_Strings/UI_UITools_Message_NoSpeedUp");
            end
        end
    end
end

