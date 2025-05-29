--- Ermöglicht das Definieren von Dialogen.
---
--- Dialoge können verwendet werden, um Gespräche zwischen Charakteren unter Verwendung der
--- animierten Köpfe in einem funktionsgestrippten Briefing zu erstellen.
---



--- Startet einen Dialog.
---
--- Der Dialog selbst kann verschiedene Attribute bekommen.
--- * `Starting`                - Funktion, die aufgerufen wird, wenn der Dialog gestartet wird              
--- * `Finished`                - Funktion, die aufgerufen wird, wenn der Dialog beendet ist             
--- * `RestoreCamera`           - Kameraposition wird am Ende des Dialogs gespeichert und wiederhergestellt 
--- * `RestoreGameSpeed`        - Spielgeschwindigkeit wird am Ende des Dialogs gespeichert und wiederhergestellt      
--- * `EnableGlobalImmortality` - Während der Dialoge sind alle Einheiten unverwundbar        
--- * `EnableSky`               - Anzeige des Himmels während des Dialogs                   
--- * `EnableFoW`               - Anzeige des Nebels des Krieges während des Dialogs           
--- * `EnableBorderPins`        - Anzeige der Grenznadeln während des Dialogs
--- * `HideNotes`               - Nachrichten nicht anzeigen
---
--- #### Example
---
--- ```lua
--- function Dialog1(_Name, _PlayerID)
---     local Dialog = {
---         DisableFow = true,
---         DisableBoderPins = true,
---     };
---     local AP, ASP = API.AddDialogPages(Dialog);
---     -- Seiten
---     Dialog.Starting = function(_Data)
---     end
---     Dialog.Finished = function(_Data)
---     end
---     API.StartDialog(Dialog, _Name, _PlayerID);
--- end
--- ```
---
--- @param _Dialog table     Dialogtabelle
--- @param _Name string      Name des Dialogs
--- @param _PlayerID integer Spieler-ID des Empfängers
function StartDialog(_Dialog, _Name, _PlayerID)
end
API.StartDialog = StartDialog;

--- Fragt den Spieler um Erlaubnis, Grafikeinstellungen zu ändern.
---
--- Ist das BriefingSystem geladen, wird dessen Funktionalität genutzt.
---
--- Diese Funktionalität ist im Multiplayer deaktiviert.
function RequestDialogAlternateGraphics()
end
API.RequestDialogAlternateGraphics = RequestDialogAlternateGraphics;

--- Überprüft, ob ein Dialog aktiv ist.
--- @param _PlayerID integer Spieler-ID des Empfängers
--- @return boolean IsActive Dialog ist aktiv
function IsDialogActive(_PlayerID)
    return true;
end
API.IsDialogActive = IsDialogActive;

--- Bereitet den Dialog vor und gibt die Seitenfunktionen zurück.
---
--- Muss aufgerufen werden, bevor Seiten hinzugefügt werden.
--- @param _Dialog table Dialogtabelle
--- @return function AP  Seitenfunktion
--- @return function ASP Kurze Seitenfunktion
function AddDialogPages(_Dialog)
    return function(...) end, function(...) end
end
API.AddDialogPages = AddDialogPages;

--- Erstellt eine Seite.
---
--- Die Seite kann verschiedene Attribute bekommen.
--- * `Actor`      - (optional) Spieler-ID des Sprechers
--- * `Title`      - (optional) Name des Akteurs (nur mit Akteur)
--- * `Text`       - (optional) Angezeigter Seitentext
--- * `Speech`     - Pfad zum Voiceover (MP3-Datei)
--- * `Position`   - Position der Kamera (nicht mit Ziel)
--- * `Target`     - Einheit, der die Kamera folgt (nicht mit Position)
--- * `Distance`   - (optional) Entfernung der Kamera
--- * `Action`     - (optional) Funktion, die aufgerufen wird, wenn die Seite angezeigt wird
--- * `FadeIn`     - (optional) Dauer des Einblendens aus Schwarz
--- * `FadeOut`    - (optional) Dauer des Ausblendens zu Schwarz
--- * `FaderAlpha` - (optional) Maskenalpha
--- * `MC`         - (optional) Tabelle mit Auswahlmöglichkeiten zum Verzweigen in Dialogen
---
--- #### Example:
--- Eine einfache Seite erstellen.
--- ```lua
--- AP {
---    Title        = "Marcus",
---    Text         = "Dies ist eine einfache Seite.",
---    Actor        = 1,
---    Duration     = 2,
---    FadeIn       = 2,
---    Position     = "npc1",
---    DialogCamera = true,
--- };
--- ```
---
--- #### Example:
--- Eine Multiple Choice Seite erstellen.
--- ```lua
--- AP {
---    Title        = "Marcus",
---    Text         = "Das ist keine so einfache Seite.",
---    Actor        = 1,
---    Duration     = 2,
---    FadeIn       = 2,
---    Position     = "npc1",
---    DialogCamera = true,
---    MC = {
---        {"Option 1", "Option1"},
---        {"Option 2", "Option2"},
---    },
--- };
--- 
--- -- Die Verzweigungen in einem Briefing müssen mit einer leeren Seite
--- -- getrennt werden, damit das Briefing weiß, dass es zier zuende ist.
--- ASP("Option1", "Erste Option", "Dies ist die erste Option.", false, "Marcus");
--- AP();
--- ASP("Option2", "Zweite Option", "Dies ist die zweite Option.", false, "Marcus");
--- ```
---
--- #### Example:
--- Das Sprungziel einer Option kann durch eine Funktion bestimmt werden.
--- ```lua
--- AP {
---    Title        = "Marcus",
---    Text         = "Das ist keine so einfache Seite.",
---    Actor        = 1,
---    Duration     = 2,
---    FadeIn       = 2,
---    Position     = "npc1",
---    DialogCamera = true,
---    MC = {
---        {"Option 1", "Option1"},
---        {"Option 2", ForkingFunction},
---    },
--- };
--- ```
---
function AP(_Data)
    return {};
end

--- Erstellt eine Seite auf vereinfachte Weise.
---
--- Die Funktion kann einen automatischen Seitennamen basierend auf dem Seitenindex erstellen. Ein
--- Name kann ein optionales Parameter am Anfang sein.
---
--- #### Einstellungen
--- Die Funktion erwartet die folgenden Parameter:
--- 
--- * `Name`         - (Optional) Name der Seite
--- * `Sender`       - Spieler-ID des Akteurs
--- * `Target`       - Einheit, auf die die Kamera schaut
--- * `Title`        - Angezeigter Seitentitel
--- * `Text`         - Angezeigter Seitentext
--- * `DialogCamera` - Verwendung der Nahkamera
--- * `Action`       - (Optional) Aktion, wenn die Seite angezeigt wird
---
--- #### Example:
---
--- ```lua
--- -- Totalaufnahme
--- ASP("Titel", "Einige wichtige Texte.", false, "HQ");
--- -- Seitennamen
--- ASP("Seite1", "Titel", "Einige wichtige Texte.", false, "HQ");
--- -- Nahansicht
--- ASP("Titel", "Einige wichtige Texte.", true, "Marcus");
--- -- Aktion aufrufen
--- ASP("Titel", "Einige wichtige Texte.", true, "Marcus", MyFunction);
--- -- Überspringen erlauben/verbieten
--- ASP("Titel", "Einige wichtige Texte.", true, "HQ", nil, true);
--- ```
--- @param _Name? string Name der Seite
--- @param _Sender integer Spieler-ID des Akteurs
--- @param _Target string Einheit, auf die die Kamera schaut
--- @param _Title string Angezeigter Seitentitel
--- @param _Text string Angezeigter Seitentext
--- @param _DialogCamera boolean Verwendung der Nahkamera
--- @param _Action? boolean Aktion, wenn die Seite angezeigt wird
--- @return table Page Erzeugte Seite
function ASP(...)
    return {};
end

