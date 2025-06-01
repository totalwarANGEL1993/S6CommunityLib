--- Ermöglicht das Definieren von Einleitungen.
---
--- Der Höhepunkt für das Skripten von Dialogen und einfachen Kameraanimationen.
--- Ein vielseitiges Tool zum Skripten der Kartendarstellung.
--- 
--- #### Optionen für Briefings
--- 
--- <p><b><u>Standard</u></b></p>
--- <p>
--- Briefings bestehen aus Seiten, die Text anzeigen und mit einem 
--- Bildausschnitt szenerisch in Szene setzen. Eine Seite wird mit der Funktion
--- AP angelegt.
--- ```lua
--- AP {
---    Title        = "Marcus",
---    Text         = "Dies ist eine einfache Seite.",
---    Position     = "Marcus",
---    Rotation     = 30,
---    DialogCamera = true,
--- };
--- ```
---
--- <p><b><u>Vereinfacht</u></b></p>
--- <p>
--- Mit der Funktion ASP können vereifachte Seiten geschrieben werden.
--- ```lua
--- ASP("Titel", "Text der Seite", false, "HQ");
--- ```
--- 
--- <p><b><u>Parallax</u></b></p>
--- <p>
--- Eine Seite kann bis zu 6 animierte Parallaxen anzeigen - bildschirmfüllende
--- Grafiken. Mit UV-Koordinaten können Ausschnitte der Grafiken gezeigt werden.
--- Das ermöglicht rudimentär animierte Szenen zu erstellen.
--- ```lua
--- Briefing.PageParallax = {
---     ["Seite1"] = {
---         {"maps/externalmap/mapname/graphics/sea.png", 60,
---          {0, 0, 0.8, 1, 255},
---          {0.2, 0, 1, 1, 255}},
---     },
--- };
--- ```
--- 
--- Der Definition der Parallaxen können mehrere Switches hinzugefügt werden,
--- die das Verhalten der Parallaxen beeinflussen.
--- * `Clear`  - Alle laufenden Parallaxen werden gelöscht. Dann werden die neuen Parallaxen gestartet.
--- * `Repeat` - Die Parallaxen begingen nach dem Ende von vorn.
--- 
--- <p><b><u>Animiert</u></b></p>
--- <p>
--- Es ist möglich, die Kameraanimationen von den Pages zu trennen. Dadurch
--- lassen sich nicht nur die Texte flüssiger schreiben, es können auch mehr
--- komplexere Bewegungen umgesetzt werden.
--- 
--- Animationen werden in der Tabelle `Briefing.PageAnimation` definiert. Eine
--- Seite kann mehrere Animationssets aufnehmen. Ein Animationsset besteht aus
--- 2 oder 4 Richtungsvektoren. Ein Richtungsvektor besteht aus der Position
--- und der Blickrichtung. Vektoren werden mit `GetFrameVector` erstellt.
--- ```lua
--- Briefing.PageAnimation = {
---     ["Seite1"] = {
---         {30, {GetFrameVector("pos1", 500, "pos2", -3000)},
---              {GetFrameVector("pos3", 500, "pos4", -3000)},
---              {GetFrameVector("pos7", 500, "pos8", -3000)},
---              {GetFrameVector("pos5", 500, "pos6", -3000)}},
---     },
--- };
--- ```
--- 
--- Mit der Funktion ASP können Seiten ohne Kameradefinition erzeugt werden.
--- Wichtig ist, dass der Name der Seite im Briefing eindeutig sein muss. Wenn
--- die Seite erreicht wird, werden die Animationssets gestartet.
--- ```lua
--- ASP("Seite1", "Titel", "Diese Seite ist animaiert.");
--- ```
--- 
--- Der Definition der Animationen können mehrere Switches hinzugefügt werden,
--- die das Verhalten der Animationen beeinflussen.
--- * `Clear`:    (optional) <b>boolean</b> Alle laufenden Animationssets werden gelöscht. Dann werden die neuen Animationssets gestartet.
--- * `Repeat`:   (optional) <b>boolean</b> Die Animationssets begingen nach dem Ende von vorn.
--- * `Postpone`: (optional) <b>boolean</b> Die laufenden Animationssets werden zurückgestellt und die Animationssets der Seite werden gestartet.
--- * `PageTied`: (optional) <b>boolean</b> Die Animationssets werden nur auf dieser Seite abgespielt.
---



--- Startet eine Briefing.
--- 
--- #### Fields `_Briefing`:
--- * `Starting`:                (optional) <b>function</b> Funktion, die beim Starten der Einleitung aufgerufen wird              
--- * `Finished`:                (optional) <b>function</b> Funktion, die beim Beenden der Einleitung aufgerufen wird             
--- * `RestoreCamera`:           (optional) <b>boolean</b> Kameraposition wird am Ende der Einleitung gespeichert und wiederhergestellt 
--- * `RestoreGameSpeed`:        (optional) <b>boolean</b> Spielgeschwindigkeit wird am Ende der Einleitung gespeichert und wiederhergestellt      
--- * `EnableGlobalImmortality`: (optional) <b>boolean</b> Während Einleitungen sind alle Entitäten unverwundbar        
--- * `EnableSky`:               (optional) <b>boolean</b> Zeigt den Himmel während der Einleitung an                   
--- * `EnableFoW`:               (optional) <b>boolean</b> Zeigt den Nebel des Krieges während der Einleitung an 
--- * `EnableBorderPins`:        (optional) <b>boolean</b> Zeigt die Randnadeln während der Einleitung an     
--- * `PreloadAssets`:           (optional) <b>boolean</b> Erlaubt weites Sichtfeld in Briefings
--- * `HideNotes`:               (optional) <b>boolean</b> Nachrichten nicht anzeigen
---
--- #### Example:
--- ```lua
--- function Briefing1(_Name, _PlayerID)
---     local Briefing = {};
---     local AP, ASP = AddBriefingPages(Briefing);
---     -- Seiten
---     Briefing.Starting = function(_Data)
---     end
---     Briefing.Finished = function(_Data)
---     end
---     StartBriefing(Briefing, _Name, _PlayerID);
--- end
--- ```
---
--- @param _Briefing table   Einleitungstabelle
--- @param _Name string      Name der Einleitung
--- @param _PlayerID integer Spieler-ID des Empfängers
function StartBriefing(_Briefing, _Name, _PlayerID)
end
API.StartBriefing = StartBriefing;

--- Fragt den Spieler um Erlaubnis, Grafikeinstellungen zu ändern.
---
--- Diese Funktionalität ist im Multiplayer deaktiviert.
function RequestBriefingAlternateGraphics()
end
API.RequestBriefingAlternateGraphics = RequestBriefingAlternateGraphics;

--- Überprüft, ob eine Einleitung aktiv ist.
--- @param _PlayerID integer Spieler-ID des Empfängers
--- @return boolean IsActive Einleitung ist aktiv
function IsBriefingActive(_PlayerID)
    return true;
end
API.IsBriefingActive = IsBriefingActive;

--- Erstellt einen Punkt aus einer Position.
--- @param _Entity any      Zielentität
--- @param _ZOffset integer Z-Offset (<> 0 → Z überschreiben)
--- @return number X X-Koordinate
--- @return number Y Y-Koordinate
--- @return number Z Z-Koordinate
function GetFramePosition(_Entity, _ZOffset)
    return 0, 0, 0;
end

--- Erstellt einen Vektor aus 2 Positionen.
--- @param _Entity1 any      Zielpositions-Entität
--- @param _ZOffset1 integer Z-Offset der Position (<> 0 → Z überschreiben)
--- @param _Entity2 any      Ziel-LookAt-Entität
--- @param _ZOffset2 integer Z-Offset von LookAt (<> 0 → Z überschreiben)
--- @return number X1        X-Koordinate Position
--- @return number Y1        Y-Koordinate Position
--- @return number Z1        Z-Koordinate Position
--- @return number X2        X-Koordinate LookAt
--- @return number Y2        Y-Koordinate LookAt
--- @return number Z2        Z-Koordinate LookAt
function GetFrameVector(_Entity1, _ZOffset1, _Entity2, _ZOffset2)
    return 0, 0, 0, 0, 0, 0;
end

--- Bereitet die Einleitung vor und gibt die Seitenfunktionen zurück.
---
--- Muss aufgerufen werden, bevor Seiten hinzugefügt werden.
--- @param _Briefing table Einleitungstabelle
--- @return function AP  Seitenfunktion
--- @return function ASP Kurze Seitenfunktion
function AddBriefingPages(_Briefing)
    return function() end, function() end;
end
API.AddBriefingPages = AddBriefingPages;

--- Erstellt eine Seite.
---
--- #### Fields `_Data`:
--- * `Title`:           <b>any</b> Angezeigter Seitentitel (String oder Language Table)
--- * `Text`:            <b>any</b> Angezeigter Seitentext (String oder Language Table)
--- * `Speech`:          <b>string</b> Pfad zum Voiceover (MP3-Datei)
--- * `Position`:        (Optional) <b>string</b> Skriptname der Position
--- * `Duration`:        (Optional) <b>integer</b> Zeit bis zum automatischen Überspringen und Kameraanimation
--- * `DialogCamera`:    (Optional) <b>boolean</b> Verwendung der Nahaufnahmekamera
--- * `DisableSkipping`: (Optional) <b>boolean</b> Erlauben/Verbieten des Überspringens von Seiten
--- * `Action`:          (Optional) <b>function</b> Funktion, die aufgerufen wird, wenn die Seite angezeigt wird
--- * `FarClipPlane`:    (Optional) <b>integer</b> Renderabstand
--- * `Rotation`:        (Optional) <b>float</b> Kamerarotation
--- * `Zoom`:            (Optional) <b>float</b> Kamerazoom
--- * `Angle`:           (Optional) <b>float</b> Kamerawinkel
--- * `FadeIn`:          (Optional) <b>float</b> Dauer des Einblendens aus Schwarz
--- * `FadeOut`:         (Optional) <b>float</b> Dauer des Ausblendens in Schwarz
--- * `FaderAlpha`:      (Optional) <b>float</b> Maskenalpha
--- * `BarOpacity`:      (Optional) <b>float</b> Deckkraft der Balken
--- * `BigBars`:         (Optional) <b>boolean</b> Verwende große Balken
--- * `FlyTo`:           (Optional) <b>table</b> Tabelle mit zweitem Satz von Kamerakonfigurationen, wobei die Kamera zufliegt
--- * `Performance`:     (Optional) <b>boolean</b> Grafiksettings für diese Seite herabsetzen
--- * `MC`:              (Optional) <b>table</b> Tabelle mit Auswahlmöglichkeiten zum Abzweigen in Dialogen
--- 
--- #### Fields `_Data.FlyTo`:
--- * `Position`:     <b>string</b> Skriptname der Position
--- * `Action`:       <b>function</b> Funktion, die aufgerufen wird, wenn die Seite angezeigt wird
--- * `FarClipPlane`: <b>integer</b> Renderabstand
--- * `Rotation`:     <b>float</b> Kamerarotation
--- * `Zoom`:         <b>float</b> Kamerazoom
--- * `Angle`:        <b>float</b> Kamerawinkel
--- 
--- #### Fields `_Data.MC`:
--- * `[1]`: <b>any</b> Angezeigter Text (String oder Language Table)
--- * `[2]`: <b>any</b> Sprungziel (String oder Funktion)
---
--- #### Example:
--- Eine einfache Seite erstellen.
--- ```lua
--- AP {
---    Title        = "Marcus",
---    Text         = "Dies ist eine einfache Seite.",
---    Position     = "Marcus",
---    Rotation     = 30,
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
---    Position     = "Marcus",
---    Rotation     = 30,
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
--- Das Sprungziel einer Option kann durch eine Funktion bestimmt werden. Die
--- Funktion muss den Namen der Zielseite zurückgeben.
--- ```lua
--- AP {
---    Title        = "Marcus",
---    Text         = "Das ist keine so einfache Seite.",
---    Position     = "Marcus",
---    Rotation     = 30,
---    DialogCamera = true,
---    MC = {
---        {"Option 1", "Option1"},
---        {"Option 2", ForkingFunction},
---    },
--- };
--- ```
---
--- @param _Data table Seitendaten
--- @return table Page Erzeugte Seite
function AP(_Data)
    return {};
end

--- Erstellt eine Seite auf vereinfachte Weise.
---
--- Die Funktion kann einen automatischen Seitennamen basierend auf dem 
--- Seitenindex erstellen. Ein Name kann ein optionales Parameter am 
--- Anfang sein. Die Seite wird nicht weiter springen, bis der Skip-Button 
--- geklicht wird.
---
--- #### Example:
---
--- ```lua
--- -- Totale Ansicht
--- ASP("Titel", "Einige wichtige Texte.", false, "HQ");
--- -- Seitennamen
--- ASP("Seite1", "Titel", "Einige wichtige Texte.", false, "HQ");
--- -- Nahaufnahme
--- ASP("Titel", "Einige wichtige Texte.", true, "Marcus");
--- -- Aktion aufrufen
--- ASP("Titel", "Einige wichtige Texte.", true, "Marcus", MyFunction);
--- -- Seite ohne Positionsangabe
--- ASP("Seite1", "Titel", "Einige wichtige Texte.");
--- ```
---
--- @param _Name? string Name der Seite
--- @param _Title string Angezeigter Seitentitel
--- @param _Text string Angezeigter Seitentext
--- @param _DialogCamera boolean Verwendung der Nahaufnahmekamera
--- @param _Position? string Skriptname der fokussierten Entität
--- @param _Action? function Aktion bei Anzeige
--- @return table Page Erzeugte Seite
function ASP(...)
    return {};
end

