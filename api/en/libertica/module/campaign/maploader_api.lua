--- Enables the creation of a dynamic campaign.
---
--- The individual maps of the campaign can be delivered immediately, or
--- piece by piece in installments, as the system also finds the maps if they
--- are added to the map directory later.
---
--- Features:
--- * Create a campaign from multiple maps
--- * Maps can only be started if their predecessors have been won
--- * Missions are displayed in a list when the main map is started
--- * Missions can also be released later
--- * Missions can have individual backgrounds
---
Lib.MapLoader = Lib.MapLoader or {};

--- Sets the campaign prefix.
--- 
--- The prefix is used to find the maps at runtime.
--- 
--- @param _Name string Campaign prefix
function Campaign_SetBaseName(_Name)
end
API.Campaign_SetBaseName = Campaign_SetBaseName;

--- Searches for the campaign maps.
--- 
--- Cannot be executed if the prefix has not been set yet.
function Campaign_ScanForMaps()
end
API.Campaign_ScanForMaps = Campaign_ScanForMaps;

--- Starts the map selection.
--- 
--- Cannot be executed if the maps have not been searched for yet.
function Campaign_StartMapSelection()
end
API.Campaign_StartMapSelection = Campaign_StartMapSelection;

