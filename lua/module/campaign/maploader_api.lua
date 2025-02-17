Lib.Require("comfort/IsLocalScript");
Lib.Register("module/campaign/MapLoader_API");

function Campaign_SetBaseName(_Name)
	assert(IsLocalScript(), "Can not be used in global script!");
	Lib.MapLoader.Local:SetBaseName(_Name);
end
API.Campaign_SetBaseName = Campaign_SetBaseName;

function Campaign_ScanForMaps()
	assert(IsLocalScript(), "Can not be used in global script!");
	assert(Lib.MapLoader.Local.Campaign.BaseName ~= nil, "Base name is not set!");
	Lib.MapLoader.Local:Prepare();
end
API.Campaign_ScanForMaps = Campaign_ScanForMaps;

function Campaign_StartMapSelection()
	assert(IsLocalScript(), "Can not be used in global script!");
	assert(Lib.MapLoader.Local.Campaign.BaseName ~= nil, "Base name is not set!");
	assert(Lib.MapLoader.Local.Campaign.Scanned, "Not scanned for maps!");
	API.StartHiResJob(function()
		if XGUIEng.IsWidgetShownEx("/LoadScreen/LoadScreen") == 0 then
			Lib.MapLoader.Local:OverrideEndscreenDialog();
			OpenCustomGameDialog();
			return true;
		end
	end);
end
API.Campaign_StartMapSelection = Campaign_StartMapSelection;

