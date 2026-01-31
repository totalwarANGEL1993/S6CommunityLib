if CONST_IS_IN_DEV then
    Lib.Loader.PushPath("D:/Projects/Settlers/S6CommunityLib/lua/");
end

Lib.Require("core/Core");
Lib.Require("module/quest/Quest");
Lib.Require("module/entity/NPC");
Lib.Require("module/io/IO");
Lib.Require("module/io/IOChest");
Lib.Require("module/io/IOMine");
Lib.Require("module/ui/UIBuilding");
Lib.Require("module/faker/Technology");
Lib.Require("module/trade/Warehouse");
Lib.Require("module/city/Promotion");