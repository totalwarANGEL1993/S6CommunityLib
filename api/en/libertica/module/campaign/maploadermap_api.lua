--- Ermöglicht die Steuerung einer Kampagnenkarte.
--- 
--- Each map of a campaign must contain a file `maploader.lua`. This file
--- configures the map and must contain the following:
--- 
--- ```lua
--- LocalMapData = {
---     -- Code word that must be in the profile
---     MapCode = "a5b7c8",
---     -- Show splash screen (splashscreen.png)
---     Splashscreen = true,
---     -- Required loader version
---     LoaderVersion = 1,
---     -- Selectable heroes
---     PossibleKnights = {
---         "U_KnightTrading",
---         "U_KnightHealing",
---         "U_KnightChivalry",
---         "U_KnightWisdom",
---         "U_KnightPlunder",
---         "U_KnightSong",
---         "U_KnightSaraya",
---     },
---     -- Required maps (max. 5)
---     RequiredMaps = {
---         "examplecampaign_examplemap1",
---         "examplecampaign_examplemap2",
---     },
--- };
--- ```
---
Lib.MapLoaderMap = Lib.MapLoaderMap or {};

--- Saves to the profile that the current map has been won.
function CampaignMap_SetFinished()
end
API.CampaignMap_SetFinished = CampaignMap_SetFinished;

--- Adds a key that should be saved in the profile.
--- @param _Key string Key
--- @param _Value string Value
function CampaignMap_AddValue(_Key, _Value)
end
API.CampaignMap_AddValue = CampaignMap_AddValue;

--- Returns the value of the key.
--- @param _Key string Key
--- @return string Wert Value
function CampaignMap_GetValue(_Key)
	return "";
end
API.CampaignMap_GetValue = CampaignMap_GetValue;

--- Removes a key from the profile.
--- @param _Key string Key
function CampaignMap_RemoveValue(_Key)
end
API.CampaignMap_RemoveValue = CampaignMap_RemoveValue;

--- Loads all predefined keys from the profile.
function CampaignMap_LoadValues()
end
API.CampaignMap_LoadValues = CampaignMap_LoadValues;

--- Saves all predefined keys to the profile.
function CampaignMap_SaveValues()
end
API.CampaignMap_SaveValues = CampaignMap_SaveValues;

