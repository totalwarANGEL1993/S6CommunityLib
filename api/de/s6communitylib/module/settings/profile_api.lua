--- Modul für die synchronisierte Verwaltung von Werten aus dem Profil.
--- 
--- Typen von Werten im Profil:
--- <ol>
--- <li><b>Normale Werte</b> - Diese Werte bleiben dauerhaft im Profil. Sie
---     verhalten sich wie normale Profilwerte.</li>
--- <li><b>Flüchtige Werte</b> - Diese Werte werden nach dem Abruf aus dem
---     Profil gelöscht. Sie sind dafür gedacht, wenn man z.B. eine andere
---     Map startet und das Profil zum Übertragen von Variablen nutzt.</li>
--- </ol>

--- Registiert einen flüchtigen Wert im Profil der synchronisiert wird.
--- @param dataType integer Erwarteter Datentyp (ProfileDataType)
--- @param section string Name der Sektion
--- @param key string Name des Schlüssels
function RegisterTransientProfileValue(dataType, section, key)
end
API.RegisterTransientProfileValue = RegisterTransientProfileValue;

--- Registiert einen Wert im Profil der synchronisiert wird.
--- @param dataType integer Erwarteter Datentyp (ProfileDataType)
--- @param section string Name der Sektion
--- @param key string Name des Schlüssels
function RegisterProfileValue(dataType, section, key)
end
API.RegisterProfileValue = RegisterProfileValue;

--- Läd alle registierten flüchtigen Werte aus dem Profil.
--- <p>
--- <b>Achtung</b>: Flüchtige Werte werden nach dem Laden im Profil gelöscht!
function LoadTransientProfileData()
end
API.LoadTransientProfileData = LoadTransientProfileData;

--- Läd alle registierten Werte aus dem Profil.
function LoadProfileData()
end
API.LoadProfileData = LoadProfileData;

--- Speichert alle registierten flüchtigen Werte im Profil.
function SaveTransientProfileData()
end
API.SaveTransientProfileData = SaveTransientProfileData;

--- Speichert alle registierten Werte im Profil.
function SaveProfileData()
end
API.SaveProfileData = SaveProfileData;

--- Gibt einen flüchtigen Wert zurück, der aus dem Profil synchronisiert wurde.
--- @param section string Name der Sektion
--- @param key string Name des Schlüssels
--- @return any Value Flüchtiger Wert aus Profil
function GetTransientProfileValue(section, key)
    return nil;
end
API.GetTransientProfileValue = GetTransientProfileValue;

--- Gibt einen Wert zurück, der aus dem Profil synchronisiert wurde.
--- @param section string Name der Sektion
--- @param key string Name des Schlüssels
--- @return any Value Wert aus Profil
function GetProfileValue(section, key)
    return nil;
end
API.GetProfileValue = GetProfileValue;

--- Speichert einen synchronisierten flüchtigen Wert im Profil.
--- @param section string Name der Sektion
--- @param key string Name des Schlüssels
--- @return any Value Wert aus Profil
function SetTransientProfileValue(section, key, value)
end
API.SetTransientProfileValue = SetTransientProfileValue;

--- Speichert einen synchronisierten Wert im Profil.
--- @param section string Name der Sektion
--- @param key string Name des Schlüssels
--- @return any Value Wert aus Profil
function SetProfileValue(section, key, value)
end
API.SetProfileValue = SetProfileValue;

