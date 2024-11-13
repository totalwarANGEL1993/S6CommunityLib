Lib.QuickTravel = Lib.QuickTravel or {};
Lib.QuickTravel.Name = "QuickTravel";
Lib.QuickTravel.Global = {
    QuickTravelHub = {
        Index = 0,
    },
};
Lib.QuickTravel.Local  = {
    QuickTravelHub = {
        Index = 0,
    },
};
Lib.QuickTravel.Shared  = {};

CONST_QUICKTRAVEL_HUB = {};

Lib.Require("core/Core");
Lib.Require("module/information/Requester");
Lib.Require("module/ui/UIEffects");
Lib.Require("module/diplomacy/QuickTravel_API");
Lib.Require("module/diplomacy/QuickTravel_Text");
Lib.Register("module/diplomacy/QuickTravel");

CinematicEventTypes.FastTravel = 6;

-- -------------------------------------------------------------------------- --
-- Global

-- Global initalizer method
function Lib.QuickTravel.Global:Initialize()
    if not self.IsInstalled then
        Report.QuickTravelInteract = CreateReport("Event_QuickTravelInteract");
        Report.QuickTravelSelected = CreateReport("Event_QuickTravelSelected");

        -- Garbage collection
        Lib.QuickTravel.Local = nil;
    end
    self.IsInstalled = true;
end

-- Global load game
function Lib.QuickTravel.Global:OnSaveGameLoaded()
end

-- Global report listener
function Lib.QuickTravel.Global:OnReportReceived(_ID, ...)
    if _ID == Report.LoadingFinished then
        self.LoadscreenClosed = true;
    elseif _ID == Report.QuickTravelInteract then

    elseif _ID == Report.QuickTravelSelected then
        FinishCinematicEvent("QuickTravel", arg[2]);
        self:OnQuickTravelHubExecution(arg[1], arg[2], arg[3]);
    end
end

function Lib.QuickTravel.Global:CreateQuickTravelHub(_Data)
    self.QuickTravelHub.Index = self.QuickTravelHub.Index + 1;
    local ID = self.QuickTravelHub.Index;

    local Position = GetPosition(_Data.ScriptName);
    local EntityID = Logic.CreateEntity(Entities.U_NPC_SpouseFat, Position.X, Position.Y, 0, _Data.PlayerID or 8);
    Logic.SetVisible(EntityID, false);
    Logic.SetEntityName(EntityID, _Data.ScriptName);

    self.QuickTravelHub[ID] = {
        ScriptName  = _Data.ScriptName,
        PlayerID    = _Data.PlayerID or 8,
        DisplayName = _Data.DisplayName,
        Active      = false,
        Connections = {},
    };
    ExecuteLocal(
        [[Lib.QuickTravel.Local:CreateQuickTravelHub(%s)]],
        table.tostring(self.QuickTravelHub[ID])
    );
    return ID;
end

function Lib.QuickTravel.Global:DestroyQuickTravelHub(_ID)
    if self.QuickTravelHub[_ID] then
        local Data = self.QuickTravelHub[_ID];
        DestroyEntity(Data.ScriptName);
        self:DeactivateQuickTravelHub(_ID);
        ExecuteLocal([[Lib.QuickTravel.Local:DestroyQuickTravelHub(%d)]], _ID);
        self.QuickTravelHub[_ID] = nil;
        CONST_QUICKTRAVEL_HUB[_ID] = nil;
    end
end

function Lib.QuickTravel.Global:ActivateQuickTravelHub(_ID)
    if self.QuickTravelHub[_ID] then
        local EntityID = GetID(self.QuickTravelHub[_ID].ScriptName);
        ExecuteLocal([[Lib.QuickTravel.Local:ActivateQuickTravelHub()]]);
        Logic.SetModel(EntityID, Models.Doodads_D_RangeIndicator);
        Logic.SetVisible(EntityID, true);
        Logic.SetOnScreenInformation(EntityID, 1);
        self.QuickTravelHub[_ID].Active = true;
    end
end

function Lib.QuickTravel.Global:DeactivateQuickTravelHub(_ID)
    if self.QuickTravelHub[_ID] then
        local EntityID = GetID(self.QuickTravelHub[_ID].ScriptName);
        ExecuteLocal([[Lib.QuickTravel.Local:DeactivateQuickTravelHub()]]);
        Logic.SetOnScreenInformation(EntityID, 0);
        Logic.SetVisible(EntityID, false);
        self.QuickTravelHub[_ID].Active = false;
    end
end

function Lib.QuickTravel.Global:ConnectQuickTravelHub(_ID, _OtherID)
    if self.QuickTravelHub[_ID] then
        self.QuickTravelHub[_ID].Connections[_OtherID] = true;
        ExecuteLocal([[Lib.QuickTravel.Local:ConnectQuickTravelHub(%d, %d)]], _ID, _OtherID);
    end
end

function Lib.QuickTravel.Global:SeverQuickTravelHub(_ID, _OtherID)
    if self.QuickTravelHub[_ID] then
        self.QuickTravelHub[_ID].Connections[_OtherID] = nil;
        ExecuteLocal([[Lib.QuickTravel.Local:SeverQuickTravelHub(%d, %d)]], _ID, _OtherID);
    end
end

function Lib.QuickTravel.Global:GetQuickTravelHubIDByEntity(_Entity)
    local EntityID = GetID(_Entity);
    for ID,Data in pairs(self.QuickTravelHub) do
        if type(ID) == "number" then
            if GetID(Data.ScriptName) == EntityID then
                return ID;
            end
        end
    end
    return 0;
end

function Lib.QuickTravel.Global:OnQuickTravelHubInteraction(_EntityID, _PlayerID, _KnightID)
    local ID = self:GetQuickTravelHubIDByEntity(_EntityID);
    if self.QuickTravelHub[ID] then
        local Data = self.QuickTravelHub[ID];
        Logic.SetModel(_EntityID, Models.Doodads_D_RangeIndicator);
        if Data.Active and not IsCinematicEventActive(_PlayerID) then
            StartCinematicEvent("QuickTravel", _PlayerID);
            SendReportToLocal(Report.QuickTravelInteract, ID, _PlayerID, _EntityID, _KnightID);
            SendReport(Report.QuickTravelInteract, ID, _PlayerID, _EntityID, _KnightID);
        end
    end
end

function Lib.QuickTravel.Global:OnQuickTravelHubExecution(_ID, _PlayerID, _KnightID)
    if self.QuickTravelHub[_ID] then
        local Position = GetPosition(self.QuickTravelHub[_ID].ScriptName);
        Logic.DEBUG_SetSettlerPosition(_KnightID, Position.X, Position.Y);
        ExecuteLocal([[Camera.RTS_SetLookAtPosition(%f,%f)]], Position.X, Position.Y);
    end
end

function Lib.QuickTravel.Global:OverrideQuestFunctions()
    self.Orig_GameCallback_OnNPCInteraction = GameCallback_OnNPCInteraction;
    GameCallback_OnNPCInteraction = function(_EntityID, _PlayerID, _KnightID)
        Lib.QuickTravel.Global.Orig_GameCallback_OnNPCInteraction(_EntityID, _PlayerID, _KnightID);
        Lib.QuickTravel.Global:OnQuickTravelHubInteraction(_EntityID, _PlayerID, _KnightID);
    end
end

-- -------------------------------------------------------------------------- --
-- Local

-- Local initalizer method
function Lib.QuickTravel.Local:Initialize()
    if not self.IsInstalled then
        Report.QuickTravelInteract = CreateReport("Event_QuickTravelInteract");
        Report.QuickTravelSelected = CreateReport("Event_QuickTravelSelected");

        -- Garbage collection
        Lib.QuickTravel.Global = nil;
    end
    self.IsInstalled = true;
end

-- Local load game
function Lib.QuickTravel.Local:OnSaveGameLoaded()
end

-- Local report listener
function Lib.QuickTravel.Local:OnReportReceived(_ID, ...)
    if _ID == Report.LoadingFinished then
        self.LoadscreenClosed = true;
    elseif _ID == Report.QuickTravelInteract then
    end
end

function Lib.QuickTravel.Local:ShowTravelDestinations(_ID, _HeroID)
    local PlayerID = Logic.EntitygetPlayer(_HeroID);
    local Connections = self:GetConnectedQuickTravelHubs(_ID, _HeroID);
    if #Connections == 0 then
        Message(Lib.QuickTravel.Text.Hub.NoConnections);
        SendReportToGlobal(Report.QuickTravelSelected, 0, PlayerID, _HeroID);
        SendReport(Report.QuickTravelSelected, 0, PlayerID, _HeroID);
        return;
    end

    local ReachableHubs = {};
    for i= 1, #Connections do
        local Name = self.QuickTravelHub[Connections[i]].DisplayName;
        table.insert(ReachableHubs, Localize(Name));
    end
    table.insert(ReachableHubs, 1, Localize(Lib.QuickTravel.Text.Selection.Cancel));

    local Action = function(_Selected)
        local ID = _Selected -1;
        SendReportToGlobal(Report.QuickTravelSelected, ID, PlayerID, _HeroID);
        SendReport(Report.QuickTravelSelected, ID, PlayerID, _HeroID);
    end
    DialogSelectBox(
        PlayerID,
        Localize(Lib.Requester.Text.Selection.Dialog.Title),
        Localize(Lib.Requester.Text.Selection.Dialog.Text),
        Action,
        ReachableHubs
    );
end

function Lib.QuickTravel.Local:CreateQuickTravelHub(_Data)
    self.QuickTravelHub.Index = self.QuickTravelHub.Index + 1;
    local ID = self.QuickTravelHub.Index;
    self.QuickTravelHub[ID] = _Data;
    return ID;
end

function Lib.QuickTravel.Local:DestroyQuickTravelHub(_ID)
    if self.QuickTravelHub[_ID] then
        self.QuickTravelHub[_ID] = nil;
        CONST_QUICKTRAVEL_HUB[_ID] = nil;
    end
end

function Lib.QuickTravel.Local:ActivateQuickTravelHub(_ID)
    if self.QuickTravelHub[_ID] then
        self.QuickTravelHub[_ID].Active = true;
    end
end

function Lib.QuickTravel.Local:DeactivateQuickTravelHub(_ID)
    if self.QuickTravelHub[_ID] then
        self.QuickTravelHub[_ID].Active = false;
    end
end

function Lib.QuickTravel.Local:ConnectQuickTravelHub(_ID, _OtherID)
    if self.QuickTravelHub[_ID] then
        self.QuickTravelHub[_ID].Connections[_OtherID] = true;
    end
end

function Lib.QuickTravel.Local:SeverQuickTravelHub(_ID, _OtherID)
    if self.QuickTravelHub[_ID] then
        self.QuickTravelHub[_ID].Connections[_OtherID] = nil;
    end
end

function Lib.QuickTravel.Local:GetConnectedQuickTravelHubs(_ID, _HeroID)
    local Connections = {};
    if self.QuickTravelHub[_ID] then
        local PlayerID = Logic.EntityGetPlayer(_HeroID);
        for ID,_ in pairs(self.QuickTravelHub[_ID].Connections) do
            local HubEntityID = GetID(self.QuickTravelHub[ID].ScriptName);
            local IsReachable = CanEntityReachTarget(PlayerID, _HeroID, HubEntityID, nil, PlayerSectorTypes.Civil);
            if self.QuickTravelHub[ID].Active and IsReachable then
                table.insert(Connections, ID);
            end
        end
    end
    return Connections;
end

-- -------------------------------------------------------------------------- --

RegisterModule(Lib.QuickTravel.Name);

