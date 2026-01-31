-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||| --
-- ||||                          LOKALES SKRIPT                          |||| --
-- ||||                    --------------------------                    |||| --
-- ||||                            Testmap 22                            |||| --
-- ||||                           totalwarANGEL                          |||| --
-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||| --

-- ========================================================================== --

CONST_IS_IN_DEV = true;
local Path = "maps/externalmap/qsb_t22_supermarket/script/local_main.lua";
if CONST_IS_IN_DEV then
    Path = "D:/Projects/Settlers/libertica/test/test22_supermarket/qsb_t22_supermarket.s6xmap.unpacked/" ..Path;
end
Script.Load(Path);

function Mission_LocalOnMapStart()
end

function Mission_LocalVictory()
end