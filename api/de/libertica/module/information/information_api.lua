--- ...
---
--- #### Reports
--- `Report.CinematicActivated` - Ein Kinoevent, empfangen von einem bestimmten Spieler, startet.
--- `Report.GameInterfaceShown` - Ein Kinoevent, empfangen von einem bestimmten Spieler, endet.
---
Lib.Information = Lib.Information or {};



--- Propagiert den Beginn eines Kinoveranstaltung.
--- @param _Name     string  Bezeichner
--- @param _PlayerID integer ID des Spielers
function StartCinematicEvent(_Name, _PlayerID)
end
API.StartCinematicEvent = StartCinematicEvent;

--- Propagiert das Ende einer Kinoveranstaltung.
--- @param _Name     string  Bezeichner
--- @param _PlayerID integer ID des Spielers
function FinishCinematicEvent(_Name, _PlayerID)
end
API.FinishCinematicEvent = FinishCinematicEvent;

---
--- Gibt den Zustand des Kinoevent zurück.
---
--- @param _Identifier any Bezeichner oder ID
--- @param _PlayerID integer ID des Spielers
--- @return integer State Zustand des Kinoevent
---
function GetCinematicEvent(_Identifier, _PlayerID)
    return 0;
end
API.GetCinematicEvent = GetCinematicEvent;

---
--- Prüft ob gerade ein Kinoevent für den Spieler aktiv ist.
---
--- @param _PlayerID integer ID des Spielers
--- @return boolean Active Kinoevent ist aktiv
---
function IsCinematicEventActive(_PlayerID)
    return false;
end
API.IsCinematicEventActive = IsCinematicEventActive;



--- Ein Kinoevent, empfangen von einem bestimmten Spieler, startet.
---
--- #### Parameter
--- * `EventID`  - ID des Kinoevent
--- * `PlayerID` - ID des Empfängers
Report.CinematicActivated = anyInteger;

--- Ein Kinoevent, empfangen von einem bestimmten Spieler, endet.
--- 
--- #### Parameter
--- * `EventID`  - ID des Kinoevent
--- * `PlayerID` - ID des Empfängers
Report.CinematicConcluded = anyInteger;