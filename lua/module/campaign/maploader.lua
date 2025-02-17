Lib.MapLoader = Lib.MapLoader or {};
Lib.MapLoader.Name = "MapLoader";
Lib.MapLoader.Global = {
    Version  = 1,
};
Lib.MapLoader.Local  = {
    Campaign = {
        MapNames = {},
        MapData = {},
    },
    Version  = 1,
};

Lib.Require("core/Core");
Lib.Register("module/campaign/MapLoader_API");
Lib.Register("module/campaign/MapLoader_Text");
Lib.Register("module/campaign/MapLoader");

-- -------------------------------------------------------------------------- --
-- Global

-- Global initalizer method
function Lib.MapLoader.Global:Initialize()
    if not self.IsInstalled then

        -- Garbage collection
        Lib.MapLoader.Local = nil;
    end
    self.IsInstalled = true;
end

-- Global load game
function Lib.MapLoader.Global:OnSaveGameLoaded()
end

-- Global report listener
function Lib.MapLoader.Global:OnReportReceived(_ID, ...)
    if _ID == Report.LoadingFinished then
        self.LoadscreenClosed = true;
    end
end

-- -------------------------------------------------------------------------- --
-- Local

-- Global initalizer method
function Lib.MapLoader.Local:Initialize()
    if not self.IsInstalled then
        Script.Load("script/mainmenu/customgame.lua");
        local MapName = Framework.GetCurrentMapName();
        Profile.SetInteger(MapName, "Version", self.Campaign.Version);

        -- Garbage collection
        Lib.MapLoader.Global = nil;
    end
    self.IsInstalled = true;
end

-- Global load game
function Lib.MapLoader.Local:OnSaveGameLoaded()
end

-- Global report listener
function Lib.MapLoader.Local:OnReportReceived(_ID, ...)
    if _ID == Report.LoadingFinished then
        self.LoadscreenClosed = true;
    end
end

function Lib.MapLoader.Local:Prepare()
    self:ScanForMaps();
    self:OverrideCustomGameMapSelectionDialog();
    self.Campaign.Scanned = true;
end

function Lib.MapLoader.Local:SetBaseName(_Name)
    self.Campaign.BaseName = _Name;
end

function Lib.MapLoader.Local:SetKnightTypes(...)
    self.Campaign.KnightTypes = arg;
end

function Lib.MapLoader.Local:ScanForMaps()
	self.Campaign.MapNames = {};
	self.Campaign.MapData  = {};

    local CurrentIndex = 0;
    local MapsPerIteration = 50;

    local BaseName = self.Campaign.BaseName;
    assert(BaseName ~= nil, "No base name defined for campaign!");

    local NewMaps;
    repeat
        NewMaps = {Framework.GetMapNames(CurrentIndex, MapsPerIteration, 1, nil)};
		for i= 1, #NewMaps, 1 do
            if NewMaps[i]:find("^" ..BaseName) then
                table.insert(self.Campaign.MapNames, NewMaps[i]);
                Script.Load("maps/development/" ..NewMaps[i].. "/maploader.lua");
                self.Campaign.MapData[NewMaps[i]] = table.copy(LocalMapData or {});
                LocalMapData = nil;
            end
        end
        CurrentIndex = CurrentIndex + MapsPerIteration;
    until #NewMaps < MapsPerIteration;
end

function Lib.MapLoader.Local:SelectMap(_Selected)
	self.Campaign.SelectedMapName = self.Campaign.MapNames[_Selected];
	local Name = self.Campaign.SelectedMapName;
	local Path = "maps/development/" ..Name;
	local MotherWidget = "/LoadScreen/LoadScreen/ContainerDescription";
    local MapInfo = self:GetMapInformation(Name);
	XGUIEng.SetText(MotherWidget.. "/MapName", MapInfo[1] or "-");
	XGUIEng.SetText(MotherWidget.. "/LoadScreenReadMe", MapInfo[2] or "-");

	if self.Campaign.MapData[Name] and self.Campaign.MapData[Name].Splashscreen then
		XGUIEng.SetMaterialTexture("/EndScreen/EndScreen/BG", 0, Path.. "/splashscreen.png");
		XGUIEng.SetMaterialColor("/EndScreen/EndScreen/BG", 0, 255, 255, 255, 255);
	else
		XGUIEng.SetMaterialTexture("/EndScreen/EndScreen/BG", 0, "graphics/textures/gui_1200/loadscreens/throneroom.png");
		XGUIEng.SetMaterialColor("/EndScreen/EndScreen/BG", 0, 255, 255, 255, 255);
	end
end

function Lib.MapLoader.Local:StartMap()
	local MapName = Framework.GetCurrentMapName();
	local Name    = self.Campaign.SelectedMapName;

	if Name == nil or Framework.GetMapNameAndDescription(Name) == nil then
		AddMessage(Lib.MapLoader.Text.MapNotFound);
		return;
	end

	local RequiredVersion = self.Campaign.MapData[Name].LoaderVersion or 1;
	if RequiredVersion > self.Campaign.Version then
		AddMessage(Lib.MapLoader.Text.InsufficentLoaderVersion);
		return;
	end

	if self:CanMapBeStarted(Name) ~= true then
		local Text = Localize(Lib.MapLoader.Text.RequiredMaps.Text);
		for k, v in pairs(self.Campaign.MapData[Name].RequiredMaps) do
			local DisplayName = self:GetMapInformation(v)[1] or "Error";
            Text = Text .. "- " ..DisplayName.. "{cr}";
		end
		DialogInfoBox(Lib.MapLoader.Text.RequiredMaps.Title,Text,function() end);
		return;
	end

	local Knight = CustomGame.Knight +1;
	Profile.SetString(Name, "SelectedKnight", CustomGame.KnightTypes[Knight]);
	Profile.SetString(Name, "MapLoader", MapName);
	Profile.SetInteger(Name, "MapLoaderVersion", self.Campaign.MapData[Name].LoaderVersion or 1);
	Framework.SetLoadScreenNeedButton(1);
	InitLoadScreen(false, 1, Name, 0, 0);
	Framework.ResetProgressBar();
	Framework.StartMap(Name, 1, 0);
end

function Lib.MapLoader.Local:IsMapCompleted(_Name)
	if self.Campaign.MapData[_Name] == nil then
		return false;
	end
	return Profile.GetString(_Name, "SuccessfullyFinished") == self.Campaign.MapData[_Name].MapCode;
end

function Lib.MapLoader.Local:CanMapBeStarted(_Name)
	if self.Campaign.MapData[_Name] == nil then
		return true;
	end
	if self.Campaign.MapData[_Name].RequiredMaps == nil or #self.Campaign.MapData[_Name].RequiredMaps == 0 then
		return true;
	end
	for k, v in pairs(self.Campaign.MapData[_Name].RequiredMaps) do
		if self:IsMapCompleted(v) ~= true then
			return false;
		end
	end
	return true;
end

function Lib.MapLoader.Local:FillHeroComboBox(_TryToKeepSelectedKnight)
	local Name = self.Campaign.SelectedMapName;
	if self.Campaign.MapData[Name] == nil or self.Campaign.MapData[Name].PossibleKnights == nil then
		CustomGame_FillHeroComboBox_Orig_MapLoader(_TryToKeepSelectedKnight);
		return;
	end
	local HeroComboBoxID = XGUIEng.GetWidgetID(CustomGame.Widget.KnightsList);

    local OldKnightName
    if _TryToKeepSelectedKnight then
        local Index = XGUIEng.ListBoxGetSelectedIndex(HeroComboBoxID);
        OldKnightName = CustomGame.CurrentKnightList[Index +1];
    end
    XGUIEng.ListBoxPopAll(HeroComboBoxID);

    local KnightSelection = CustomGame.KnightTypes;
	if #self.Campaign.MapData[Name].PossibleKnights > 0 then
		KnightSelection = self.Campaign.MapData[Name].PossibleKnights;
	end
    CustomGame.CurrentKnightList = KnightSelection;

    for i= 1, #KnightSelection, 1 do
        XGUIEng.ListBoxPushItem(HeroComboBoxID, XGUIEng.GetStringTableText("Names/" .. KnightSelection[i]));
    end

    local SelectIndex = 0;
    if _TryToKeepSelectedKnight then
        for i= 1, #KnightSelection, 1 do
            if KnightSelection[i] == OldKnightName then
                SelectIndex = i -1;
                break;
            end
        end
    end
    XGUIEng.ListBoxSetSelectedIndex(HeroComboBoxID, SelectIndex);
    CustomGame_OnHeroListBoxSelectionChange();
end

--- @return table
function Lib.MapLoader.Local:GetMapInformation(_Name)
	local MapName, MapDescription, Size, Mode = Framework.GetMapNameAndDescription(_Name, 1);
	if MapName == nil then
		return {};
	end
	return {MapName, MapDescription, Size, Mode};
end

function Lib.MapLoader.Local:OverrideEndscreenDialog()
    local MotherWidget, Text;

	MotherWidget = "/EndScreen/EndScreen";
	XGUIEng.ShowWidget(MotherWidget.. "/BackGround", 0);
	XGUIEng.ShowWidget(MotherWidget.. "/BG", 1);
	XGUIEng.PushPage(MotherWidget, false);
	EndScreen_ExitGame = function() end

	MotherWidget = "/LoadScreen/LoadScreen/ContainerDescription";
	XGUIEng.ShowWidget(MotherWidget, 1);
	XGUIEng.PushPage(MotherWidget, false);

	MotherWidget = "/InGame/InGame/MissionEndScreen";
	XGUIEng.ShowWidget(MotherWidget, 1);
	XGUIEng.PushPage(MotherWidget, false);
	XGUIEng.ShowAllSubWidgets(MotherWidget, 0);
	XGUIEng.ShowWidget(MotherWidget.. "/BG", 0);
	XGUIEng.ShowWidget(MotherWidget.. "/CurrentStatus", 0);
	XGUIEng.ShowWidget(MotherWidget.. "/BGDouble", 1);
	XGUIEng.ShowWidget(MotherWidget.. "/ContinuePlaying", 1);
	XGUIEng.ShowWidget(MotherWidget.. "/Next", 1);

	Text = Localize(Lib.MapLoader.Text.StartMap);
	XGUIEng.SetText(MotherWidget.. "/ContinuePlaying", Text);
	XGUIEng.SetActionFunction(MotherWidget.. "/ContinuePlaying", "ModMapLoader.Local:StartMap()");
	Text = Localize(Lib.MapLoader.Text.Back);
	XGUIEng.SetText(MotherWidget.. "/Next", Text);
	XGUIEng.SetActionFunction(MotherWidget.. "/Next", "Framework.CloseGame()");
end

function Lib.MapLoader.Local:OverrideCustomGameMapSelectionDialog()
    local KnightTypes = {
        "U_KnightTrading",
        "U_KnightHealing",
        "U_KnightChivalry",
        "U_KnightWisdom",
        "U_KnightPlunder",
        "U_KnightSong",
    };
    if g_GameExtraNo > 0 then
        table.insert(KnightTypes, 7, "U_KnightSaraya");
    end
	g_MapAndHeroPreview.KnightTypes = table.copy(KnightTypes);
	CustomGame.KnightTypes = table.copy(KnightTypes);

	-- ---------------------------------------------------------------------- --

	OpenCustomGameDialog = function()
		XGUIEng.ShowWidget("/InGame/Singleplayer/RightMenu", 0)
		XGUIEng.ShowWidget("/InGame/Root/3dOnScreenDisplay", 0)
		XGUIEng.ShowWidget("/InGame/Root/3dWorldView", 0)
		XGUIEng.ShowWidget("/InGame/Root/Normal", 0)
		XGUIEng.ShowAllSubWidgets(CustomGame.Widget.Dialog,1)
		XGUIEng.PushPage(CustomGame.Widget.Dialog, false)
		XGUIEng.PushPage("/InGame/Root/Normal/TextMessages", false)

		XGUIEng.DisableButton("/InGame/Singleplayer/ContainerBottom/StartGame", 0)
		XGUIEng.DisableButton("/InGame/Singleplayer/ContainerBottom/Cancel", 0)
		DisplayLoadBottomButtons(
			"/InGame/Singleplayer/ContainerBottom/StartGame",
			"/InGame/Singleplayer/ContainerBottom/Cancel"
		);
		g_MapAndHeroPreview.ShowMapAndHeroWindows(1)

		CustomGame.Maps = {}

		XGUIEng.ListBoxPopAll(CustomGame.Widget.MapList)
		XGUIEng.ListBoxPopAll(CustomGame.Widget.ClimateZoneList)
		XGUIEng.ListBoxPopAll(CustomGame.Widget.SizeList)
		XGUIEng.ListBoxPopAll(CustomGame.Widget.ModeList)

		local CampaignMaps = Lib.MapLoader.Local.Campaign.MapNames;
		CustomGame_AddMaps(table.copy(CampaignMaps), 1)

		for i = 1 , #CustomGame.Maps do 
			local MapEntry = CustomGame.Maps[i]
			local LocalizedClimateZone = XGUIEng.GetStringTableText("UI_ObjectNames/ClimateZone_" .. Framework.GetMapClimateZone(MapEntry.Name, MapEntry.MapType))
			local map,description,size,mode = Framework.GetMapNameAndDescription(MapEntry.Name, MapEntry.MapType)
			XGUIEng.ListBoxPushItem(CustomGame.Widget.ModeList, mode)
			XGUIEng.ListBoxPushItem(CustomGame.Widget.SizeList, Tool_GetLocalizedSizeString(size))
			XGUIEng.ListBoxPushItem(CustomGame.Widget.ClimateZoneList, LocalizedClimateZone)
			XGUIEng.ListBoxPushItem(CustomGame.Widget.MapList,Tool_GetLocalizedMapName(MapEntry.Name, MapEntry.MapType))
		end

		if #Lib.MapLoader.Local.Campaign.MapNames > 0 then
			CustomGame_SelectMap(0);
			CustomGame_FillHeroComboBox();
		else
			CustomGame_SelectMap(-1);
		end
	end

	CustomGame_SelectMap = function(map)
		if map > -1 then
			XGUIEng.ListBoxSetSelectedIndex(CustomGame.Widget.MapList,map);  
			CustomGame.SelectedMap = CustomGame.Maps[map +1].Name;
			CustomGame.SelectedMapType = CustomGame.Maps[map +1].MapType;
			g_MapAndHeroPreview.SelectMap(CustomGame.SelectedMap, CustomGame.SelectedMapType);
			Lib.MapLoader.Local:SelectMap(map +1);
			CustomGame_FillHeroComboBox(true);
		else
			XGUIEng.ShowWidget("/LoadScreen/LoadScreen/ContainerDescription/LoadScreenReadMe", 0);
			XGUIEng.SetMaterialTexture("/EndScreen/EndScreen/BG", 0, "graphics/textures/gui_1200/loadscreens/throneroom.png");
			XGUIEng.SetMaterialColor("/EndScreen/EndScreen/BG", 0, 255, 255, 255, 255);
		end
	end

	CustomGame_SelectKnight = function(knight)
		CustomGame.Knight = knight;
		g_MapAndHeroPreview.SelectKnight(CustomGame.Knight);
	end

	CustomGame_FillHeroComboBox_Orig_MapLoader = CustomGame_FillHeroComboBox;
	CustomGame_FillHeroComboBox = function(_TryToKeepSelectedKnight)
		Lib.MapLoader.Local:FillHeroComboBox(_TryToKeepSelectedKnight);
	end
end

-- -------------------------------------------------------------------------- --

RegisterModule(Lib.MapLoader.Name);

