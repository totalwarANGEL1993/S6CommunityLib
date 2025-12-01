Lib.EvilHeroes = Lib.EvilHeroes or {};
Lib.EvilHeroes.Name = "EvilHeroes";
Lib.EvilHeroes.Global = {};
Lib.EvilHeroes.Local  = {};
Lib.EvilHeroes.Shared = {};

Lib.Require("core/Core");
Lib.Require("module/mode/EvilHeroes_API");
Lib.Require("module/mode/EvilHeroes_Config");
Lib.Register("module/mode/EvilHeroes");

-- -------------------------------------------------------------------------- --
-- Global

-- Global initalizer method
function Lib.EvilHeroes.Global:Initialize()
    if not self.IsInstalled then
        Report.CustomKnightAbilityUsed = CreateReport("Event_CustomKnightAbility");

        -- Garbage collection
        Lib.EvilHeroes.Local = nil;
    end
    self.IsInstalled = true;
end

-- Global load game
function Lib.EvilHeroes.Global:OnSaveGameLoaded()
end

-- Global report listener
function Lib.EvilHeroes.Global:OnReportReceived(_ID, ...)
    if _ID == Report.LoadingFinished then
        self.LoadscreenClosed = true;
    end
end

-- -------------------------------------------------------------------------- --
-- Local

-- Local initalizer method
function Lib.EvilHeroes.Local:Initialize()
    if not self.IsInstalled then
        Report.CustomKnightAbilityUsed = CreateReport("Event_CustomKnightAbility");

        self:OverrideConstants();
        self:OverrideAbilityButton();
        self:OverrideInteraction();
        self:OverrideMethods();

        -- Garbage collection
        Lib.EvilHeroes.Global = nil;
    end
    self.IsInstalled = true;
end

-- Local load game
function Lib.EvilHeroes.Local:OnSaveGameLoaded()
end

-- Local report listener
function Lib.EvilHeroes.Local:OnReportReceived(_ID, ...)
    if _ID == Report.LoadingFinished then
        self.LoadscreenClosed = true;
    end
end

function Lib.EvilHeroes.Local:SetKnightAbilityAction()
    return false;
end

function Lib.EvilHeroes.Local.SetKnightAbilityTooltip()
    return false;
end

function Lib.EvilHeroes.Local:SetKnightAbilityUpdate()
    return false;
end

function Lib.EvilHeroes.Local:SetKnightAbilityProgressUpdate()
    return false;
end

function Lib.EvilHeroes.Local:OverrideConstants()
    g_MilitaryFeedback.Knights[Entities.U_KnightSabatta]	  = "H_Knight_Sabatt";
    g_HeroAbilityFeedback.Knights[Entities.U_KnightSabatta]   = "Sabatta";
    g_MilitaryFeedback.Knights[Entities.U_KnightRedPrince]    = "H_Knight_RedPrince";
    g_HeroAbilityFeedback.Knights[Entities.U_KnightRedPrince] = "RedPrince";
end

function Lib.EvilHeroes.Local:OverrideAbilityButton()
    self.Orig_GUI_Knight_AbilityProgressUpdate = GUI_Knight.AbilityProgressUpdate;
    GUI_Knight.AbilityProgressUpdate = function()
        if not Lib.EvilHeroes.Local:SetKnightAbilityProgressUpdate() then
            Lib.EvilHeroes.Local.Orig_GUI_Knight_AbilityProgressUpdate();
        end
    end

    self.Orig_GUI_Knight_StartAbilityUpdate = GUI_Knight.StartAbilityUpdate;
    GUI_Knight.StartAbilityUpdate = function()
        if not Lib.EvilHeroes.Local:SetKnightAbilityUpdate() then
            Lib.EvilHeroes.Local.Orig_GUI_Knight_StartAbilityUpdate();
        end
    end

    self.Orig_GUI_Knight_StartAbilityMouseOver = GUI_Knight.StartAbilityMouseOver;
    GUI_Knight.StartAbilityMouseOver = function()
        if not Lib.EvilHeroes.Local:SetKnightAbilityTooltip() then
            Lib.EvilHeroes.Local.Orig_GUI_Knight_StartAbilityMouseOver();
        end
    end

    self.Orig_GUI_Knight_StartAbilityClicked = GUI_Knight.StartAbilityClicked;
    GUI_Knight.StartAbilityClicked = function()
        if not Lib.EvilHeroes.Local:SetKnightAbilityAction() then
            Lib.EvilHeroes.Local.Orig_GUI_Knight_StartAbilityClicked();
        end
    end
end

function Lib.EvilHeroes.Local:OverrideInteraction()
    GUI_BuildingButtons.UpgradeClicked_Legacy_EvilHero = GUI_BuildingButtons.UpgradeClicked;
    self.Orig_GUI_BuildingButtons_UpgradeClicked = function()
        if not Lib.EvilHeroes.Local:RedPrinceUpgradeBuildingClicked() then
            Lib.EvilHeroes.Local.Orig_GUI_BuildingButtons_UpgradeClicked();
        end
    end

    GUI_Merchant.OfferClicked_Legacy_EvilHero = GUI_Merchant.OfferClicked;
    self.Orig_GUI_Merchant_OfferClicked = function(_ButtonIndex)
        Lib.EvilHeroes.Local.Orig_GUI_Merchant_OfferClicked(_ButtonIndex);
        Lib.EvilHeroes.Local:ShowSabattPassiveAbilityInformation(_ButtonIndex);
    end

    -- Show info for Sabatt passive ability
    self.Orig_GameCallback_Feedback_EntityHurt = GameCallback_Feedback_EntityHurt;
    GameCallback_Feedback_EntityHurt = function(_HurtPlayerID, _HurtEntityID, _HurtingPlayerID, _HurtingEntityID, _DamageReceived, _DamageDealt)
        Lib.EvilHeroes.Local.Orig_GameCallback_Feedback_EntityHurt(_HurtPlayerID, _HurtEntityID, _HurtingPlayerID, _HurtingEntityID, _DamageReceived, _DamageDealt);
        Lib.EvilHeroes.Local:ShowSabattActiveAbilityInformation(_HurtPlayerID, _HurtEntityID, _HurtingPlayerID, _HurtingEntityID, _DamageReceived, _DamageDealt);
    end

    -- Show info for RP passive ability
    -- Trigger RP passive ability
    self.Orig_GameCallback_Feedback_TaxCollectionFinished = GameCallback_Feedback_TaxCollectionFinished;
    GameCallback_Feedback_TaxCollectionFinished = function(_PlayerID, _TaxCollected, _SkillBonus)
        if Lib.EvilHeroes.Local:ShowRPPassiveAbilityInformation(_PlayerID, _TaxCollected, _SkillBonus) then
            Lib.EvilHeroes.Local.Orig_GameCallback_Feedback_TaxCollectionFinished(_PlayerID, _TaxCollected, _SkillBonus);
            return;
        end
        Lib.EvilHeroes.Local:RPPassiveAbilityTriggered(_PlayerID, _TaxCollected, _SkillBonus);
    end
end

function Lib.EvilHeroes.Local:RedPrinceUpgradeBuildingClicked()
    return false;
end

function Lib.EvilHeroes.Local:RPPassiveAbilityTriggered(_PlayerID, _TotalTaxAmountCollected, _AdditionalTaxesByAbility)
    local KnightID = Logic.GetKnightID(_PlayerID);
    if Logic.GetEntityType(KnightID) == Entities.U_KnightRedPrince then
        if Logic.GetHeadquarters(_PlayerID) > 0 then
            if _TotalTaxAmountCollected > 0 then
                -- TODO: put that somewhere else!!!
                -- TODO: Gold event
                -- local BonusOnTax = math.ceil(_TotalTaxAmountCollected * 0.2);
                -- if _PlayerID == GUI.GetPlayerID() and Logic.GetCurrentTurn() > 10 then
                --     GUI_FeedbackWidgets.GoldAdd(BonusOnTax, nil, {6,8});
                -- end
            end
        end
        return true;
    end
end

function Lib.EvilHeroes.Local:OverrideMethods()
end

function Lib.EvilHeroes.Local:ShowSabattActiveAbilityInformation(_HurtPlayerID, _HurtEntityID, _HurtingPlayerID, _HurtingEntityID, _DamageReceived, _DamageDealt)
    if Logic.GetEntityType(_HurtingEntityID) == Entities.U_KnightSabatta then
        if _HurtPlayerID > 0 then
            StartKnightVoiceForActionSpecialAbility(Entities.U_KnightSabatta);
        end
    end
end

function Lib.EvilHeroes.Local:ShowSabattPassiveAbilityInformation(_ButtonIndex)
    local KnightID = Logic.GetKnightID(GUI.GetPlayerID());
    if Logic.GetEntityType(KnightID) == Entities.U_KnightSabatta then
        StartKnightVoiceForPermanentSpecialAbility(Entities.U_KnightSabatt);
        return true;
    end
end

function Lib.EvilHeroes.Local:ShowRPPassiveAbilityInformation(_PlayerID, _TotalTaxAmountCollected, _AdditionalTaxesByAbility)
    local KnightID = Logic.GetKnightID(_PlayerID);
    if Logic.GetEntityType(KnightID) == Entities.U_KnightRedPrince then
        if Logic.GetHeadquarters(_PlayerID) > 0 then
            if _TotalTaxAmountCollected > 0 then
                StartKnightVoiceForPermanentSpecialAbility(Entities.U_KnightRedPrince);
            end
        end
        return true;
    end
end

-- -------------------------------------------------------------------------- --
-- Shared



-- -------------------------------------------------------------------------- --

RegisterModule(Lib.EvilHeroes.Name);

