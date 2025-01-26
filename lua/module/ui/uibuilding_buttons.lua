Lib.Require("comfort/IsLocalScript");
Lib.Register("module/ui/UIBuilding_Buttons");

-- Global ------------------------------------------------------------------- --

Lib.UIBuilding.Global.ExtraButton = {};

-- -------------------------------------------------------------------------- --

Lib.UIBuilding.Global.ExtraButton.Downgrade = {};

function Lib.UIBuilding.Global.ExtraButton.Downgrade:InitEvents()
    Report.DowngradeBuilding = CreateReport("Event_DowngradeBuilding");
end

function Lib.UIBuilding.Global.ExtraButton.Downgrade:ExtraButtonOnReportReceived(_ID, ...)
    if _ID == Report.DowngradeBuilding then
        self:OnBuildingDowngrade(arg[1]);
    end
end

function Lib.UIBuilding.Global.ExtraButton.Downgrade:OnBuildingDowngrade(_BuildingID)
    local Health = Logic.GetEntityHealth(_BuildingID);
    local MaxHealth = Logic.GetEntityMaxHealth(_BuildingID);
    Logic.HurtEntity(_BuildingID, (Health - (MaxHealth/2)));
end

-- Local -------------------------------------------------------------------- --

Lib.UIBuilding.Local.ExtraButton = {};

-- -------------------------------------------------------------------------- --

Lib.UIBuilding.Local.ExtraButton.Downgrade = {};
Lib.UIBuilding.Local.ExtraButton.Downgrade.Cost = 0;
Lib.UIBuilding.Local.ExtraButton.Downgrade.Bindings = {};
Lib.UIBuilding.Local.ExtraButton.Downgrade.Types = {
    ["B_Bakery"] = true,
    ["B_BannerMaker"] = true,
    ["B_Barracks"] = true,
    ["B_BarracksArchers"] = true,
    ["B_Baths"] = true,
    ["B_Beekeeper"] = true,
    ["B_Blacksmith"] = true,
    ["B_BowMaker"] = true,
    ["B_BroomMaker"] = true,
    ["B_Butcher"] = true,
    ["B_CandleMaker"] = true,
    ["B_Carpenter"] = true,
    ["B_CattleFarm"] = true,
    ["B_Dairy"] = true,
    ["B_FishingHut"] = true,
    ["B_GrainFarm"] = true,
    ["B_HerbGatherer"] = true,
    ["B_HuntersHut"] = true,
    ["B_IronMine"] = true,
    ["B_Pharmacy"] = true,
    ["B_SheepFarm"] = true,
    ["B_SiegeEngineWorkshop"] = true,
    ["B_SmokeHouse"] = true,
    ["B_Soapmaker"] = true,
    ["B_StoneQuarry"] = true,
    ["B_SwordSmith"] = true,
    ["B_Tanner"] = true,
    ["B_Tavern"] = true,
    ["B_Theatre"] = true,
    ["B_Weaver"] = true,
    ["B_Woodcutter"] = true,
};

function Lib.UIBuilding.Local.ExtraButton.Downgrade:InitEvents()
    Report.DowngradeBuilding = CreateReport("Event_DowngradeBuilding");
end

function Lib.UIBuilding.Local.ExtraButton.Downgrade:ExtraButtonOnReportReceived(_ID, ...)
end

function Lib.UIBuilding.Local.ExtraButton.Downgrade:SetCost(_MoneyCost)
    self.Cost = _MoneyCost;
end

function Lib.UIBuilding.Local.ExtraButton.Downgrade:Activate()
    for TypeName, _ in pairs(self.Types) do
        local ID = AddBuildingButtonByTypeAtPosition(
            Entities[TypeName],
            220,
            62,
            self.ButtonAction,
            self.ButtonTooltip,
            self.ButtonUpdate
        );
        self.Bindings[TypeName] = ID;
    end
end

function Lib.UIBuilding.Local.ExtraButton.Downgrade:Deactivate()
    for TypeName, _ in pairs(self.Types) do
        local ID = self.Bindings[TypeName];
        DropBuildingButtonFromType(Entities[TypeName], ID);
    end
end

function Lib.UIBuilding.Local.ExtraButton.Downgrade.ButtonAction(_WidgetID, _BuildingID)
    local CastleID = Logic.GetHeadquarters(GUI.GetPlayerID());
    local Cost = Lib.UIBuilding.Local.ExtraButton.Downgrade.Cost;
    if Cost > 0 and Logic.GetAmountOnOutStockByGoodType(CastleID, Goods.G_Gold) < Cost then
        AddMessage("Feedback_TextLines/TextLine_NotEnough_G_Gold");
        return;
    end
    Sound.FXPlay2DSound("ui\\menu_click");
    if Cost > 0 then
        GUI.RemoveGoodFromStock(CastleID, Goods.G_Gold, Cost);
    end
    GUI.DeselectEntity(_BuildingID);
    SendReportToGlobal(Report.DowngradeBuilding, _BuildingID);
end

function Lib.UIBuilding.Local.ExtraButton.Downgrade.ButtonTooltip(_WidgetID, _BuildingID)
    local Title, Text, Error;
    Title = Lib.UIBuilding.Text.ExtraButton.Downgrade.Normal.Title;
    Text = Lib.UIBuilding.Text.ExtraButton.Downgrade.Normal.Text;
    if XGUIEng.IsButtonDisabled(_WidgetID) == 1 then
        Error = Lib.UIBuilding.Text.ExtraButton.Downgrade.Normal.Error;
        Error = XGUIEng.GetStringTableText(Error);
    end
    local Cost = Lib.UIBuilding.Local.ExtraButton.Downgrade.Cost;
    API.SetTooltipCosts(
        ConvertPlaceholders(Localize(Title)),
        ConvertPlaceholders(Localize(Text)),
        Error,
        (Cost > 0 and {Goods.G_Gold, Cost}) or nil
    );
end

function Lib.UIBuilding.Local.ExtraButton.Downgrade.ButtonUpdate(_WidgetID, _BuildingID)
    if Logic.IsConstructionComplete(_BuildingID) == 0 then
        XGUIEng.ShowWidget(_WidgetID, 0);
        return;
    end
    if Logic.IsBuildingBeingUpgraded(_BuildingID)
    or Logic.IsBuildingBeingKnockedDown(_BuildingID)
    or Logic.IsBurning(_BuildingID)
    or Logic.CanCancelUpgradeBuilding(_BuildingID)
    or Logic.CanCancelKnockDownBuilding(_BuildingID)
    or Logic.GetUpgradeLevel(_BuildingID) < 1 then
        XGUIEng.DisableButton(_WidgetID, 1);
    else
        XGUIEng.DisableButton(_WidgetID, 0);
    end
    SetIcon(_WidgetID, {3, 15});
end

-- -------------------------------------------------------------------------- --

