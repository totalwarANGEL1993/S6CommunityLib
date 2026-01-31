-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||| --
-- ||||                          LOKALES SKRIPT                          |||| --
-- ||||                    --------------------------                    |||| --
-- ||||                            Testmap 11                            |||| --
-- ||||                           totalwarANGEL                          |||| --
-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||| --

-- ========================================================================== --

GlobalPath = "maps/externalmap/" ..Framework.GetCurrentMapName() .."/";
LibPath = "maps/externalmap/" ..Framework.GetCurrentMapName() .."/";

CONST_IS_IN_DEV = true;
if CONST_IS_IN_DEV then
    GlobalPath = "D:/Projects/Settlers/libertica/test/test11_shiptrade/qsb_t11_shiptrade.s6xmap.unpacked/" ..GlobalPath;
    LibPath = "D:/Projects/Settlers/libertica/release/";
end
Script.Load(LibPath.. "libertica/librarian.lua");
Script.Load(GlobalPath.. "/script/imports.lua");
Script.Load(GlobalPath.. "/script/local_main.lua");

-- ========================================================================== --

function Mission_LocalOnMapStart()
end

function Mission_LocalVictory()
end

