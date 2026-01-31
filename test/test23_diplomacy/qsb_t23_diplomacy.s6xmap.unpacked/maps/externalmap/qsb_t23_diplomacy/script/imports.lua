if CONST_IS_IN_DEV then
    Lib.Loader.PushPath("D:/Projects/Settlers/S6CommunityLib/lua/");
end

Lib.Require("comfort/KeyOf");
Lib.Require("core/Core");
Lib.Require("module/entity/EntitySelection");
Lib.Require("module/mode/SettlementSurvival");
Lib.Require("module/quest/QuestBehavior");
Lib.Require("module/information/Requester");