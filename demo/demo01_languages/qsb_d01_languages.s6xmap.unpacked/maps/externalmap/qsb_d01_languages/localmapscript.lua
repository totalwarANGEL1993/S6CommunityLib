-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||| --
-- ||||                          LOKALES SKRIPT                          |||| --
-- ||||                    --------------------------                    |||| --
-- ||||                              Demo 01                             |||| --
-- ||||                           totalwarANGEL                          |||| --
-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||| --

-- ========================================================================== --

GlobalPath = "maps/externalmap/" ..Framework.GetCurrentMapName() .."/";
LibPath = "maps/externalmap/" ..Framework.GetCurrentMapName() .."/";

CONST_IS_IN_DEV = false;
if CONST_IS_IN_DEV then
    GlobalPath = "E:/Repositories/S6CommunityLib/demo/demo01_languages/qsb_d01_languages.s6xmap.unpacked/" ..GlobalPath;
    LibPath = "E:/Repositories/";
end
Script.Load(LibPath.. "S6CommunityLib/lua/loader.lua");
Script.Load(GlobalPath.. "script/imports.lua");
Script.Load(GlobalPath.. "script/local_main.lua");

-- ========================================================================== --

function Mission_LocalOnMapStart()
end

function Mission_LocalVictory()
end