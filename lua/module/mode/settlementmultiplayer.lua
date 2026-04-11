Lib.SettlementMultiplayer = Lib.SettlementMultiplayer or {};
Lib.SettlementMultiplayer.Name = "SettlementMultiplayer";
Lib.SettlementMultiplayer.Global = {};
Lib.SettlementMultiplayer.Local  = {};
Lib.SettlementMultiplayer.Shared = {
    RuleSet = {},
};

Lib.Require("core/Core");
Lib.Require("module/mode/SettlementLimitation");
Lib.Require("module/mode/SettlementSurvival");
Lib.Require("module/mode/SettlementMultiplayer_API");
Lib.Register("module/mode/SettlementMultiplayer");

-- -------------------------------------------------------------------------- --
-- Global

-- Global initalizer method
function Lib.SettlementMultiplayer.Global:Initialize()
    if not self.IsInstalled then
        self:LoadMapRules();
    end
    self.IsInstalled = true;
end

function Lib.SettlementMultiplayer.Global:LoadMapRules()
    local MapName = Framework.GetCurrentMapName();
    self.Shared:LoadMapRules(MapName);
end

-- -------------------------------------------------------------------------- --
-- Local

-- Local initalizer method
function Lib.SettlementMultiplayer.Local:Initialize()
    if not self.IsInstalled then
        self:LoadMapRules();
    end
    self.IsInstalled = true;
end

function Lib.SettlementMultiplayer.Local:LoadMapRules()
    local MapName = Framework.GetCurrentMapName();
    self.Shared:LoadMapRules(MapName);
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

-- -------------------------------------------------------------------------- --

RegisterModule(Lib.SettlementMultiplayer.Name);

