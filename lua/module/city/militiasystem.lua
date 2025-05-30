Lib.MilitiaSystem = Lib.MilitiaSystem or {};
Lib.MilitiaSystem.Name = "MilitiaSystem";
Lib.MilitiaSystem.Global = {
    MilitiaAllocation = {},
    TypeSkills = {},
};
Lib.MilitiaSystem.Local  = {
    MilitiaAllocation = {},
    TypeSkills = {},
};
Lib.MilitiaSystem.Shared = {};

Lib.Require("comfort/GetBattalionSizeBySoldierType");
Lib.Require("core/Core");
Lib.Require("module/balancing/Damage");
Lib.Require("module/faker/Permadeath");
Lib.Require("module/faker/Technology");
Lib.Require("module/ui/UIBuilding");
Lib.Require("module/city/MilitiaSystem_API");
Lib.Require("module/city/MilitiaSystem_Config");
Lib.Require("module/city/MilitiaSystem_Text");
Lib.Register("module/city/MilitiaSystem");

-- -------------------------------------------------------------------------- --
-- Global

-- Global initalizer method
function Lib.MilitiaSystem.Global:Initialize()
    if not self.IsInstalled then
        Report.BuyMilitia = CreateReport("Event_BuyMilitia");

        Lib.MilitiaSystem.Shared:CreateTechnologies();

        self:InitDamageCalculationCallback();
        self:InitUnitTypeSkills();

        for PlayerID = 1, 8 do
            self:SetDefaultUnitTypeAllocation(PlayerID);
        end

        -- Garbage collection
        Lib.MilitiaSystem.Local = nil;
    end
    self.IsInstalled = true;
end

-- Global load game
function Lib.MilitiaSystem.Global:OnSaveGameLoaded()
end

-- Global report listener
function Lib.MilitiaSystem.Global:OnReportReceived(_ID, ...)
    if _ID == Report.LoadingFinished then
        self.LoadscreenClosed = true;
    elseif _ID == Report.BuyMilitia then
        self:BuyMilitia(arg[1], arg[2]);
    end
end

-- -------------------------------------------------------------------------- --

function Lib.MilitiaSystem.Global:BuyMilitia(_PlayerID, _Type)
    -- Check space
    local MilitaryUsage = Logic.GetCurrentSoldierCount(_PlayerID);
    local MilitaryLimit = Logic.GetCurrentSoldierLimit(_PlayerID);
    if GetBattalionSizeBySoldierType(_Type) >= MilitaryLimit - MilitaryUsage then
        return false;
    end
    -- Check costs
    local UnitTypeName = Logic.GetEntityTypeName(_Type);
    local Costs = Lib.MilitiaSystem.Config.UnitCosts[UnitTypeName];
    if (Costs[1] and GetPlayerResources(Costs[1], _PlayerID) < Costs[2])
    or (Costs[3] and GetPlayerResources(Costs[3], _PlayerID) < Costs[4]) then
        return false;
    end
    -- Check castle
    local CastleID = Logic.GetHeadquarters(_PlayerID);
    if CastleID == 0 then
        return false;
    end
    -- TODO: check recruits (suspend settlers)

    -- Create unit
    local x, y = Logic.GetBuildingApproachPosition(CastleID);
    local Orientation = Logic.GetEntityOrientation(CastleID);
    Logic.CreateBattalion(_Type, x, y, Orientation - 90, _PlayerID);
    if Costs[1] then AddGood(Costs[1], (-1) * Costs[2], _PlayerID); end
    if Costs[3] then AddGood(Costs[3], (-1) * Costs[4], _PlayerID); end
    -- TODO: suspend settlers
end

-- -------------------------------------------------------------------------- --

function Lib.MilitiaSystem.Global:SetDefaultUnitTypeAllocation(_PlayerID)
    local Melee, Ranged = self:GetDefaultMilitiaUnitTypes();
    ExecuteLocal("Lib.MilitiaSystem.Local.MilitiaAllocation[%d] = {%d, %d}", _PlayerID, Melee, Ranged);
    self.MilitiaAllocation[_PlayerID] = {Melee, Ranged};
end

function Lib.MilitiaSystem.Global:SetRandomUnitTypeAllocation(_PlayerID)
    local Melee, Ranged = self:GetRandomMilitiaUnitTypes(_PlayerID);
    ExecuteLocal("Lib.MilitiaSystem.Local.MilitiaAllocation[%d] = {%d, %d}", _PlayerID, Melee, Ranged);
    self.MilitiaAllocation[_PlayerID] = {Melee, Ranged};
end

function Lib.MilitiaSystem.Global:GetRandomMilitiaUnitTypes(_PlayerID)
    return Lib.MilitiaSystem.Shared:GetRandomMilitiaUnitTypes(_PlayerID, self.MilitiaAllocation);
end

function Lib.MilitiaSystem.Global:GetDefaultMilitiaUnitTypes()
    return Lib.MilitiaSystem.Shared:GetDefaultMilitiaUnitTypes();
end

function Lib.MilitiaSystem.Global:SetRequiredRank(_Title, _Tech)
    ExecuteLocal(string.format([[
        table.insert(NeedsAndRightsByKnightTitle[%d][4], 1, %d)
        CreateTechnologyKnightTitleTable()
    ]], _Title, _Tech));
    table.insert(NeedsAndRightsByKnightTitle[_Title][4], 1, _Tech);
    CreateTechnologyKnightTitleTable();
    for playerID = 1, 8 do
        Logic.TechnologySetState(playerID, _Tech, 0);
    end
end

-- -------------------------------------------------------------------------- --

function Lib.MilitiaSystem.Global:InitUnitTypeSkills()
    self.TypeSkills["U_MilitaryBandit_Melee_AS"] = MilitiaSkill.Execution;
    self.TypeSkills["U_MilitaryBandit_Ranged_AS"] = MilitiaSkill.Critical;
    self.TypeSkills["U_MilitaryBandit_Melee_ME"] = MilitiaSkill.Concussion;
    self.TypeSkills["U_MilitaryBandit_Ranged_ME"] = MilitiaSkill.BraveStand;
    self.TypeSkills["U_MilitaryBandit_Melee_NA"] = MilitiaSkill.BraveStand;
    self.TypeSkills["U_MilitaryBandit_Ranged_NA"] = MilitiaSkill.Doge;
    self.TypeSkills["U_MilitaryBandit_Melee_NE"] = MilitiaSkill.Bleeding;
    self.TypeSkills["U_MilitaryBandit_Ranged_NE"] = MilitiaSkill.Bleeding;
    self.TypeSkills["U_MilitaryBandit_Melee_SE"] = MilitiaSkill.Doge;
    self.TypeSkills["U_MilitaryBandit_Ranged_SE"] = MilitiaSkill.Critical;
end

function Lib.MilitiaSystem.Global:GetUnitTypeSkill(_Entity)
    local ID = GetID(_Entity)
    local Type = Logic.GetEntityType(ID);
    local TypeName = Logic.GetEntityTypeName(Type);
    return self.TypeSkills[TypeName];
end

function Lib.MilitiaSystem.Global:InitDamageCalculationCallback()
    GameCallback_Lib_CalculateBattleDamage = function(_AttackerID, _AttackerPlayer, _TargetID, _TargetPlayer, _Damage)
        return Lib.MilitiaSystem.Global:CalculateBattleDamage(_AttackerID, _TargetID, _Damage);
    end
end

function Lib.MilitiaSystem.Global:CalculateBattleDamage(_AttackerID, _TargetID, _Damage)
    local Damage = _Damage;
    local AttackerSkill = self:GetUnitTypeSkill(_AttackerID);
    if AttackerSkill then
        Damage = AttackerSkill:InvokeSkill(_AttackerID, _AttackerID, _TargetID, _Damage);
    end
    local TargetSkill = self:GetUnitTypeSkill(_AttackerID);
    if TargetSkill then
        Damage = TargetSkill:InvokeSkill(_TargetID, _AttackerID, _TargetID, _Damage);
    end
    return Damage;
end

-- -------------------------------------------------------------------------- --
-- Local

-- Local initalizer method
function Lib.MilitiaSystem.Local:Initialize()
    if not self.IsInstalled then
        Report.BuyMilitia = CreateReport("Event_BuyMilitia");

        Lib.MilitiaSystem.Shared:CreateTechnologies();

        self:InitUnitTypeSkills();

        self:InitMilitiaButtons(Entities.B_Castle_ME);
        self:InitMilitiaButtons(Entities.B_Castle_NA);
        self:InitMilitiaButtons(Entities.B_Castle_NE);
        self:InitMilitiaButtons(Entities.B_Castle_SE);
        if Entities.B_Castle_AS ~= nil then
            self:InitMilitiaButtons(Entities.B_Castle_AS);
        end

        for k, v in pairs(Lib.MilitiaSystem.Text.Unit) do
            AddStringText("UI_ObjectNames/" ..k, v.Title);
            AddStringText("UI_ObjectDescription/Abilities_" ..k, v.Text);
        end

        -- Garbage collection
        Lib.MilitiaSystem.Global = nil;
    end
    self.IsInstalled = true;
end

-- Local load game
function Lib.MilitiaSystem.Local:OnSaveGameLoaded()
end

-- Local report listener
function Lib.MilitiaSystem.Local:OnReportReceived(_ID, ...)
    if _ID == Report.LoadingFinished then
        self.LoadscreenClosed = true;
    end
end

-- -------------------------------------------------------------------------- --

function Lib.MilitiaSystem.Local:InitUnitTypeSkills()
    self.TypeSkills["U_MilitaryBandit_Melee_AS"] = MilitiaSkill.Execution;
    self.TypeSkills["U_MilitaryBandit_Ranged_AS"] = MilitiaSkill.Critical;
    self.TypeSkills["U_MilitaryBandit_Melee_ME"] = MilitiaSkill.Concussion;
    self.TypeSkills["U_MilitaryBandit_Ranged_ME"] = MilitiaSkill.BraveStand;
    self.TypeSkills["U_MilitaryBandit_Melee_NA"] = MilitiaSkill.BraveStand;
    self.TypeSkills["U_MilitaryBandit_Ranged_NA"] = MilitiaSkill.Doge;
    self.TypeSkills["U_MilitaryBandit_Melee_NE"] = MilitiaSkill.Bleeding;
    self.TypeSkills["U_MilitaryBandit_Ranged_NE"] = MilitiaSkill.Bleeding;
    self.TypeSkills["U_MilitaryBandit_Melee_SE"] = MilitiaSkill.Doge;
    self.TypeSkills["U_MilitaryBandit_Ranged_SE"] = MilitiaSkill.Critical;
end

function Lib.MilitiaSystem.Local:GetUnitTypeSkill(_Entity)
    local ID = GetID(_Entity)
    local Type = Logic.GetEntityType(ID);
    local TypeName = Logic.GetEntityTypeName(Type);
    return self.TypeSkills[TypeName];
end

-- -------------------------------------------------------------------------- --

function Lib.MilitiaSystem.Local:InitMilitiaButtons(_Type)
    -- Button 1
    AddBuildingButtonByEntity(
        _Type,
        function(_WidgetID, _EntityID) Lib.MilitiaSystem.Local:CastleMilitiaButtonAction(1, _WidgetID, _EntityID) end,
        function(_WidgetID, _EntityID) Lib.MilitiaSystem.Local:CastleMilitiaButtonTooltip(1, _WidgetID, _EntityID) end,
        function(_WidgetID, _EntityID) Lib.MilitiaSystem.Local:CastleMilitiaButtonUpdate(1, _WidgetID, _EntityID) end
    );
    -- Button 2
    AddBuildingButtonByEntity(
        _Type,
        function(_WidgetID, _EntityID) Lib.MilitiaSystem.Local:CastleMilitiaButtonAction(2, _WidgetID, _EntityID) end,
        function(_WidgetID, _EntityID) Lib.MilitiaSystem.Local:CastleMilitiaButtonTooltip(2, _WidgetID, _EntityID) end,
        function(_WidgetID, _EntityID) Lib.MilitiaSystem.Local:CastleMilitiaButtonUpdate(2, _WidgetID, _EntityID) end
    );
end

function Lib.MilitiaSystem.Local:CastleMilitiaButtonAction(_Index, _WidgetID, _EntityID)
    local PlayerID = Logic.EntityGetPlayer(_EntityID);
    local UnitType = Lib.MilitiaSystem.Local.MilitiaAllocation[PlayerID][_Index];
    local UnitTypeName = Logic.GetEntityTypeName(UnitType);
    local Costs = Lib.MilitiaSystem.Config.UnitCosts[UnitTypeName];
    local MilitaryLimit = Logic.GetCurrentSoldierLimit(PlayerID);
    local MilitaryUsage = Logic.GetCurrentSoldierCount(PlayerID);
    if GetBattalionSizeBySoldierType(UnitType) >= MilitaryLimit - MilitaryUsage then
        AddMessage("Feedback_TextLines/TextLine_SoldierLimitReached");
        return;
    end
    if (Costs[1] and GetPlayerResources(Costs[1], PlayerID) < Costs[2])
    or (Costs[3] and GetPlayerResources(Costs[3], PlayerID) < Costs[4]) then
        return;
    end
    SendReportToGlobal(Report.BuyMilitia, PlayerID, UnitType);
end

function Lib.MilitiaSystem.Local:CastleMilitiaButtonTooltip(_Index, _WidgetID, _EntityID)
    local PlayerID = Logic.EntityGetPlayer(_EntityID);
    local UnitType = Lib.MilitiaSystem.Local.MilitiaAllocation[PlayerID][_Index];
    local UnitTypeName = Logic.GetEntityTypeName(UnitType);
    local Costs = Lib.MilitiaSystem.Config.UnitCosts[UnitTypeName];
    local Data = Lib.MilitiaSystem.Config.UnitData[UnitTypeName];
    local Title = self:GetUnitScreenName(UnitType);
    local Text = self:GetUnitScreenDescription(UnitType);
    local DisabledKey = GUI_Tooltip.GetDisabledKeyForTechnologyType(Technologies[Data[2]]);
    if DisabledKey and XGUIEng.IsButtonDisabled(_WidgetID) == 1 then
        local DisabledText = GetStringText("UI_ButtonDisabled/" ..DisabledKey);
        Text = Text.. "{cr}{@color:210,20,30,255}" ..DisabledText;
    end
    SetTooltipCosts(Title, Text, nil, Costs, true);
end

function Lib.MilitiaSystem.Local:CastleMilitiaButtonUpdate(_Index, _WidgetID, _EntityID)
    local PlayerID = Logic.EntityGetPlayer(_EntityID);
    local UnitType = Lib.MilitiaSystem.Local.MilitiaAllocation[PlayerID][_Index];
    local UnitTypeName = Logic.GetEntityTypeName(UnitType);
    local Data = Lib.MilitiaSystem.Config.UnitData[UnitTypeName];
    ChangeIcon(_WidgetID, Data[3]);
    if Logic.TechnologyGetState(PlayerID, Technologies[Data[1]]) ~= TechnologyStates.Researched
    or Logic.TechnologyGetState(PlayerID, Technologies[Data[2]]) ~= TechnologyStates.Researched then
        XGUIEng.DisableButton(_WidgetID, 1);
    else
        XGUIEng.DisableButton(_WidgetID, 0);
    end
end

-- -------------------------------------------------------------------------- --

function Lib.MilitiaSystem.Local:GetUnitScreenName(_Type)
    local TypeName = Logic.GetEntityTypeName(_Type);
    return GetStringText("UI_ObjectNames/" ..TypeName);
end

function Lib.MilitiaSystem.Local:GetUnitScreenDescription(_Type)
    local TypeName = Logic.GetEntityTypeName(_Type);
    local Text = GetStringText("UI_ObjectDescription/Abilities_" ..TypeName);
    if self.TypeSkills[TypeName] then
        local SkillName = self.TypeSkills[TypeName].Name;
        local SkillText = Lib.MilitiaSystem.Text.Skills[SkillName];
        Text = Text.. "{cr}" .. Localize(SkillText);
    end
    return Text;
end

function Lib.MilitiaSystem.Local:GetRandomMilitiaUnitTypes(_PlayerID)
    return Lib.MilitiaSystem.Shared:GetRandomMilitiaUnitTypes(_PlayerID, self.MilitiaAllocation);
end

function Lib.MilitiaSystem.Local:GetDefaultMilitiaUnitTypes()
    return Lib.MilitiaSystem.Shared:GetDefaultMilitiaUnitTypes();
end

-- -------------------------------------------------------------------------- --
-- Shared

function Lib.MilitiaSystem.Shared:GetDefaultMilitiaUnitTypes()
    local MapName = Framework.GetCurrentMapName();
    local MapType, Campaign = Framework.GetCurrentMapTypeAndCampaignName();
    local ClimateZone = Framework.GetMapClimateZone(MapName, MapType, Campaign);

    if ClimateZone == "NorthEurope" then
        return Entities.U_MilitaryBandit_Melee_NE, Entities.U_MilitaryBandit_Ranged_NE;
    elseif ClimateZone == "SouthEurope" then
        return Entities.U_MilitaryBandit_Melee_SE, Entities.U_MilitaryBandit_Ranged_SE;
    elseif ClimateZone == "NorthAfrica" then
        return Entities.U_MilitaryBandit_Melee_NA, Entities.U_MilitaryBandit_Ranged_NA;
    elseif ClimateZone == "Asia" then
        return Entities.U_MilitaryBandit_Melee_AS, Entities.U_MilitaryBandit_Ranged_AS;
    end
    return Entities.U_MilitaryBandit_Melee_ME, Entities.U_MilitaryBandit_Ranged_ME;
end

function Lib.MilitiaSystem.Shared:GetRandomMilitiaUnitTypes(_PlayerID, _Allocation)
    local MeleeList, RangedList = {}, {};
    -- Get types allowed for player
    for Type, Data in pairs(Lib.MilitiaSystem.Config.UnitData) do
        if Entities[Type] and Logic.IsEntityTypeInCategory(Entities[Type], EntityCategories.Melee) == 1 then
            if  Logic.TechnologyGetState(_PlayerID, Technologies[Data[1]]) == TechnologyStates.Researched
            and Logic.TechnologyGetState(_PlayerID, Technologies[Data[2]]) == TechnologyStates.Researched then
                table.insert(MeleeList, Entities[Type]);
            end
        end
        if Entities[Type] and Logic.IsEntityTypeInCategory(Entities[Type], EntityCategories.Range) == 1 then
            if  Logic.TechnologyGetState(_PlayerID, Technologies[Data[1]]) == TechnologyStates.Researched
            and Logic.TechnologyGetState(_PlayerID, Technologies[Data[2]]) == TechnologyStates.Researched then
                table.insert(RangedList, Entities[Type]);
            end
        end
    end
    -- Select a random type, if more than one type available, that is not
    -- the currently allocated type
    if #MeleeList > 1 and #RangedList > 1 then
        local Melee, Ranged;
        repeat
            Melee = MeleeList[math.random(1, #MeleeList)];
        until (Melee ~= _Allocation[_PlayerID][1]);
        repeat
            Ranged = MeleeList[math.random(1, #MeleeList)];
        until (Ranged ~= _Allocation[_PlayerID][2]);
        return Melee, Ranged;
    -- Return default types otherwise
    else
        return self:GetDefaultMilitiaUnitTypes();
    end
end

function Lib.MilitiaSystem.Shared:CreateTechnologies()
    for i= 1, #Lib.MilitiaSystem.Config.Technology do
        local Technology = Lib.MilitiaSystem.Config.Technology[i];
        if g_GameExtraNo >= Technology[4] then
            if not Technologies[Technology[1]] then
                AddCustomTechnology(Technology[1],Technology[2],Technology[3]);
                if not IsLocalScript() then
                    for j= 1, 8 do
                        Logic.TechnologySetState(j, Technologies[Technology[1]], 3);
                    end
                end
            end
        end
    end
end

-- -------------------------------------------------------------------------- --

RegisterModule(Lib.MilitiaSystem.Name);

