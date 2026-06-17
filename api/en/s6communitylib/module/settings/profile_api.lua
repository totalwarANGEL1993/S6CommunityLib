--- Module for the synchronized management of values from the profile.
--- 
--- Types of values in the profile:
--- <ol>
--- <li><b>Normal values</b> - These values remain permanently in the profile.
---     They behave like standard profile values.</li>
--- <li><b>Transient values</b> - These values are deleted from the profile
---     after they are retrieved. They are intended for scenarios such as
---     starting a different map and using the profile to transfer data.</li>
--- </ol>

--- Registers a transient value in the profile that will be synchronized.
--- @param dataType integer Expected data type (ProfileDataType)
--- @param section string Name of the section
--- @param key string Name of the key
function RegisterTransientProfileValue(dataType, section, key)
end
API.RegisterTransientProfileValue = RegisterTransientProfileValue;

--- Registers a value in the profile that will be synchronized.
--- @param dataType integer Expected data type (ProfileDataType)
--- @param section string Name of the section
--- @param key string Name of the key
function RegisterProfileValue(dataType, section, key)
end
API.RegisterProfileValue = RegisterProfileValue;

--- Loads all registered transient values from the profile.
--- <p>
--- <b>Attention</b>: Transient values are deleted from the profile after loading!
function LoadTransientProfileData()
end
API.LoadTransientProfileData = LoadTransientProfileData;

--- Loads all registered values from the profile.
function LoadProfileData()
end
API.LoadProfileData = LoadProfileData;

--- Saves all registered transient values to the profile.
function SaveTransientProfileData()
end
API.SaveTransientProfileData = SaveTransientProfileData;

--- Saves all registered values to the profile.
function SaveProfileData()
end
API.SaveProfileData = SaveProfileData;

--- Returns a transient value that has been synchronized from the profile.
--- @param section string Name of the section
--- @param key string Name of the key
--- @return any Value Transient value from profile
function GetTransientProfileValue(section, key)
    return nil;
end
API.GetTransientProfileValue = GetTransientProfileValue;

--- Returns a value that has been synchronized from the profile.
--- @param section string Name of the section
--- @param key string Name of the key
--- @return any Value Value from profile
function GetProfileValue(section, key)
    return nil;
end
API.GetProfileValue = GetProfileValue;

--- Saves a synchronized transient value in the profile.
--- @param section string Name of the section
--- @param key string Name of the key
--- @return any Value Value from profile
function SetTransientProfileValue(section, key, value)
end
API.SetTransientProfileValue = SetTransientProfileValue;

--- Saves a synchronized value in the profile.
--- @param section string Name of the section
--- @param key string Name of the key
--- @return any Value Value from profile
function SetProfileValue(section, key, value)
end
API.SetProfileValue = SetProfileValue;