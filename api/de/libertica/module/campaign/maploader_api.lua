--- Ermöglicht das erstellen einer dynamischen Kampagne.
---
--- Die einzelnen Karten der Kampagne können sofort ausgeliefert werden, oder
--- Stück für Stück in Raten, da das System die Karten auch findet, wenn sie
--- erst später dem Mapverzeichnis hinzugefügt werden.
---
--- Funktionen:
--- * Erstellen einer Kampagne aus mehreren Maps
--- * Karten können nur gestartet werden, wenn ihre Vorgänger gewonnen sind
--- * Missionen werden in einer Liste beim Start der Hauptkarte angezeigt
--- * Missionen können auch erst später veröffentlich werden
--- * Missionen können individuelle Hintergründe haben
---
Lib.MapLoader = Lib.MapLoader or {};

--- Setzt den Präfix der Kampagne.
--- 
--- Der Präfix wird genutzt, um die Maps zur Laufzeit zu finden.
--- 
--- @param _Name string Präfix der Kampagne
function Campaign_SetBaseName(_Name)
end
API.Campaign_SetBaseName = Campaign_SetBaseName;

--- Sucht die Maps der Kampagne.
--- 
--- Kann nicht ausgeführt werden, wenn der Präfix noch nicht gesetzt ist.
function Campaign_ScanForMaps()
end
API.Campaign_ScanForMaps = Campaign_ScanForMaps;

--- Startet die Auswahl der Map.
--- 
--- Kann nicht ausgeführt werden, wenn noch nicht nach Maps gesucht wurde.
function Campaign_StartMapSelection()
end
API.Campaign_StartMapSelection = Campaign_StartMapSelection;

