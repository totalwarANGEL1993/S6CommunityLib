-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||| --
-- ||||                          LOKALES SKRIPT                          |||| --
-- ||||                    --------------------------                    |||| --
-- ||||                            Testmap 08                            |||| --
-- ||||                           totalwarANGEL                          |||| --
-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||| --

-- ========================================================================== --

GlobalPath = "maps/externalmap/" ..Framework.GetCurrentMapName() .."/";
LibPath = "maps/externalmap/" ..Framework.GetCurrentMapName() .."/";

CONST_IS_IN_DEV = true;
if CONST_IS_IN_DEV then
    GlobalPath = "D:/Projects/Settlers/S6CommunityLib/test/test08_dialog/qsb_t08_dialog.s6xmap.unpacked/" ..GlobalPath;
    LibPath = "D:/Projects/Settlers/";
end
Script.Load(LibPath.. "S6CommunityLib/lua/loader.lua");
Script.Load(GlobalPath.. "script/imports.lua");
Script.Load(GlobalPath.. "script/local_main.lua");

-- ========================================================================== --

function Mission_LocalOnMapStart()
end

function Mission_LocalVictory()
end

