--- Ermöglicht die Steuerung einer Kampagnenkarte.
--- 
--- Jede Karte der Kampagne muss eine Datei `maploader.lua` enthalten. Die Datei
--- konfiguriert die Karte und ist wie folgt aufgebaut:
--- 
--- ```lua
--- LocalMapData = {
---     -- Codewort, das im Profil stehen muss
---     MapCode = "a5b7c8",
---     -- Splashscreen anzeigen (splashscreen.png)
---     Splashscreen = true,
---     -- Benötigte Version des Loader
---     LoaderVersion = 1,
---     -- Auswählbare Helden
---     PossibleKnights = {
---         "U_KnightTrading",
---         "U_KnightHealing",
---         "U_KnightChivalry",
---         "U_KnightWisdom",
---         "U_KnightPlunder",
---         "U_KnightSong",
---         "U_KnightSaraya",
---     },
---     -- Benötigte Maps (max. 5)
---     RequiredMaps = {
---         "examplecampaign_examplemap1",
---         "examplecampaign_examplemap2",
---     },
--- };
--- ```
---
Lib.MapLoaderMap = Lib.MapLoaderMap or {};

--- Speichert im Profil, dass die aktuelle Map gewonnen wurde.
function CampaignMap_SetFinished()
end
API.CampaignMap_SetFinished = CampaignMap_SetFinished;

--- Fügt einen Schlüssel hinzu, der im Profil gespeichert werden soll.
--- @param _Key string Schlüssel
--- @param _Value string Wert
function CampaignMap_AddValue(_Key, _Value)
end
API.CampaignMap_AddValue = CampaignMap_AddValue;

--- Gibt den Wert zum Schlüssel zurück.
--- @param _Key string Schlüssel
--- @return string Wert Wert zum Schlüssel
function CampaignMap_GetValue(_Key)
	return "";
end
API.CampaignMap_GetValue = CampaignMap_GetValue;

--- Entfernt einen Schlüssel aus dem Profil.
--- @param _Key string Schlüssel
function CampaignMap_RemoveValue(_Key)
end
API.CampaignMap_RemoveValue = CampaignMap_RemoveValue;

--- Läd alle vorgemerkten Schlüssel aus dem Profil.
function CampaignMap_LoadValues()
end
API.CampaignMap_LoadValues = CampaignMap_LoadValues;

--- Speichert alle vorgemerkten Schlüssel im Profil.
function CampaignMap_SaveValues()
end
API.CampaignMap_SaveValues = CampaignMap_SaveValues;

