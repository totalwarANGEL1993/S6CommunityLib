--- ...
---
Lib.Typewriter = Lib.Typewriter or {};



--- Zeigt einen Text byte für byte an.
---
--- Wenn bei Spielstart verwendet, beginnt der Text nach dem Laden der Karte. Wenn ein anderes
--- Kinoevent läuft, wartet der Typewriter auf Abschluss.
---
--- Kontrollzeichen wie {cr} werden als ein Token ausgewertet und als atomares Token behandelt
--- und sofort angezeigt. Mehr als 1 Leerzeichen hintereinander werden automatisch auf 1 Leerzeichen
--- abgeschnitten (durch den Spiel-Engine).
---
--- #### Felder der Tabelle
--- * Text         - Anzuzeigender Text
--- * Name         - (Optional) Name für das Ereignis
--- * PlayerID     - (Optional) Spieler, dessen Text angezeigt wird
--- * Callback     - (Optional) Rückruffunktion
--- * TargetEntity - (Optional) Entität, auf die die Kamera fokussiert ist
--- * CharSpeed    - (Optional) Faktor der Schreibgeschwindigkeit (Standard: 1.0)
--- * Waittime     - (Optional) Anfangswartezeit vor dem Schreiben
--- * Opacity      - (Optional) Deckkraft des Hintergrunds (Standard: 1.0)
--- * Color        - (Optional) Hintergrundfarbe (Standard: {R= 0, G= 0, B= 0})
--- * Image        - (Optional) Hintergrundbild (muss im 16:9-Format sein)
---
--- #### Beispiele
--- ```lua
--- local EventName = StartTypewriter {
---     PlayerID = 1,
---     Text     = "Lorem ipsum dolor sit amet, consetetur "..
---                "sadipscing elitr, sed diam nonumy eirmod "..
---                "tempor invidunt ut labore et dolore magna "..
---                "aliquyam erat, sed diam voluptua.",
---     Callback = function(_Data)
---     end
--- };
--- ```
---
--- @param _Data table Daten-Tabelle
--- @return string? EventName Name des Ereignisses
function StartTypewriter(_Data)
    return "";
end
API.StartTypewriter = StartTypewriter;

