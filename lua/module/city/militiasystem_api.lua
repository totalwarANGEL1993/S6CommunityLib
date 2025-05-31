Lib.Require("comfort/IsLocalScript");
Lib.Register("module/city/MilitiaSystem_API");

function ActivateMilitia()
    assert(not IsLocalScript(), "Can not be used in local script!");
    ExecuteLocal("Lib.MilitiaSystem.Local:ActivateMilitia()");
end
API.ActivateMilitia = ActivateMilitia;

function DeactivateMilitia()
    assert(not IsLocalScript(), "Can not be used in local script!");
    ExecuteLocal("Lib.MilitiaSystem.Local:DeactivateMilitia()");
end
API.DeactivateMilitia = DeactivateMilitia;

function ActivateMilitiaSkills()
    assert(not IsLocalScript(), "Can not be used in local script!");
    ExecuteLocal("Lib.MilitiaSystem.Shared:ActivateUnitTypeSkills()");
    Lib.MilitiaSystem.Shared:ActivateUnitTypeSkills();
end
API.ActivateMilitiaSkills = ActivateMilitiaSkills;

function DeactivateMilitiaSkills()
    assert(not IsLocalScript(), "Can not be used in local script!");
    ExecuteLocal("Lib.MilitiaSystem.Shared:DeactivateUnitTypeSkills()");
    Lib.MilitiaSystem.Shared:DeactivateUnitTypeSkills();
end
API.DeactivateMilitiaSkills = DeactivateMilitiaSkills;

function UseDefaultMilitiaTypes(_PlayerID)
    ExecuteLocal("Lib.MilitiaSystem.Shared:SetDefaultUnitTypeAllocation(%d)", _PlayerID);
    Lib.MilitiaSystem.Shared:SetDefaultUnitTypeAllocation(_PlayerID);
end
API.UseDefaultMilitiaTypes = UseDefaultMilitiaTypes;

function UseDefaultMilitiaTypesForAllPlayers()
    for PlayerID = 1, 8 do
        UseDefaultMilitiaTypes(PlayerID);
    end
end
API.UseDefaultMilitiaTypesForAllPlayers = UseDefaultMilitiaTypesForAllPlayers;

function UseRandomMilitiaTypes(_PlayerID)
    ExecuteLocal("Lib.MilitiaSystem.Shared:SetRandomUnitTypeAllocation(%d)", _PlayerID);
    Lib.MilitiaSystem.Shared:SetRandomUnitTypeAllocation(_PlayerID);
end
API.UseRandomMilitiaTypes = UseRandomMilitiaTypes;

function UseRandomMilitiaTypesForAllPlayers()
    for PlayerID = 1, 8 do
        UseRandomMilitiaTypes(PlayerID);
    end
end
API.UseRandomMilitiaTypesForAllPlayers = UseRandomMilitiaTypesForAllPlayers;

function RequireTitleForMeleeMilitia(_Title)
    assert(not IsLocalScript(), "Can not be used in local script!");
    local Tech = Technologies.R_Mercenary_Melee;
    Lib.MilitiaSystem.Global:SetRequiredRank(_Title, Tech);
end
API.RequireTitleForMeleeMilitia = RequireTitleForMeleeMilitia;

function RequireTitleForRangedMilitia(_Title)
    assert(not IsLocalScript(), "Can not be used in local script!");
    local Tech = Technologies.R_Mercenary_Ranged;
    Lib.MilitiaSystem.Global:SetRequiredRank(_Title, Tech);
end
API.RequireTitleForRangedMilitia = RequireTitleForRangedMilitia;

