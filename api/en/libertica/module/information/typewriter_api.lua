--- ...
---
Lib.Typewriter = Lib.Typewriter or {};



--- Displays a text byte by byte.
---
--- If used at game start the text starts, after the map is loaded. If another
--- cinema event is running the typewriter waits for completion.
---
--- Controll symbols like {cr} are evaluated as one token and are handled as
--- an atomic token and are displayed immedaitly. More than 1 space in a row
--- is atomaticaly trunk to 1 space (by the game engine).
---
--- #### Fields of table
--- * Text         - Text to display
--- * Name         - (Optional) Name for event
--- * PlayerID     - (Optional) Player text is shown
--- * Callback     - (Optional) Callback function
--- * TargetEntity - (Optional) Entity camera is focused on
--- * CharSpeed    - (Optional) Factor of typing speed (default: 1.0)
--- * Waittime     - (Optional) Initial waittime before typing
--- * Opacity      - (Optional) Opacity of background (default: 1.0)
--- * Color        - (Optional) Background color (default: {R= 0, G= 0, B= 0})
--- * Image        - (Optional) Background image (needs to be 16:9 ratio)
---
--- #### Examples
--- ```lua
--- local EventName = StartTypewriter {
---     PlayerID = 1,
---     Text     = "Lorem ipsum dolor sit amet, consetetur "..
---                "sadipscing elitr, sed diam nonumy eirmod "..
---                "tempor invidunt ut labore et dolore magna "..
---                "aliquyam erat, sed diam voluptua.",
---     Callback = function(_Data)
---     end
--- };
--- ```
---
--- @param _Data table Data table
--- @return string? EventName Name of event
function StartTypewriter(_Data)
    return "";
end
API.StartTypewriter = StartTypewriter;

