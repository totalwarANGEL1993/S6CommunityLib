--- Allows the creation of warehouses.
---
--- Warehouses are modified tradeposts where the player can buy goods without
--- an AI player involved. But goods can not be sold to the warehouse. Payment
--- can be set to any type of resource.

--- Defines a construction site for a trade post as a warehouse.
---
--- #### Fields `_Data`:
--- * `ScriptName`: <b>string</b> Script name of the construction site
--- * `Offers`:     <b>table</b> List of offers (max. 6 visible offers)
---
--- #### Fields `_Data.Offers`:
--- * `Amount`:      <b>integer</b> Number of offers
--- * `GoodType`:    <b>integer</b> Type of the offered good
--- * `GoodAmount`:  <b>integer</b> Amount of good per offer
--- * `PaymentType`: (optional) <b>integer</b> Type of payment (Default: Goods.G_Gold)
--- * `BasePrice`:   (optional) <b>integer</b> Cost
--- * `Refresh`:     (optional) <b>integer</b> Refresh time per offer
---
--- #### Example:
--- ```lua
--- CreateWarehouse {
---     ScriptName       = "TP3",
---     Offers           = {
---         -- Resource offer
---         {Amount      = 3,
---          GoodType    = Goods.G_Iron,
---          BasePrice   = 80},
---         -- Product offer
---         {Amount      = 3,
---          GoodType    = Goods.G_Sausage,
---          BasePrice   = 150},
---         -- Luxury offer
---         {Amount      = 3,
---          GoodType    = Goods.G_Gems,
---          GoodAmount  = 27,
---          BasePrice   = 300},
---         -- Entertainment offer
---         {GoodType    = Entities.U_Entertainer_NA_FireEater,
---          BasePrice   = 250,
---          Refresh     = 500},
---         -- Mercenary offer
---         {Amount      = 3,
---          GoodType    = Entities.U_MilitaryBandit_Melee_ME,
---          PaymentType = Goods.G_Iron,
---          BasePrice   = 3},
---         -- Mercenary offer
---         {Amount      = 3,
---          GoodType    = Entities.U_CatapultCart,
---          BasePrice   = 1000},
---     },
--- };
--- ```

--- @param _Data table Configuration of the warehouse
function CreateWarehouse(_Data)
end
API.CreateWarehouse = CreateWarehouse;

--- Creates an offer for the warehouse.
--- @param _Name string                     Script name of the warehouse
--- @param _Amount integer                  Number of offers
--- @param _GoodOrEntityType integer        Type of offered good or entity
--- @param __GoodOrEntityTypeAmount integer Amount of the good (only for goods)
--- @param _Payment integer                 Payment type (only resources)
--- @param _BasePrice integer               Base price without inflation
--- @param _Refresh integer                 Time until the offer reappears (0 = no respawn)
--- @return integer ID ID of the offer or 0 on error
function CreateWarehouseOffer(_Name, _Amount, _GoodOrEntityType, __GoodOrEntityTypeAmount, _Payment, _BasePrice, _Refresh)
    return 0;
end
API.CreateWarehouseOffer = CreateWarehouseOffer;

--- Removes the offer from the warehouse.
--- @param _Name string Script name of the warehouse
--- @param _ID integer ID of the offer
function RemoveWarehouseOffer(_Name, _ID)
end
API.RemoveWarehouseOffer = RemoveWarehouseOffer;

--- Deactivates the offer in the warehouse.
--- @param _Name string Script name of the warehouse
--- @param _ID integer ID of the offer
--- @param _Deactivate boolean Offer is deactivated
function DeactivateWarehouseOffer(_Name, _ID, _Deactivate)
end
API.DeactivateWarehouseOffer = DeactivateWarehouseOffer;

--- Returns the global inflation for the good or entity type.
--- @param _PlayerID integer Player ID
--- @param _GoodOrEntityType integer Offer type
--- @return number Inflation factor
function GetWarehouseInflation(_PlayerID, _GoodOrEntityType)
    return 0;
end
API.GetWarehouseInflation = GetWarehouseInflation;

--- Sets the global inflation for the good or entity type.
--- @param _PlayerID integer Player ID
--- @param _GoodOrEntityType integer Offer type
--- @param _Inflation number Inflation factor
function SetWarehouseInflation(_PlayerID, _GoodOrEntityType, _Inflation)
end
API.SetWarehouseInflation = SetWarehouseInflation;

--- Returns the data of the offer and the index in the offer array.
--- @param _Name string Script name of the warehouse
--- @param _ID integer ID of the offer
--- @return table Offer data of the offer
--- @return integer Index in the array
function GetWarehouseOfferByID(_Name, _ID)
    return {}, 0;
end
API.GetWarehouseOfferByID = GetWarehouseOfferByID;

--- Returns all active offers of the warehouse.
--- @param _Name string Script name of the warehouse
--- @param _VisibleOnly boolean Only visible offers
--- @return table Offers list of active offers
function GetActivWarehouseOffers(_Name, _VisibleOnly)
    return {};
end
API.GetActivWarehouseOffers = GetActivWarehouseOffers;

--- The player clicked on an offer.
---
--- #### Parameters:
--- * `PlayerID`      - ID of player
--- * `ScriptName`    - Scriptname of warehouse
--- * `Inflation`     - Calculated inflation
--- * `OfferIndex`    - Index of offer
--- * `OfferGood`     - Good or entity type purchased
--- * `GoodAmount`    - Amount of goods
--- * `PaymentType`   - Money good
--- * `BasePrice`     - Base price
Report.WarehouseOfferClicked = anyInteger;

--- The player bought an offer.
---
--- #### Parameters:
--- * `PlayerID`      - ID of player
--- * `ScriptName`    - Scriptname of warehouse
--- * `OfferGood`     - Good or entity type purchased
--- * `GoodAmount`    - Amount of goods
--- * `PaymentGood`   - Good of payment
--- * `PaymentAmount` - Amount of payment
Report.WarehouseOfferBought = anyInteger;

