Lib.EntitySearch = Lib.EntitySearch or {};
Lib.EntitySearch.Name = "EntitySearch";
Lib.EntitySearch.Global = {};
Lib.EntitySearch.Local  = {};
Lib.EntitySearch.Shared  = {
    SearchEntitiesTypeLookup = {},
    Filters = {
        ["__Default"] = function(_ID) return true; end,
    },
    Caches = {
        Entity = {},
        Filter = {},
    },
};

Lib.Require("comfort/GetPosition");
Lib.Require("comfort/GetDistance");
Lib.Require("core/Core");
Lib.Require("module/entity/EntitySearch_API");
Lib.Register("module/entity/EntitySearch");

-- Global ------------------------------------------------------------------- --

function Lib.EntitySearch.Global:Initialize()
end

function Lib.EntitySearch.Global:OnReportReceived(_ID, ...)
    if _ID == Report.LoadscreenClosed then
        self.LoadscreenClosed = true;
    end
end

-- Local -------------------------------------------------------------------- --

function Lib.EntitySearch.Local:Initialize()
end

function Lib.EntitySearch.Local:OnReportReceived(_ID, ...)
    if _ID == Report.LoadscreenClosed then
        self.LoadscreenClosed = true;
    end
end

-- Shared ------------------------------------------------------------------- --

function Lib.EntitySearch.Shared:CreateFilter(_Identifier, _Function)
    self.Filters[_Identifier] = _Function;
end

function Lib.EntitySearch.Shared:DropFilter(_Identifier)
    self.Filters[_Identifier] = nil;
end

function Lib.EntitySearch.Shared:IterateOverEntities(_Filter)
    local FilterName = (self.Filters[_Filter] and _Filter) or "__Default";
    local Time = math.floor(Logic.GetTime());
    local Turn = math.floor(Logic.GetCurrentTurn());
    local ResultList = {};
    local AllEntities;

    -- Invoke filter cache if not too old and return cache
    local FilterCache = self.Caches.Filter[FilterName];
    if FilterCache and FilterCache[1] then
        if FilterCache[1] + 3 <= Time then
            self.Caches.Filter[FilterName] = nil;
        elseif FilterName ~= "__Default" and Time - FilterCache[1] <= 1 then
            return FilterCache[2];
        end
    end

    -- Invoke entity cache if not to old or scan all entities
    local EntityCache = self.Caches.Entity;
    if EntityCache[1] and Turn - EntityCache[1] <= 1 then
        AllEntities = EntityCache[2];
    else
        local j = 1;
        AllEntities = {};
        for _, v in pairs(Entities) do
            local IDs = Logic.GetEntitiesOfType(v);
            local n = #IDs;
            for i = 1, n do
                AllEntities[j] = IDs[i];
                j = j + 1;
            end
        end
        self.Caches.Entity = {Turn, AllEntities};
    end

    -- Do actual search and save results in cache
    local j = 1;
    local Filter = self.Filters[_Filter] or self.Filters["__Default"];
    for i= 1, #AllEntities do
        local ID = AllEntities[i];
        if Filter(ID) then
            ResultList[j] = AllEntities[i];
            j = j + 1;
        end
    end
    self.Caches.Filter[FilterName] = {Time, ResultList};
    return ResultList;
end

function Lib.EntitySearch.Shared:SearchEntities(_PlayerID, _WithoutDefeatResistant)
    if _WithoutDefeatResistant == nil then
        _WithoutDefeatResistant = false;
    end
    local Time = math.floor(Logic.GetTime());
    local Key = "hupl_".._PlayerID.."_"..tostring(_WithoutDefeatResistant);
    self.SearchEntitiesTypeLookup[Key] = self.SearchEntitiesTypeLookup[Key] or {};

    -- If filter doesn't exist, create it
    if not self.Filters[Key] then
        local Function = function(_ID)
            if _PlayerID and Logic.EntityGetPlayer(_ID) ~= _PlayerID then
                return false;
            end
            if _WithoutDefeatResistant then
                if (Logic.IsBuilding(_ID) or Logic.IsWall(_ID)) and Logic.IsConstructionComplete(_ID) == 0 then
                    return false;
                end
                local Type = Logic.GetEntityType(_ID);
                -- Check in regex result cache
                if Lib.EntitySearch.Shared.SearchEntitiesTypeLookup[Key][Type] then
                    return false;
                end
                -- Check type name by regex
                local TypeName = Logic.GetEntityTypeName(Type);
                if TypeName and (string.find(TypeName, "^S_") or string.find(TypeName, "^XD_")) then
                    Lib.EntitySearch.Shared.SearchEntitiesTypeLookup[Key][Type] = true;
                    return false;
                end
            end
            return true;
        end
        self:CreateFilter(Key, Function);
    end

    -- Return from cache or execute filter
    local Filter = self.Caches.Filter
    if Filter[Key] and Filter[Key][2] and Time - Filter[Key][1] <= 1 then
        return Filter[Key][2];
    end
    return self:IterateOverEntities(Key);
end

function Lib.EntitySearch.Shared:SearchEntitiesByScriptname(_Pattern)
    local Time = math.floor(Logic.GetTime());
    local Key = "name_".._Pattern;
    -- If filter doesn't exist, create it
    if not self.Filters[Key] then
        local Function = function(_ID)
            local ScriptName = Logic.GetEntityName(_ID);
            if not string.find(ScriptName, _Pattern) then
                return false;
            end
            return true;
        end
        self:CreateFilter(Key, Function);
    end

    -- Return from cache or execute filter
    local Filter = self.Caches.Filter
    if Filter[Key] and Filter[Key][2] and Filter[Key][1] +1 > Time then
        return Filter[Key][2];
    end
    return self:IterateOverEntities(Key);
end

function Lib.EntitySearch.Shared:SearchEntitiesInArea(_Area, _Position, _PlayerID, _Type, _Category)
    local Time = math.floor(Logic.GetTime());
    local Position = _Position;
    if type(Position) ~= "table" then
        Position = GetPosition(Position);
    end

    local a = _Area;
    local x,y = math.floor(Position.X / 100), math.floor(Position.Y / 100);
    local p = _PlayerID;
    local t = _Type;
    local c = _Category;
    local Key = "area_"..a.."_"..x.."_"..y.."_"..p.."_"..t.."_"..c;

    -- If filter doesn't exist, create it
    if not self.Filters[Key] then
        local Function = function(_ID)
            if _PlayerID and Logic.EntityGetPlayer(_ID) ~= _PlayerID then
                return false;
            end
            if _Type and _Type > 0 and Logic.GetEntityType(_ID) ~= _Type then
                return false;
            end
            if _Category and _Category > 0 and Logic.IsEntityInCategory(_ID, _Category) == 0 then
                return false;
            end
            if GetDistance(_ID, Position) > _Area then
                return false;
            end
            return true;
        end
        self:CreateFilter(Key, Function);
    end

    -- Return from cache or execute filter
    local Filter = self.Caches.Filter
    if Filter[Key] and Filter[Key][2] and Filter[Key][1] +1 > Time then
        return Filter[Key][2];
    end
    return self:IterateOverEntities(Key);
end

function Lib.EntitySearch.Shared:SearchEntitiesInTerritory(_Territory, _PlayerID, _Type, _Category)
    local Time = math.floor(Logic.GetTime());
    local a = _Territory;
    local p = _PlayerID;
    local t = _Type or "0";
    local c = _Category or "0";
    local Key = "teri_"..a.."_"..p.."_"..t.."_"..c;

    -- If filter doesn't exist, create it
    if not self.Filters[Key] then
        local Function = function(_ID)
            if _PlayerID and Logic.EntityGetPlayer(_ID) ~= _PlayerID then
                return false;
            end
            if _Type and _Type > 0 and Logic.GetEntityType(_ID) ~= _Type then
                return false;
            end
            if _Category and _Category > 0 and Logic.IsEntityInCategory(_ID, _Category) == 0 then
                return false;
            end
            if _Territory and GetTerritoryUnderEntity(_ID) ~= _Territory then
                return false;
            end
            return true;
        end
        self:CreateFilter(Key, Function);
    end

    -- Return from cache or execute filter
    local Filter = self.Caches.Filter
    if Filter[Key] and Filter[Key][2] and Filter[Key][1] +1 > Time then
        return Filter[Key][2];
    end
    return self:IterateOverEntities(Key);
end

-- -------------------------------------------------------------------------- --

RegisterModule(Lib.EntitySearch.Name);

