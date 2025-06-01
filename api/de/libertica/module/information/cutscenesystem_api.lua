--- Ermöglicht das Definieren von Zwischensequenzen.
---
--- Zwischensequenzen sind XML-definierte Kamerabewegungen, die von der
--- Spiel-Engine wiedergegeben werden können. Zwischensequenzen zeichnen sich
--- durch flüssige Kamerabewegungen aus.
---

--- Startet eine Zwischensequenz.
---
--- #### Fields `_Cutscene`:
--- * `Starting`:                (optional) <b>function</b> Funktion, die beim Starten der Einleitung aufgerufen wird              
--- * `Finished`:                (optional) <b>function</b> Funktion, die beim Beenden der Einleitung aufgerufen wird                
--- * `EnableGlobalImmortality`: (optional) <b>boolean</b> Während Einleitungen sind alle Entitäten unverwundbar        
--- * `EnableSky`:               (optional) <b>boolean</b> Zeigt den Himmel während der Einleitung an                   
--- * `EnableFoW`:               (optional) <b>boolean</b> Zeigt den Nebel des Krieges während der Einleitung an 
--- * `EnableBorderPins`:        (optional) <b>boolean</b> Zeigt die Randnadeln während der Einleitung an     
--- * `HideNotes`:               (optional) <b>boolean</b> Nachrichten nicht anzeigen
---
--- #### Example:
--- ```lua
--- function Cutscene1(_Name, _PlayerID)
---     local Cutscene = {};
---     local AP = API.AddCutscenePages(Cutscene);
---     -- Seiten
---     Cutscene.Starting = function(_Data)
---     end
---     Cutscene.Finished = function(_Data)
---     end
---     API.StartCutscene(Cutscene, _Name, _PlayerID);
--- end
--- ```
---
--- @param _Cutscene table   Zwischensequenz-Tabelle
--- @param _Name string      Name der Zwischensequenz
--- @param _PlayerID integer Spieler-ID des Empfängers
function StartCutscene(_Cutscene, _Name, _PlayerID)
end
API.StartCutscene = StartCutscene;

--- Fragt den Spieler um Erlaubnis, Grafikeinstellungen zu ändern.
---
--- Ist das BriefingSystem oder das DialogSystem geladen, werden stattdessen
--- deren Funktionen verwendet.
---
--- Diese Funktionalität ist im Multiplayer deaktiviert.
function RequestCutsceneAlternateGraphics()
end
API.RequestCutsceneAlternateGraphics = RequestCutsceneAlternateGraphics;

--- Überprüft, ob eine Zwischensequenz aktiv ist.
--- @param _PlayerID integer Spieler-ID des Empfängers
--- @return boolean IsActive Zwischensequenz ist aktiv
function IsCutsceneActive(_PlayerID)
    return true;
end
API.IsCutsceneActive = IsCutsceneActive;

--- Bereitet die Zwischensequenz vor und gibt die Seitenfunktion zurück.
---
--- Muss aufgerufen werden, bevor Seiten hinzugefügt werden.
--- @param _Cutscene table Zwischensequenz-Tabelle
--- @return function AP  Seitenfunktion
function AddCutscenePages(_Cutscene)
    return function(...) end;
end
API.AddCutscenePages = AddCutscenePages;

--- Erstellt eine Seite.
---
--- #### Fields `_Data`:
--- * `Flight`:          <b>string</b> Name der Flug-XML (ohne .cs)
--- * `Title`:           (optional) <b>any</b> Angezeigter Seitentitel (String oder Language Table)
--- * `Text`:            (optional) <b>any</b> Angezeigter Seitentext (String oder Language Table)
--- * `Speech`:          (optional) <b>string</b> Pfad zum Voiceover (MP3-Datei)
--- * `Action`:          (optional) <b>function</b> Funktion, die beim Anzeigen der Seite aufgerufen wird
--- * `FarClipPlane`:    (optional) <b>boolean</b> Render-Entfernung
--- * `FadeIn`:          (optional) <b>float</b> Dauer des Einblendens aus Schwarz
--- * `FadeOut`:         (optional) <b>float</b> Dauer des Ausblendens nach Schwarz
--- * `FaderAlpha`:      (optional) <b>float</b> Maskenalpha
--- * `DisableSkipping`: (optional) <b>boolean</b> Erlauben/Verbieten des Überspringens von Seiten
--- * `BarOpacity`:      (optional) <b>float</b> Deckkraft der Leisten
--- * `BigBars`:         (optional) <b>boolean</b> Verwendung großer Leisten
---
--- #### Example:
---
--- ```lua
--- AP {
---     Flight       = "c02",
---     FarClipPlane = 45000,
---     Title        = "Titel",
---     Text         = "Text des Flugs.",
--- };
--- ```
---
--- @param _Data table Seitendaten
--- @return table Page Erzeugte Seite
function AP(_Data)
    return {};
end

