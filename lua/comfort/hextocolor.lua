Lib.Register("comfort/HexToColor");

function HexToColor(_Hex)
    local hex = string.gsub(_Hex, "#", "");
    if string.len(hex) ~= 6 and string.len(hex) ~= 8 then
        return 0, 0, 0, 0;
    end
    local r = tonumber(string.sub(hex, 1, 2), 16);
    local g = tonumber(string.sub(hex, 3, 4), 16);
    local b = tonumber(string.sub(hex, 5, 6), 16);
    local a = 255;
    if string.len(hex) == 8 then
        a = tonumber(string.sub(hex, 7, 8), 16);
    end
    if not a or not g or not b or not a then
        return 0, 0, 0, 0;
    end
    return r, g, b, a;
end

