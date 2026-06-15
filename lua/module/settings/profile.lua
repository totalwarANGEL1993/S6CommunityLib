Lib.Profile = Lib.Profile or {};
Lib.Profile.Name = "Profile";
Lib.Profile.Global = {
    TransientProfileSyncRunning = false,
    PersisnentProfileSyncRunning = false,
};
Lib.Profile.Local = {
    TransientProfileSyncRunning = false,
    PersisnentProfileSyncRunning = false,
};
Lib.Profile.Shared = {
    Memory = {[1] = {}, [2] = {}}
};

ProfileDataType = {
    BOOLEAN = 1,
    NUMBER = 2,
    STRING = 3
};

ProfileDataBehavior = {
    TRANSIENT = 1,
    PERSISTENT = 2,
};

Lib.Require("core/Core");
Lib.Require("module/settings/Profile_API");
Lib.Register("module/settings/Profile");

-- -------------------------------------------------------------------------- --
-- Global

-- Global initalizer method
function Lib.Profile.Global:Initialize()
    if not self.IsInstalled then
        Report.SyncronizeProfileData_Internal = CreateReport("Event_SyncronizeProfileData_Internal");
        Report.PersistentProfileDataSyncDone_Internal = CreateReport("Event_PersistentProfileDataSyncDone_Internal");
        Report.TransientProfileDataSyncDone_Internal = CreateReport("Event_TransientProfileDataSyncDone_Internal");

        -- Garbage collection
        Lib.Profile.Local = nil;
    end
    self.IsInstalled = true;
end

-- Global load game
function Lib.Profile.Global:OnSaveGameLoaded()
end

-- Global report listener
function Lib.Profile.Global:OnReportReceived(_ID, ...)
    if _ID == Report.LoadingFinished then
        self.LoadscreenClosed = true;
    elseif _ID == Report.SyncronizeProfileData_Internal then
        Lib.Profile.Shared:SetStringWrappedValue(arg[1], arg[2], arg[3], arg[4]);
    elseif _ID == Report.PersistentProfileDataSyncDone_Internal then
        SendReportToLocal(_ID);
        self.PersistentProfileSyncRunning = false;
    elseif _ID == Report.TransientProfileDataSyncDone_Internal then
        SendReportToLocal(_ID);
        self.TransientProfileSyncRunning = false;
    end
end

function Lib.Profile.Global:LoadTransientProfileData()
    if not self.TransientProfileSyncRunning then
        ExecuteLocal([[Lib.Profile.Local:LoadTransientProfileData()]]);
        self.TransientProfileSyncRunning = true;
    end
end

function Lib.Profile.Global:LoadPersistentProfileData()
    if not self.PersistentProfileSyncRunning then
        ExecuteLocal([[Lib.Profile.Local:LoadPersistentProfileData()]]);
        self.PersistentProfileSyncRunning = true;
    end
end

function Lib.Profile.Global:SaveTransientProfileData()
    if not self.TransientProfileSyncRunning then
        self.TransientProfileSyncRunning = true;
        ExecuteLocal([[Lib.Profile.Local:SaveTransientProfileData()]]);
    end
end

function Lib.Profile.Global:SavePersistentProfileData()
    if not self.PersistentProfileSyncRunning then
        self.PersistentProfileSyncRunning = true;
        ExecuteLocal([[Lib.Profile.Local:SavePersistentProfileData()]]);
    end
end

function Lib.Profile.Global:RegisterStringWrappedValue(dataBehavior, dataType, section, key)
    Lib.Profile.Shared:RegisterStringWrappedValue(dataBehavior, dataType, section, key);
    ExecuteLocal(
        [[Lib.Profile.Shared:RegisterStringWrappedValue(%d, %d, "%s", "%s")]],
        dataBehavior, dataType, section, key
    );
end

function Lib.Profile.Global:SetStringWrappedValue(dataBehavior, section, key, value)
    Lib.Profile.Shared:SetStringWrappedValue(dataBehavior, section, key, value);
    ExecuteLocal(
        [[Lib.Profile.Shared:SetStringWrappedValue(%d, "%s", "%s", %s)]],
        dataBehavior, section, key,
        (type(value) == "string" and "\"" .. value .. "\"") or
        (type(value) == "boolean" and tostring(value)) or
        value
    );
end

-- -------------------------------------------------------------------------- --
-- Local

-- Local initalizer method
function Lib.Profile.Local:Initialize()
    if not self.IsInstalled then
        Report.SyncronizeProfileData_Internal = CreateReport("Event_SyncronizeProfileData_Internal");
        Report.PersistentProfileDataSyncDone_Internal = CreateReport("Event_PersistentProfileDataSyncDone_Internal");
        Report.TransientProfileDataSyncDone_Internal = CreateReport("Event_TransientProfileDataSyncDone_Internal");

        -- Garbage collection
        Lib.Profile.Global = nil;
    end
    self.IsInstalled = true;
end

-- Local load game
function Lib.Profile.Local:OnSaveGameLoaded()
end

-- Local report listener
function Lib.Profile.Local:OnReportReceived(_ID, ...)
    if _ID == Report.LoadingFinished then
        self.LoadscreenClosed = true;
    elseif _ID == Report.PersistentProfileDataSyncDone_Internal then
        self.PersistentProfileSyncRunning = false;
    elseif _ID == Report.TransientProfileDataSyncDone_Internal then
        self.TransientProfileSyncRunning = false;
    end
end

function Lib.Profile.Local:LoadTransientProfileData()
    self.TransientProfileSyncRunning = true;
    for section, _ in pairs(Lib.Profile.Shared.Memory[ProfileDataBehavior.TRANSIENT]) do
        for key, config in pairs(Lib.Profile.Shared.Memory[ProfileDataBehavior.TRANSIENT][section]) do
            local raw = Profile.GetString(section, key);
            if raw ~= nil and raw ~= "" then
                local value = Lib.Profile.Shared:ConvertFromStringWrappedValue(config[1], raw);
                SendReportToGlobal(Report.SyncronizeProfileData_Internal, ProfileDataBehavior.TRANSIENT, section, key, value);
                Lib.Profile.Shared:SetStringWrappedValue(ProfileDataBehavior.TRANSIENT, section, key, value);
            end
            -- Data is transient -> clear the key
            Profile.SetString(section, key, "");
        end
    end
    SendReportToGlobal(Report.TransientProfileDataSyncDone_Internal);
end

function Lib.Profile.Local:LoadPersistentProfileData()
    self.PersistentProfileSyncRunning = true;
    for section, _ in pairs(Lib.Profile.Shared.Memory[ProfileDataBehavior.PERSISTENT]) do
        for key, config in pairs(Lib.Profile.Shared.Memory[ProfileDataBehavior.PERSISTENT][section]) do
            local raw = Profile.GetString(section, key);
            if raw ~= nil and raw ~= "" then
                local value = Lib.Profile.Shared:ConvertFromStringWrappedValue(config[1], raw);
                SendReportToGlobal(Report.SyncronizeProfileData_Internal, ProfileDataBehavior.PERSISTENT, section, key, value);
                Lib.Profile.Shared:SetStringWrappedValue(ProfileDataBehavior.PERSISTENT, section, key, value);
            end
        end
    end
    SendReportToGlobal(Report.PersistentProfileDataSyncDone_Internal);
end

function Lib.Profile.Local:SaveTransientProfileData()
    self.TransientProfileSyncRunning = true;
    for section, _ in pairs(Lib.Profile.Shared.Memory[ProfileDataBehavior.TRANSIENT]) do
        for key, config in pairs(Lib.Profile.Shared.Memory[ProfileDataBehavior.TRANSIENT][section]) do
            local raw = Lib.Profile.Shared:ConvertToStringWrappedValue(config[1], config[2]);
            Profile.SetString(section, key, raw);
        end
    end
    SendReportToGlobal(Report.TransientProfileDataSyncDone_Internal);
end

function Lib.Profile.Local:SavePersistentProfileData()
    self.PersistentProfileSyncRunning = true;
    for section, _ in pairs(Lib.Profile.Shared.Memory[ProfileDataBehavior.PERSISTENT]) do
        for key, config in pairs(Lib.Profile.Shared.Memory[ProfileDataBehavior.PERSISTENT][section]) do
            local raw = Lib.Profile.Shared:ConvertToStringWrappedValue(config[1], config[2]);
            Profile.SetString(section, key, raw);
        end
    end
    SendReportToGlobal(Report.PersistentProfileDataSyncDone_Internal);
end

-- -------------------------------------------------------------------------- --
-- Shared

function Lib.Profile.Shared:RegisterStringWrappedValue(memType, dataType, section, key)
    self.Memory[memType][section] = self.Memory[memType][section] or {};
    if not self.Memory[memType][section][key] then
        self.Memory[memType][section][key] = {dataType, nil};
    end
end

function Lib.Profile.Shared:GetStringWrappedValue(memType, section, key)
    self.Memory[memType][section] = self.Memory[memType][section] or {};
    local sectionData = self.Memory[memType][section];
    if sectionData[key] then
        return sectionData[key][2];
    end
    return nil;
end

function Lib.Profile.Shared:SetStringWrappedValue(memType, section, key, value)
    self.Memory[memType][section] = self.Memory[memType][section] or {};
    if self.Memory[memType][section][key] then
        self.Memory[memType][section][key][2] = value;
    end
end

function Lib.Profile.Shared:ConvertFromStringWrappedValue(dType, value)
    if value == nil then return nil end
    if dType == ProfileDataType.BOOLEAN then
        return value == "true";
    elseif dType == ProfileDataType.NUMBER then
        return tonumber(value);
    end
    return tostring(value);
end

function Lib.Profile.Shared:ConvertToStringWrappedValue(dType, value)
    if value == nil then return "" end
    if dType == ProfileDataType.BOOLEAN then
        return value and "true" or "false";
    end
    return tostring(value);
end

-- -------------------------------------------------------------------------- --

RegisterModule(Lib.Profile.Name);

