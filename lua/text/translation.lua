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
};

