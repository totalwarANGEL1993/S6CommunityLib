-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||| --
-- ||||                          LOKALES SKRIPT                          |||| --
-- ||||                    --------------------------                    |||| --
-- ||||                            Testmap 22                            |||| --
-- ||||                           totalwarANGEL                          |||| --
-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||| --

-- ========================================================================== --

if CONST_IS_IN_DEV then
    Script.Load("D:/Projects/Settlers/libertica/var/libertica/librarian.lua");
    Lib.Loader.PushPath("D:/Projects/Settlers/libertica/var/");
else
    Script.Load("maps/externalmap/qsb_t22_supermarket/libertica/librarian.lua");
end
Lib.Require("comfort/KeyOf");
Lib.Require("core/Core");
Lib.Require("module/entity/EntitySelection");
Lib.Require("module/mode/SettlementSurvival");

-- ========================================================================== --

function GameCallback_Lib_LoadingFinished()
end

