Lib.Require("comfort/IsLocalScript");
Lib.Require("comfort/ReplaceEntity");
Lib.Register("module/campaign/MapLoaderMap_API");

function CampaignMap_SetFinished()
	assert(IsLocalScript(), "Can not be used in global script!");
	local MapName = Framework.GetCurrentMapName();
	local MapCode = Lib.MapLoaderMap.Local.MapData.MapCode or "";
    Profile.SetString(MapName, "SuccessfullyFinished", MapCode);
end
API.CampaignMap_SetFinished = CampaignMap_SetFinished;

function CampaignMap_AddValue(_Key, _Value)
	assert(IsLocalScript(), "Can not be used in global script!");
	CONST_CAMPAIGN_MAP_VALUES[_Key] = _Value;
end
API.CampaignMap_AddValue = CampaignMap_AddValue;

function CampaignMap_GetValue(_Key)
	assert(IsLocalScript(), "Can not be used in global script!");
	return CONST_CAMPAIGN_MAP_VALUES[_Key];
end
API.CampaignMap_GetValue = CampaignMap_GetValue;

function CampaignMap_RemoveValue(_Key)
	assert(IsLocalScript(), "Can not be used in global script!");
	CONST_CAMPAIGN_MAP_VALUES[_Key] = "";
end
API.CampaignMap_RemoveValue = CampaignMap_RemoveValue;

function CampaignMap_LoadValues()
	assert(IsLocalScript(), "Can not be used in global script!");
	local MapName = Framework.GetCurrentMapName();
	for k, v in pairs(CONST_CAMPAIGN_MAP_VALUES) do
		local Value = Profile.GetString(MapName, v);
		ExecuteGlobal([[CONST_CAMPAIGN_MAP_VALUES.%s = "%s"]], v, Value);
    end
end
API.CampaignMap_LoadValues = CampaignMap_LoadValues;

function CampaignMap_SaveValues()
	assert(IsLocalScript(), "Can not be used in global script!");
	local MapName = Framework.GetCurrentMapName();
	for k, v in pairs(CONST_CAMPAIGN_MAP_VALUES) do
		Profile.SetString(MapName, k, v);
    end
end
API.CampaignMap_SaveValues = CampaignMap_SaveValues;

