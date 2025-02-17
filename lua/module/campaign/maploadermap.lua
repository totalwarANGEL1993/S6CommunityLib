Lib.MapLoader = Lib.MapLoader or {};
Lib.MapLoaderMap.Name = "MapLoader";
Lib.MapLoaderMap.Global = {};
Lib.MapLoaderMap.Local  = {
    Campaign = {
        MapData = {},
    },
};

Lib.Require("core/Core");
Lib.Register("module/campaign/MapLoaderMap_API");
Lib.Register("module/campaign/MapLoaderMap");

CONST_CAMPAIGN_MAP_VALUES = {};

-- -------------------------------------------------------------------------- --
-- Global

-- Global initalizer method
function Lib.MapLoaderMap.Global:Initialize()
    if not self.IsInstalled then

        -- Garbage collection
        Lib.MapLoaderMap.Local = nil;
    end
    self.IsInstalled = true;
end

-- Global load game
function Lib.MapLoaderMap.Global:OnSaveGameLoaded()
end

-- Global report listener
function Lib.MapLoaderMap.Global:OnReportReceived(_ID, ...)
    if _ID == Report.LoadingFinished then
        self.LoadscreenClosed = true;
    end
end

-- -------------------------------------------------------------------------- --
-- Local

-- Global initalizer method
function Lib.MapLoaderMap.Local:Initialize()
    if not self.IsInstalled then
        Script.Load("maps/development/" ..Framework.GetCurrentMapName().. "/maploader.lua");
        self.MapData = table.copy(LocalMapData or {});

        self:ReplaceKnight();

        -- Garbage collection
        Lib.MapLoaderMap.Global = nil;
    end
    self.IsInstalled = true;
end

-- Global load game
function Lib.MapLoaderMap.Local:OnSaveGameLoaded()
end

-- Global report listener
function Lib.MapLoaderMap.Local:OnReportReceived(_ID, ...)
    if _ID == Report.LoadingFinished then
        self.LoadscreenClosed = true;
    end
end

function Lib.MapLoaderMap.Local:ReplaceKnight()
    StartSimpleJobEx(function()
        local MapName = Framework.GetCurrentMapName();
        local PlayerID = GUI.GetPlayerID();
        local KnightTypeName = Profile.GetString(MapName, "SelectedKnight") or "U_KnightChivalry";
        if Logic.GetKnightID(PlayerID) ~= 0 then
            ExecuteGlobal([[
                ReplaceEntity(Logic.GetKnightID(%d), Entities["%s"])
                SetPlayerPortrait(%d)
                ExecuteGlobal("LocalSetKnightPicture()")
            ]], PlayerID, KnightTypeName, PlayerID);
            return true;
        end
    end);
end

-- -------------------------------------------------------------------------- --

RegisterModule(Lib.MapLoaderMap.Name);

