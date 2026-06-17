Lib.Require("comfort/IsLocalScript");
Lib.Register("module/settings/Profile_API");

function RegisterTransientProfileValue(dataType, section, key)
    assert(not IsLocalScript(), "Can not be used in local script!");
    Lib.Profile.Global:RegisterStringWrappedValue(ProfileDataBehavior.TRANSIENT, dataType, section, key);
end
API.RegisterTransientProfileValue = RegisterTransientProfileValue;

function RegisterProfileValue(dataType, section, key)
    assert(not IsLocalScript(), "Can not be used in local script!");
    Lib.Profile.Global:RegisterStringWrappedValue(ProfileDataBehavior.PERSISTENT, dataType, section, key);
end
API.RegisterProfileValue = RegisterProfileValue;

function LoadTransientProfileData()
    assert(not IsLocalScript(), "Can not be used in local script!");
    Lib.Profile.Global:LoadTransientProfileData();
end
API.LoadTransientProfileData = LoadTransientProfileData;

function LoadProfileData()
    assert(not IsLocalScript(), "Can not be used in local script!");
    Lib.Profile.Global:LoadPersistentProfileData();
end
API.LoadProfileData = LoadProfileData;

function SaveTransientProfileData()
    assert(not IsLocalScript(), "Can not be used in local script!");
    Lib.Profile.Global:SaveTransientProfileData();
end
API.SaveTransientProfileData = SaveTransientProfileData;

function SaveProfileData()
    assert(not IsLocalScript(), "Can not be used in local script!");
    Lib.Profile.Global:SavePersistentProfileData();
end
API.SaveProfileData = SaveProfileData;

function GetTransientProfileValue(section, key)
    return Lib.Profile.Shared:GetStringWrappedValue(ProfileDataBehavior.TRANSIENT, section, key);
end
API.GetTransientProfileValue = GetTransientProfileValue;

function GetProfileValue(section, key)
    return Lib.Profile.Shared:GetStringWrappedValue(ProfileDataBehavior.PERSISTENT, section, key);
end
API.GetProfileValue = GetProfileValue;

function SetTransientProfileValue(section, key, value)
    assert(not IsLocalScript(), "Can not be used in local script!");
    if type(value) == "string" then
        assert(not value:find("[\"\\\n\r]"), "Invalid characters in profile value!");
    end
    Lib.Profile.Global:SetStringWrappedValue(ProfileDataBehavior.TRANSIENT, section, key, value);
end
API.SetTransientProfileValue = SetTransientProfileValue;

function SetProfileValue(section, key, value)
    assert(not IsLocalScript(), "Can not be used in local script!");
    if type(value) == "string" then
        assert(not value:find("[\"\\\n\r]"), "Invalid characters in profile value!");
    end
    Lib.Profile.Global:SetStringWrappedValue(ProfileDataBehavior.PERSISTENT, section, key, value);
end
API.SetProfileValue = SetProfileValue;

