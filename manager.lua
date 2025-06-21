LibWriter = {
    ComponentList = {
        "core/QSB",
        "core/Core",
        "module/diplomacy/Diplomacy",
        "module/city/Construction",
        "module/entity/NPC",
        "module/settings/Sound",
        "module/city/Promotion",
        "module/io/IO",
        "module/io/IOChest",
        "module/io/IOMine",
        "module/quest/Quest",
        "module/quest/QuestBehavior",
        "module/quest/QuestJornal",
        "module/faker/Permadeath",
        "module/faker/Technology",
        "module/trade/Warehouse",
        "module/settings/Camera",
        "module/ui/UITools",
        "module/ui/UIEffects",
        "module/ui/UIBuilding",
        "module/mode/SettlementSurvival",
        "module/mode/SettlementLimitation",
        "module/information/Information",
        "module/information/Typewriter",
        "module/information/BriefingSystem",
        "module/information/CutsceneSystem",
        "module/information/DialogSystem",
        "module/city/LifestockSystem",
        "module/city/MilitiaSystem",
        "module/entity/EntityEvent",
        "module/entity/EntitySelection",
        "module/fix/Damage",
        "module/fix/Patch",
        "module/information/Requester",
        "module/entity/EntitySearch",
        "module/trade/Trade",
        "module/trade/TradeRoute",
    },
    FileReadLookup = {},
    Compile = false,
    LoadOrderFromFile = false,
    SingleFile = false,
}

--- Runs the build process.
--- @param ... unknown Program arguments
function LibWriter:Run(...)
    local Action = self:ProcessArguments();
    if Action == 0 then
        print("Usage:");
        print("-b [-c] [-s] [-o] [Files] - build library in var/libertica");
        print("                            * -c compiles files to bytecode");
        print("                            * -s creates a single file version");
        print("                            * -o loadorder from following wile");
        print("-l [-o] [Files]           - alphabetical list of loaded dependencies");
        print("-h                        - show this help");
        return;
    end

    if Action == 1 then
        os.execute('rm -rf var');
        if self.SingleFile then
            os.execute('mkdir "var"');
            os.execute('cp "license.md" "var/license.md');
            self:CreateSingleFile();
        else
            os.execute('mkdir "var/libertica"');
            os.execute('cp "license.md" "var/license.md');
            self:CopyModules();
            self:CreateQsb();
        end
    elseif Action == 2 then
        local Files = self:ReadFilesLoop();
        print("Files loaded (" ..(#Files).. "):");
        for i= 1, #Files do
            print("> (" ..i.. ") " ..Files[i]:lower());
        end
    end
end

--- Takes the programm arguments and processes them as source paths.
--- * 0  Arguments: Take default component list
--- * 1  Argument:  Load list from file
--- * 2+ Arguments: Load as components in this order
function LibWriter:ProcessArguments()
    if #arg > 0 then
        local Command = table.remove(arg, 1);
        local Parameter = arg;
        if Command == "-b" or Command == "build" then
            -- Compile?
            Command = arg[1];
            if Command and Command == "-c" then
                self.Compile = true;
                table.remove(arg, 1);
            end
            -- Single file?
            Command = arg[1];
            if Command and Command == "-s" then
                self.SingleFile = true;
                table.remove(arg, 1);
            end
            -- load order from file?
            Command = arg[1];
            if Command and Command == "-o" then
                self.LoadOrderFromFile = true;
                table.remove(arg, 1);
            end

            if #Parameter > 0 then
                if self.LoadOrderFromFile then
                    self.ComponentList = self:GetLoadOrderFromFile(Parameter[1]);
                else
                    self.ComponentList = Parameter;
                end
            end
            return 1;
        elseif Command == "-l" or Command == "list" then
            -- load order from file?
            Command = arg[1];
            if Command and Command == "-o" then
                self.LoadOrderFromFile = true;
                table.remove(arg, 1);
            end

            if #Parameter > 0 then
                if self.LoadOrderFromFile then
                    self.ComponentList = self:GetLoadOrderFromFile(Parameter[1]);
                else
                    self.ComponentList = Parameter;
                end
            end
            return 2;
        end
    end
    return 0;
end

--- Creates a single file version of the library.
function LibWriter:CreateSingleFile()
    local code = "";
    local fh, behaviors, content;

    -- Read loader mock
    fh = assert(io.open("loadersf.lua", "rb"));
    content = fh:read("*all");
    code = code .. content;
    fh:close();

    -- Read components
    local imports = self:ReadFilesLoop();
    for i= 1, #imports do
        fh = assert(io.open("lua/" ..imports[i].. ".lua", "rb"));
        content = fh:read("*all");
        code = code .. content;
        fh:close();
    end

    -- Read behaviors (obsolete)
    -- behaviors = self:ConcatBehaviors(true);
    -- code = code .. behaviors;

    -- Create file
    fh = assert(io.open("var/qsb.lua", "wb"));
    fh:write(code);
    fh:close();
    -- Editor can't read binary
    -- self:CompileFile('var/qsb.lua', 'var/qsb.lua');

    os.execute('cp "lua/core/mapscript_sf.lua" "var/mapscript.lua');
    os.execute('cp "lua/core/localmapscript_sf.lua" "var/localmapscript.lua');
end

--- Copies the module files with dependencies to the output folder.
function LibWriter:CopyModules()
    os.execute('cp "loader.lua" "var/libertica/librarian.lua');
    self:CompileFile('var/libertica/librarian.lua', 'var/libertica/librarian.lua');

    local imports = self:ReadFilesLoop();
    for i= 1, #imports, 1 do
        local index = string.find(imports[i], "/[^/]*$");
        local Path = 'var/libertica/'..imports[i]:sub(1, index-1);
        local File = imports[i]:sub(index+1):lower();
        if not self:IsDir(Path) then
            os.execute('mkdir "'..Path..'"');
        end
        os.execute('cp "lua/'..imports[i]..'.lua" "'..Path..'/'..File..'.lua"');
        self:CompileFile('"lua/'..imports[i]..'.lua"', Path.. '/' ..File.. '.lua');
    end
end

--- Concatinates all behavior.lua files in all active modules,
--- creates the QSB and writes it to output folder.
function LibWriter:CreateQsb()
    local behaviors = self:ConcatBehaviors();
    if behaviors ~= "" then
        local fh = assert(io.open("var/libertica/qsb.lua", "wb"));
        fh:write(behaviors);
        fh:close();
    end
    -- Editor can't read binary
    -- self:CompileFile('var/libertica/qsb.lua', 'var/libertica/qsb.lua');

    os.execute('cp "lua/core/mapscript.lua" "var/libertica/mapscript.lua');
    os.execute('cp "lua/core/localmapscript.lua" "var/libertica/localmapscript.lua');
end

--- Reads all behavior files from the components and returns them as lua string.
function LibWriter:ConcatBehaviors(_SingleFile)
    local fh, index, content, template;
    local behaviors = "";
    if _SingleFile then
        fh = assert(io.open("lua/core/qsb.lua", "rb"));
        template = fh:read("*all");
        fh:close();
        behaviors = template;
        for i= 1, #self.ComponentList do
            if self.ComponentList[i]:len() > 0 then
                local File = "lua/" ..self.ComponentList[i]:lower() .. "_behavior.lua";
                fh = io.open(File, "rb");
                if fh ~= nil then
                    content = fh:read("*all");
                    -- Debug
                    -- print("reading behavior file: " ..File, content:len().. " bytes")
                    fh:close();
                else
                    content = "";
                    -- Debug
                    -- print("reading behavior file: " ..File, content:len().. " bytes")
                end
                behaviors = behaviors .. content;
            end
        end
    end
    return behaviors;
end

function LibWriter:ReadFilesLoop()
    local TreeList = {};
    for i= 1, #self.ComponentList, 1 do
        if self.ComponentList[i]:len() > 0 then
            self:CreateDependencyTree(self.ComponentList[i], TreeList);
        end
    end

    local Tree = {"core/qsb", TreeList};
    local NameList = {};
    self:FlattenDependencyTree(Tree, NameList);
    for i= #NameList, 1, -1 do
        if NameList[i] == "core/qsb" then
            table.remove(NameList, i);
        end
    end
    table.insert(NameList, 1, "core/qsb");
    return NameList;
end

function LibWriter:FlattenDependencyTree(_Tree, _NameList)
    for i= 1, #_Tree[2] do
        self:FlattenDependencyTree(_Tree[2][i], _NameList);
    end
    if not self:InTable(_Tree[1]:lower(), _NameList) then
        table.insert(_NameList, _Tree[1]:lower());
    end
end

function LibWriter:CreateDependencyTree(_Name, _TreeList)
    local Entry = {_Name, {}};
    if not self.FileReadLookup[_Name:lower()] then
        self.FileReadLookup[_Name:lower()] = true;
        for line in io.lines("lua/" .._Name:lower().. ".lua") do
            if line:find("Lib%.Register%(") then
                break;
            end
            local s,e = line:find("Lib%.Require%(\".*\"");
            if s and s > 0 then
                table.insert(Entry[2], {line:sub(s+13, e-1):lower(), {}});
            end
        end
    end
    for i= 1, #Entry[2] do
        self:CreateDependencyTree(Entry[2][i][1], _TreeList);
    end
    table.insert(_TreeList, Entry);
end

function LibWriter:InTable(_Entry, _Table)
    for i= 1, #_Table do
        if _Table[i] == _Entry then
            return true;
        end
    end
    return false;
end

--- Returns if the file is an directory.
--- @param _File string Path to file
--- @return boolean IsDir File is directory
function LibWriter:IsDir(_File)
    return self:FileExists(_File.. "/");
end

--- Checks if the file does exist.
--- @param _File string Path to file
--- @return boolean Exists File does exist
--- @return string? Error Optional error text
function LibWriter:FileExists(_File)
    local ok, err, code = os.rename(_File, _File);
    if not ok then
        if code == 13 then
            return true;
        end
    end
    return ok, err;
end

--- Compiles the source file and moves it to the destination.
--- @param _Source string Source file location
--- @param _Dest string   Destination location
function LibWriter:CompileFile(_Source, _Dest)
    if self.Compile then
        os.execute('luac "'.._Source..'"');
        os.execute('mv "luac.out" "'.._Dest..'"');
    end
end

--- Reads the load order from a file.
--- @param _Path string File location
--- @return table List List of modules
function LibWriter:GetLoadOrderFromFile(_Path)
    local Paths = {};
    if self:FileExists(_Path) then
        for line in io.lines(_Path:lower()) do
            table.insert(Paths, line);
        end
    end
    return Paths;
end

-- -------------------------------------------------------------------------- --

LibWriter:Run(unpack(arg));

