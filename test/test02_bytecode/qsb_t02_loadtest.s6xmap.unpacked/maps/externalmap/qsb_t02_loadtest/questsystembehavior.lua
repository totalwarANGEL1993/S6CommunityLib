CONST_IS_IN_DEV = true;
local Path = "maps/externalmap/qsb_t02_bytecode/";
if CONST_IS_IN_DEV then
    Path = "D:/Projects/Settlers/libertica/release/";
end
Script.Load(Path.. "s6communitylib/lua/loader.lua");