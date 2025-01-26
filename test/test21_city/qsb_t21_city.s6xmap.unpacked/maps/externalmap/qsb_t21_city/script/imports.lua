if CONST_IS_IN_DEV then
    Lib.Loader.PushPath("E:/Repositories/libertica/release/");
end

Lib.Require("comfort/KeyOf");
Lib.Require("comfort/GetPredatorSpawnerTypes");
Lib.Require("comfort/GetSiegeengineTypeByCartType");
Lib.Require("comfort/GetSiegecartTypeByEngineType");
Lib.Require("comfort/HexToColor");
Lib.Require("comfort/IsValidPosition");
Lib.Require("core/Core");
Lib.Require("module/city/Promotion");
Lib.Require("module/city/Construction");
Lib.Require("module/city/LifestockSystem");
Lib.Require("module/mode/SettlementSurvival");
Lib.Require("module/entity/EntitySelection");
Lib.Require("module/balancing/Damage");
Lib.Require("module/quest/Quest");
Lib.Require("module/mode/SettlementLimitation");
Lib.Require("module/entity/EntitySearch");
Lib.Require("module/trade/Warehouse");
Lib.Require("module/information/Requester");
Lib.Require("module/ui/UIBuilding");