

CMS_Rules = {
    Global = {
        OnGameStart = function(_RuleSet)
            Logic.SetMonthOffset(3);
        end,

        OnSessionStart = function(_RuleSet)
        end,
    },
    Local = {
        OnGameStart = function(_RuleSet)
        end,

        OnSessionStart = function(_RuleSet)
        end,
    },

    -- Stone walls can only be build at the home territory of the player
    RULE_STONE_WALLS_LIMITATION = true,

    -- Wooden walls can only be build on the home territory of the player
    -- or outposts they control
    RULE_WOODEN_WALLS_LIMITATION = true,

    -- A player using Hakim is handycapped by soldiers being 12% weaker.
    RULE_HAKIM_PLAYER_HANDYCAP = true,

    -- Beekeeper can not be placed close to any form of wall. Behives can 
    -- not be placed close to any form of wall. Walls can not be placed 
    -- close to beekeppers or beehives.
    RULE_BEEKEEPER_WALL_PROXIMITY = true,

    -- The player can only place wall catapults far apart from each other.
    RULE_WALL_CATAPULT_PROXIMITY = true,
};

