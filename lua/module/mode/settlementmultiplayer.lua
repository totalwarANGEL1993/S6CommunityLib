Lib.SettlementMultiplayer = Lib.SettlementMultiplayer or {};
Lib.SettlementMultiplayer.Name = "SettlementMultiplayer";
Lib.SettlementMultiplayer.Global = {};
Lib.SettlementMultiplayer.Local  = {};
Lib.SettlementMultiplayer.Shared = {
    RuleSet = {},
};

Lib.Require("core/Core");
Lib.Require("module/city/Construction");
Lib.Require("module/entity/EntitySearch");
Lib.Require("module/fix/Damage");
Lib.Require("module/mode/SettlementMultiplayer_API");
Lib.Register("module/mode/SettlementMultiplayer");

-- -------------------------------------------------------------------------- --
-- Global

-- Global initalizer method
function Lib.SettlementMultiplayer.Global:Initialize()
    if not self.IsInstalled then
        DeleteFromRestrictionList(-1);
        DeleteFromProtectionList(-1);

        self:LoadMapRules();
    end
    self.IsInstalled = true;
end

-- Global report listener
function Lib.SettlementMultiplayer.Global:OnReportReceived(_ID, ...)
    if _ID == Report.LoadingFinished then
        self.LoadscreenClosed = true;
        self:CreateCustomRuleFunctions();
        for PlayerID = 1, 8 do
            self:ActivateHakimPlayerHandycap(PlayerID);
            self:ActivateWallCatapultProximity(PlayerID);
            self:ActivateBeeKeeperProximity(PlayerID);
            self:ActivateWallOnHomeTerritory(PlayerID);
            self:ActivatePalisadeNextToOutposts(PlayerID);
        end
    elseif _ID == Report.BuildingUpgraded then
    end
end

function Lib.SettlementMultiplayer.Global:LoadMapRules()
    local MapName = Framework.GetCurrentMapName();
    self.Shared:LoadMapRules(MapName);
end

function Lib.SettlementMultiplayer.Global:CreateCustomRuleFunctions()
    SettlementMultiplayer_Global_BeekeeperToWallDistanceRule = function(_PlayerID, _Type, _X, _Y)
        if _Type == Entities.B_Beehive then
            return Logic.GetPlayerEntitiesInAreaOfType(_PlayerID, Entities.B_Beekeeper, _X, _Y, 1500) > 0;
        end
        if _Type == Entities.B_Beekeeper then
            local Count, Area = 0, 1500;
            -- Bulky but better for performence than calls of lib searchers
            Count = Count + Logic.GetPlayerEntitiesInAreaOfType(_PlayerID, Entities.B_PalisadeSegment, _X, _Y, Area);
            Count = Count + Logic.GetPlayerEntitiesInAreaOfType(_PlayerID, Entities.B_PalisadeGate, _X, _Y, Area);
            if g_GameExtraNo > 0 then
                Count = Count + Logic.GetPlayerEntitiesInAreaOfType(_PlayerID, Entities.B_WallSegment_AS, _X, _Y, Area);
                Count = Count + Logic.GetPlayerEntitiesInAreaOfType(_PlayerID, Entities.B_WallGate_AS, _X, _Y, Area);
            end
            Count = Count + Logic.GetPlayerEntitiesInAreaOfType(_PlayerID, Entities.B_WallSegment_ME, _X, _Y, Area);
            Count = Count + Logic.GetPlayerEntitiesInAreaOfType(_PlayerID, Entities.B_WallGate_ME, _X, _Y, Area);
            Count = Count + Logic.GetPlayerEntitiesInAreaOfType(_PlayerID, Entities.B_WallSegment_NA, _X, _Y, Area);
            Count = Count + Logic.GetPlayerEntitiesInAreaOfType(_PlayerID, Entities.B_WallGate_NA, _X, _Y, Area);
            Count = Count + Logic.GetPlayerEntitiesInAreaOfType(_PlayerID, Entities.B_WallSegment_NE, _X, _Y, Area);
            Count = Count + Logic.GetPlayerEntitiesInAreaOfType(_PlayerID, Entities.B_WallGate_NE, _X, _Y, Area);
            Count = Count + Logic.GetPlayerEntitiesInAreaOfType(_PlayerID, Entities.B_WallSegment_SE, _X, _Y, Area);
            Count = Count + Logic.GetPlayerEntitiesInAreaOfType(_PlayerID, Entities.B_WallGate_SE, _X, _Y, Area);
            return Count == 0;
        end
        return true;
    end
end

-- Global player debuff for selecting Hakim.
function Lib.SettlementMultiplayer.Global:ActivateHakimPlayerHandycap(_PlayerID)
    if self.RuleSet and self.RuleSet.RULE_HAKIM_PLAYER_HANDYCAP then
        local KnightID = Logic.GetKnightID(_PlayerID);
        local Type = Logic.GetEntityType(KnightID);
        if Type == Entities.U_Knight_Wisdom then
            SetPlayerModifier(_PlayerID, 0.88);
        end
    end
end

-- Use max distance between wall catapults if the rule is enabled.
function Lib.SettlementMultiplayer.Global:ActivateWallCatapultProximity(_PlayerID)
    if self.RuleSet and self.RuleSet.RULE_WALL_CATAPULT_PROXIMITY then
        UseForceBallistaDistance(true);
    end
end

-- Forbid beekeepers close to walls if the rule is enabled.
function Lib.SettlementMultiplayer.Global:ActivateBeeKeeperProximity(_PlayerID)
    if self.RuleSet and self.RuleSet.RULE_BEEKEEPER_WALL_PROXIMITY then
        CustomRuleConstructBuilding(_PlayerID, "SettlementMultiplayer_Global_BeekeeperToWallDistanceRule");
        CustomRuleConstructBuilding(_PlayerID, "SettlementMultiplayer_Global_WallToBeekeeperDistanceRule");
    end
end

-- Forbids walls outside the home territory if the rule is enabled.
function Lib.SettlementMultiplayer.Global:ActivateWallOnHomeTerritory(_PlayerID)
    if self.RuleSet and self.RuleSet.RULE_BEEKEEPER_WALL_PROXIMITY then
        CustomRuleConstructBuilding(_PlayerID, "SettlementMultiplayer_Global_WallOnHomeTerritory");
    end
end

-- Forbids palisades if they are not close to an outpost if the rule is enabled.
function Lib.SettlementMultiplayer.Global:ActivatePalisadeNextToOutposts(_PlayerID)
    if self.RuleSet and self.RuleSet.RULE_BEEKEEPER_WALL_PROXIMITY then
        CustomRuleConstructBuilding(_PlayerID, "SettlementMultiplayer_Global_PalisadeNextToOutposts");
    end
end

-- -------------------------------------------------------------------------- --
-- Local

-- Local initalizer method
function Lib.SettlementMultiplayer.Local:Initialize()
    if not self.IsInstalled then
        self:LoadMapRules();
        self:CreateCustomRuleFunctions();
    end
    self.IsInstalled = true;
end

-- Local report listener
function Lib.SettlementMultiplayer.Local:OnReportReceived(_ID, ...)
    if _ID == Report.LoadingFinished then
        self.LoadscreenClosed = true;
    end
end

function Lib.SettlementMultiplayer.Local:LoadMapRules()
    local MapName = Framework.GetCurrentMapName();
    self.Shared:LoadMapRules(MapName);
end

function Lib.SettlementMultiplayer.Local:CreateCustomRuleFunctions()
    SettlementMultiplayer_Global_WallToBeekeeperDistanceRule = function(_PlayerID, IsWall, _X, _Y)
        local Count, Area = 0, 1500;
        Count = Count + Logic.GetPlayerEntitiesInAreaOfType(_PlayerID, Entities.B_Beehive, _X, _Y, Area);
        Count = Count + Logic.GetPlayerEntitiesInAreaOfType(_PlayerID, Entities.B_Beekeeper, _X, _Y, Area);
        return Count == 0;
    end

    SettlementMultiplayer_Global_PalisadeNextToOutposts = function(_PlayerID, IsWall, _X, _Y)
        if not IsWall then
            local HomeTerritoryID = GetTerritoryUnderEntity(Logic.GetStoreHouse(_PlayerID));
            local TerritoryID = Logic.GetTerritoryAtPosition(_X, _Y);
            if HomeTerritoryID ~= TerritoryID then
                local Count, Area = 0, 1750;
                if g_GameExtraNo > 0 then
                    Count = Count + Logic.GetPlayerEntitiesInAreaOfType(_PlayerID, Entities.B_Outpost_ME, _X, _Y, Area);
                end
                Count = Count + Logic.GetPlayerEntitiesInAreaOfType(_PlayerID, Entities.B_Outpost_ME, _X, _Y, Area);
                Count = Count + Logic.GetPlayerEntitiesInAreaOfType(_PlayerID, Entities.B_Outpost_NA, _X, _Y, Area);
                Count = Count + Logic.GetPlayerEntitiesInAreaOfType(_PlayerID, Entities.B_Outpost_NE, _X, _Y, Area);
                Count = Count + Logic.GetPlayerEntitiesInAreaOfType(_PlayerID, Entities.B_Outpost_SE, _X, _Y, Area);
                return Count > 0;
            end
        end
        return true;
    end

    SettlementMultiplayer_Global_WallOnHomeTerritory = function(_PlayerID, IsWall, _X, _Y)
        if IsWall then
            local HomeTerritoryID = GetTerritoryUnderEntity(Logic.GetStoreHouse(_PlayerID));
            local TerritoryID = Logic.GetTerritoryAtPosition(_X, _Y);
            return HomeTerritoryID == TerritoryID;
        end
        return true;
    end
end

-- -------------------------------------------------------------------------- --
-- Shared

function Lib.SettlementMultiplayer.Shared:LoadMapRules(_MapName)
    assert(type(_MapName) == "string", "Invalid argument: _MapName must be a string");
    Script.Load("maps/externalmap/" .. _MapName:lower() .. "/cms_Rules.lua");
    if (CMS_Rules ~= nil and type(CMS_Rules) == "table") then
        self.RuleSet = CMS_Rules;
    end
    CMS_Rules = nil;
end

function Lib.SettlementMultiplayer.Shared:GetRuleDefinition()
    return self.RuleSet or {};
end

-- -------------------------------------------------------------------------- --

RegisterModule(Lib.SettlementMultiplayer.Name);

