-- ========================================================================== --
-- = Translations                                                           = --
-- ========================================================================== --

CONST_TRANSLATION_TEXT_STRINGS = {};

-- German
CONST_TRANSLATION_TEXT_STRINGS.de = {
    Dummy_Test = "Es funktioniert wie gewollt.",
    -- Core
    Core_Dialog_PatchRequired_Title = "Inoffizieller Patch",
    Core_Dialog_PatchRequired_Text = "Um diese Mission zu spielen wird der inoffizielle Patch benötigt.",
    Core_Dialog_PatchRequired_TextVersion = "Es wird mindestens die Version \"%s\" benötigt aber es wurde nur Version \"%s\" gefunden.",
    Core_Quest_ActivateBuff_Pattern = "BONUS AKTIVIEREN{cr}{cr}%s",
    Core_Quest_SoldierCount_Pattern = "SOLDATENANZAHL {cr}Partei: %s{cr}{cr}%s %d",
    Core_Quest_SoldierCount_LowerThan = "Weniger als ",
    Core_Quest_SoldierCount_AtLeast = "Mindestens ",
    Core_Quest_Festivals_Pattern = "FESTE FEIERN {cr}{cr}Partei: %s{cr}{cr}Anzahl: %d",
    Core_Quest_Diplomacy_Pattern = "DIPLOMATIESTATUS ERREICHEN {cr}{cr}Status: %s{cr}Zur Partei: %s",
    -- Quest Behavior
    Quest_QuestBehavior_Reputation_Pattern = "RUF DER STADT{cr}{cr}Hebe den Ruf der Stadt durch weise Herrschaft an!{cr}Benötigter Ruf: %d%s",
    Quest_QuestBehavior_DestroySoldiers_Pattern = "{center}SOLDATEN ZERSTÖREN {cr}{cr}von der Partei: %s{cr}{cr}Anzahl: %d",
    Quest_QuestBehavior_StealGold_Pattern = "Gold von %s stehlen {cr}{cr}Aus Stadtgebäuden zu stehlende Goldmenge: %d",
    Quest_QuestBehavior_StealGold_AnyPlayer = " anderen Spielern ",
    Quest_QuestBehavior_SpyOnBuilding_Pattern = "Gebäude infriltrieren {cr}{cr}Spioniere das markierte Gebäude mit einem Dieb aus!",
    Quest_QuestBehavior_StealFromBuilding_Building = "Gebäude bestehlen {cr}{cr} Sendet einen Dieb und bestehlt das markierte Gebäude.",
    Quest_QuestBehavior_StealFromBuilding_Cistern = "Sabotage {cr}{cr} Sendet einen Dieb und sabotiert den markierten Brunnen.",
    Quest_QuestBehavior_StealFromBuilding_Cathedral = "Sabotage {cr}{cr} Sendet einen Dieb und sabotiert die markierte Kirche.",
    Quest_QuestBehavior_StealFromBuilding_Storehouse = "Lagerhaus bestehlen {cr}{cr} Sendet einen Dieb in das markierte Lagerhaus.",
    -- Quest Jornal
    Quest_QuestJornal_Next = "Tagebuch anzeigen",
    Quest_QuestJornal_Title = "Tagebuch",
    Quest_QuestJornal_Note = "Notiz",
    -- NPC
    Entity_Npc_StartConversation = "Gespräch beginnen",
    -- Entity Selection
    Entity_EntitySelection_Tooltip_KnightButton_Title = "Ritter selektieren",
    Entity_EntitySelection_Tooltip_KnightButton_Text = "- Klick selektiert den Ritter {cr}- Doppelklick springt zum Ritter{cr}- UMSCH halten selektiert alle Ritter",
    Entity_EntitySelection_Tooltip_BattalionButton_Title = "Militär selektieren",
    Entity_EntitySelection_Tooltip_BattalionButton_Text = "- Selektiert alle Einheiten {cr}- UMSCH halten selektiert Militär {cr}- ALT halten selektiert Kriegsmaschinen {cr}- STRG halten selektiert Diebe",
    Entity_EntitySelection_Tooltip_ReleaseSoldiers_Title = "Militär entlassen",
    Entity_EntitySelection_Tooltip_ReleaseSoldiers_Text = "- Eine Militäreinheit entlassen {cr}- Soldaten werden nacheinander entlassen",
    Entity_EntitySelection_Tooltip_ReleaseSoldiers_Disabled = "Kann nicht entlassen werden!",
    Entity_EntitySelection_Tooltip_TrebuchetCart_Title = "Trebuchetwagen",
    Entity_EntitySelection_Tooltip_TrebuchetCart_Text = "- Kann einmalig zum Trebuchet ausgebaut werden",
    Entity_EntitySelection_Tooltip_Trebuchet_Title = "Trebuchet",
    Entity_EntitySelection_Tooltip_Trebuchet_Text = "- Kann über weite Strecken Gebäude angreifen {cr}- Kann Gebäude in Brand stecken {cr}- Trebuchet kann manuell zurückgeschickt werden",
    -- IO
    IO_IoSite_Description_Title = "Gebäude bauen";
    IO_IoSite_Description_Text = "Beauftragt den Bau eines Gebäudes. Ein Siedler wird aus dem Lagerhaus kommen und mit dem Bau beginnen.";
    -- Settlemen tLimitation
    Mode_SettlementLimitation_BuildingLimit_Pattern = "%s%s %d / %d{@color:255,255,255,255}{cr}",
    Mode_SettlementLimitation_BuildingLimit_Info = "Gebäude: ",
    -- Settlement Survival
    Mode_SettlementSurvival_Message_BuildingMourning = "Keine Baumaßnahmen möglich, solange Siedler trauern.",
    Mode_SettlementSurvival_Alarm_AnimalDiedFromIllness = "{scarlet}Eure Nutztiere sterben an Krankheiten!",
    Mode_SettlementSurvival_Alarm_BuildingBurning = "{scarlet}Brände wüten in Eurer Stadt!",
    Mode_SettlementSurvival_Alarm_SettlerTemperature = "{scarlet}Eure Siedler haben kein Feuerholz und frieren!",
    Mode_SettlementSurvival_Alarm_SettlerNegligence = "{scarlet}Eure Siedler verwahrlosen und werden krank!",
    Mode_SettlementSurvival_Alarm_SettlerDiedFromHunger = "{scarlet}Eure Siedler haben nichts zu essen und verhungern!",
    Mode_SettlementSurvival_Alarm_SettlerDiedFromIllness = "{scarlet}Eure Siedler sterben an Krankheiten!",
    -- Warehouse
    Trade_Warehouse_OfferTitle_1 = "Keine Angebote",
    Trade_Warehouse_OfferTitle_2 = "%d %s kaufen%s",
    Trade_Warehouse_OfferTitle_3 = "%s anheuern",
    Trade_Warehouse_OfferTitle_4 = "%s anheuern%s",
    Trade_Warehouse_OfferTitle_5 = "%s kaufen%s",
};

-- English
CONST_TRANSLATION_TEXT_STRINGS.en = {
    Dummy_Test = "Sometimes it just works.",
    -- Core
    Core_Dialog_PatchRequired_Title = "Unofficial Patch",
    Core_Dialog_PatchRequired_Text = "Playing this mission requires the unofficial Patch.",
    Core_Dialog_PatchRequired_TextVersion = "The version \"%s\" is required to play this map but only version \"%s\" was found.",
    Core_Quest_ActivateBuff_Pattern = "ACTIVATE BUFF{cr}{cr}%s",
    Core_Quest_SoldierCount_Pattern = "SOLDIER COUNT {cr}Faction: %s{cr}{cr}%s %d",
    Core_Quest_SoldierCount_LowerThan = "Less than ",
    Core_Quest_SoldierCount_AtLeast = "At least ",
    Core_Quest_Festivals_Pattern = "HOLD PARTIES {cr}{cr}Faction: %s{cr}{cr}Amount: %d",
    Core_Quest_Diplomacy_Pattern = "DIPLOMATIC STATE {cr}{cr}State: %s{cr}To player: %s",
    -- Quest Behavior
    Quest_QuestBehavior_Reputation_Pattern = "CITY REPUTATION{cr}{cr}Raise your reputation by fair rulership!{cr}Needed reputation: %d%s",
    Quest_QuestBehavior_DestroySoldiers_Pattern = "{center}DESTROY SOLDIERS {cr}{cr}from faction: %s{cr}{cr}Amount: %d",
    Quest_QuestBehavior_StealGold_Pattern = "Steal gold from %s {cr}{cr}Amount on gold to steal from city buildings: %d",
    Quest_QuestBehavior_StealGold_AnyPlayer = " different parties ",
    Quest_QuestBehavior_SpyOnBuilding_Pattern = "Infiltrate building {cr}{cr}Spy on the highlighted buildings with a thief!",
    Quest_QuestBehavior_StealFromBuilding_Building = "Steal from building {cr}{cr} Send a thief to steal from the marked building.",
    Quest_QuestBehavior_StealFromBuilding_Cistern = "Sabotage {cr}{cr} Send a thief and break the marked well of the enemy.",
    Quest_QuestBehavior_StealFromBuilding_Cathedral = "Sabotage {cr}{cr} Send a thief to sabotage the marked chapel.",
    Quest_QuestBehavior_StealFromBuilding_Storehouse = "Steal from storehouse {cr}{cr} Steal from the marked storehouse.",
    -- Quest Jornal
    Quest_QuestJornal_Next = "Show Journal",
    Quest_QuestJornal_Title = "Journal",
    Quest_QuestJornal_Note = "Note",
    -- NPC
    Entity_Npc_StartConversation = "Start conversation",
    -- Entity Selection
    Entity_EntitySelection_Tooltip_KnightButton_Title = "Select Knight",
    Entity_EntitySelection_Tooltip_KnightButton_Text = "- Click selects the knight {cr}- Double click jumps to knight{cr}- Press SHIFT to select all knights",
    Entity_EntitySelection_Tooltip_BattalionButton_Title = "Select Units",
    Entity_EntitySelection_Tooltip_BattalionButton_Text = "- Selects all units {cr}- Holding SHIFT selects military {cr}- Holding ALT selects siege engines {cr}- Holding CTRL selects thieves",
    Entity_EntitySelection_Tooltip_ReleaseSoldiers_Title = "Release military unit",
    Entity_EntitySelection_Tooltip_ReleaseSoldiers_Text = "- Dismiss a military unit {cr}- Soldiers will be dismissed each after another",
    Entity_EntitySelection_Tooltip_ReleaseSoldiers_Disabled = "Releasing is impossible!",
    Entity_EntitySelection_Tooltip_TrebuchetCart_Title = "Trebuchet cart",
    Entity_EntitySelection_Tooltip_TrebuchetCart_Text = "- Can uniquely be transmuted into a trebuchet",
    Entity_EntitySelection_Tooltip_Trebuchet_Title = "Trebuchet",
    Entity_EntitySelection_Tooltip_Trebuchet_Text = "- Can perform long range attacks on buildings {cr}- Can set buildings on fire {cr}- The trebuchet can be manually send back to the city",
    -- IO
    IO_IoSite_Description_Title = "Create building";
    IO_IoSite_Description_Text = "Order a building. A worker will come out of the storehouse and erect it.";
    -- Settlemen tLimitation
    Mode_SettlementLimitation_BuildingLimit_Pattern = "%s%s %d / %d{@color:255,255,255,255}{cr}",
    Mode_SettlementLimitation_BuildingLimit_Info = "Buildings: ",
    -- Settlement Survival
    Mode_SettlementSurvival_Message_BuildingMourning = "No construction work possible as long as settlers mourn.",
    Mode_SettlementSurvival_Alarm_AnimalDiedFromIllness = "{scarlet}Your farm animals succumb to the plague!",
    Mode_SettlementSurvival_Alarm_BuildingBurning = "{scarlet}Fires are raging in your city!",
    Mode_SettlementSurvival_Alarm_SettlerTemperature = "{scarlet}Your settlers lack of firewood to warm themselves!",
    Mode_SettlementSurvival_Alarm_SettlerNegligence = "{scarlet}Your settlers are neglected and getting sick!",
    Mode_SettlementSurvival_Alarm_SettlerDiedFromHunger = "{scarlet}Your settlers are starving to death!",
    Mode_SettlementSurvival_Alarm_SettlerDiedFromIllness = "{scarlet}Your settlers succumb to the plague!",
    -- Warehouse
    Trade_Warehouse_OfferTitle_1 = "No Offers",
    Trade_Warehouse_OfferTitle_2 = "Purchase %d %s%s",
    Trade_Warehouse_OfferTitle_3 = "Hire %s",
    Trade_Warehouse_OfferTitle_4 = "Hire %s%s",
    Trade_Warehouse_OfferTitle_5 = "Purchase %s%s",
};

-- French
CONST_TRANSLATION_TEXT_STRINGS.fr = {
    Dummy_Test = "Cela fonctionne comme prévu.",
    -- Core
    Core_Dialog_PatchRequired_Title = "Patch non officiel",
    Core_Dialog_PatchRequired_Text = "Le patch non officiel est requis pour jouer à cette mission.",
    Core_Dialog_PatchRequired_TextVersion = "Au moins la version \"%s\" est requise mais seule la version \"%s\" a été trouvée.",
    Core_Quest_ActivateBuff_Pattern = "ACTIVER BONUS{cr}{cr}%s",
    Core_Quest_SoldierCount_Pattern = "NOMBRE DE SOLDATS {cr}Faction: %s{cr}{cr}%s %d",
    Core_Quest_SoldierCount_LowerThan = "Moins de ",
    Core_Quest_SoldierCount_AtLeast = "Au moins ",
    Core_Quest_Festivals_Pattern = "FESTIVITÉS {cr}{cr}Faction: %s{cr}{cr}Nombre : %d",
    Core_Quest_Diplomacy_Pattern = "ATTEINDRE LE STATUT DE DIPLOMATIQUE {cr}{cr}Statut : %s{cr}Avec la faction : %s",
    -- Quest Behavior
    Quest_QuestBehavior_Reputation_Pattern = "RÉPUTATION DE LA VILLE{cr}{cr} Augmente la réputation de la ville en la gouvernant sagement!{cr}Réputation requise : %d%s",
    Quest_QuestBehavior_DestroySoldiers_Pattern = "{center}DESTRUIRE DES SOLDATS {cr}{cr}de la faction: %s{cr}{cr}Nombre : %d",
    Quest_QuestBehavior_StealGold_Pattern = "Voler l'or de %s {cr}{cr}Quantité d'or à voler dans les bâtiments de la ville : %d",
    Quest_QuestBehavior_StealGold_AnyPlayer = " d'autres joueurs ",
    Quest_QuestBehavior_SpyOnBuilding_Pattern = "Infiltrer un bâtiment {cr}{cr}Espionner le bâtiment marqué avec un voleur!",
    Quest_QuestBehavior_StealFromBuilding_Building = "Voler un bâtiment {cr}{cr} Envoie un voleur et vole le bâtiment marqué.",
    Quest_QuestBehavior_StealFromBuilding_Cistern = "Sabotage {cr}{cr} Envoie un voleur et sabote le puits marqué.",
    Quest_QuestBehavior_StealFromBuilding_Cathedral = "Sabotage {cr}{cr} Envoyez un voleur pour saboter la chapelle marquée.",
    Quest_QuestBehavior_StealFromBuilding_Storehouse = "Voler un entrepôt {cr}{cr} Envoie un voleur dans l'entrepôt marqué.",
    -- Quest Jornal
    Quest_QuestJornal_Next = "Afficher le journal",
    Quest_QuestJornal_Title = "Journal",
    Quest_QuestJornal_Note = "Note",
    -- NPC
    Entity_Npc_StartConversation = "Conversation",
    -- Entity Selection
    Entity_EntitySelection_Tooltip_KnightButton_Title = "Sélectionner le chevalier",
    Entity_EntitySelection_Tooltip_KnightButton_Text = "- Clic sélectionne le chevalier {cr}- Double-clic saute au chevalier{cr}- Maintenir SHIFT sélectionne tous les chevaliers",
    Entity_EntitySelection_Tooltip_BattalionButton_Title = "Sélectionner les unitées",
    Entity_EntitySelection_Tooltip_BattalionButton_Text = "- Sélectionne toutes les unités {cr}- Maintenir SHIFT sélectionne les militaires {cr}- Maintenir ALT sélectionne les machines de guerre {cr}- Maintenir CTRL sélectionne les voleurs",
    Entity_EntitySelection_Tooltip_ReleaseSoldiers_Title = "licencier l'unitées",
    Entity_EntitySelection_Tooltip_ReleaseSoldiers_Text = "- Licencier une unité militaire {cr}- Les soldats sont licenciés les uns après les autres",
    Entity_EntitySelection_Tooltip_ReleaseSoldiers_Disabled = "Ne peut pas être licencié!",
    Entity_EntitySelection_Tooltip_TrebuchetCart_Title = "Chariot à trébuchet",
    Entity_EntitySelection_Tooltip_TrebuchetCart_Text = "- Peut être transformé une seule fois en trébuchet",
    Entity_EntitySelection_Tooltip_Trebuchet_Title = "Trebuchet",
    Entity_EntitySelection_Tooltip_Trebuchet_Text = "- Peut attaquer des bâtiments sur de longues distances {cr}- Peut mettre le feu à des bâtiments {cr}- Le trébuchet peut être renvoyé manuellement",
    -- IO
    IO_IoSite_Description_Title = "Construire le bâtiment";
    IO_IoSite_Description_Text = "Commande la construction d'un bâtiment. Un Settler sortira de l'entrepôt et commencera la construction.";
    -- Settlemen tLimitation
    Mode_SettlementLimitation_BuildingLimit_Pattern = "%s%s %d / %d{@color:255,255,255,255}{cr}",
    Mode_SettlementLimitation_BuildingLimit_Info = "Imeuble: ",
    -- Settlement Survival
    Mode_SettlementSurvival_Message_BuildingMourning = "Aucun travail de construction possible tant que les colons pleurent.",
    Mode_SettlementSurvival_Alarm_AnimalDiedFromIllness = "{scarlet}Vos animaux de ferme succombent à la peste!",
    Mode_SettlementSurvival_Alarm_BuildingBurning = "{scarlet}Les incendies font rage dans votre ville!",
    Mode_SettlementSurvival_Alarm_SettlerTemperature = "{scarlet}Vos colons manquent de bois de chauffage pour se réchauffer!",
    Mode_SettlementSurvival_Alarm_SettlerNegligence = "{scarlet}Vos colons sont négligés et tombent malades!",
    Mode_SettlementSurvival_Alarm_SettlerDiedFromHunger = "{scarlet}Vos colons meurent de faim!",
    Mode_SettlementSurvival_Alarm_SettlerDiedFromIllness = "{scarlet}Vos colons succombent à la peste!",
    -- Warehouse
    Trade_Warehouse_OfferTitle_1 = "Pas d'offres",
    Trade_Warehouse_OfferTitle_2 = "Achat %d %s%s",
    Trade_Warehouse_OfferTitle_3 = "Embaucher %s",
    Trade_Warehouse_OfferTitle_4 = "Embaucher %s%s",
    Trade_Warehouse_OfferTitle_5 = "Achat %s%s",
};

