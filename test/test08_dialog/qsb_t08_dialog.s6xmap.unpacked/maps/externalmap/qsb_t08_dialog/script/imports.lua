if CONST_IS_IN_DEV then
    Lib.Loader.PushPath("E:/Repositories/S6CommunityLib/lua/");
end

Lib.Require("comfort/GetDistance");
Lib.Require("comfort/ReplaceEntity");
Lib.Require("core/Core");
Lib.Require("module/quest/Quest");
Lib.Require("module/quest/QuestJornal");
Lib.Require("module/entity/NPC");
Lib.Require("module/information/BriefingSystem");
Lib.Require("module/information/CutsceneSystem");
Lib.Require("module/information/DialogSystem");
Lib.Require("module/information/Requester");
Lib.Require("module/settings/Sound");