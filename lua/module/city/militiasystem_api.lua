Lib.Require("comfort/IsLocalScript");
Lib.Register("module/city/MilitiaSystem_API");

function ActivateMilitia()
    Lib.MilitiaSystem.Local:ActivateMilitia();
end
API.ActivateMilitia = ActivateMilitia;

function DeactivateMilitia()
    Lib.MilitiaSystem.Local:DeactivateMilitia();
end
API.DeactivateMilitia = DeactivateMilitia;

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

