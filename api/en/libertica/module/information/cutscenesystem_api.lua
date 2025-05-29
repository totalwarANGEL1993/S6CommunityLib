--- Allows defining cutscenes.
---
--- Cutscenes are XML-defined camera movements that can be played by the
--- game engine. Cutscenes are characterized by smooth camera transitions.
---

--- Starts a cutscene.
---
--- Possible fields for the cutscene table:
--- * `Starting`                - Function called at the start of the cutscene              
--- * `Finished`                - Function called at the end of the cutscene                 
--- * `EnableGlobalImmortality` - All entities are invulnerable during the cutscene        
--- * `EnableSky`               - Show sky during the cutscene                   
--- * `EnableFoW`               - Show fog of war during the cutscene           
--- * `EnableBorderPins`        - Show border pins during the cutscene
--- * `HideNotes`               - Do not display messages
---
--- #### Example:
--- ```lua
--- function Cutscene1(_Name, _PlayerID)
---     local Cutscene = {};
---     local AP = API.AddCutscenePages(Cutscene);
---     -- Pages
---     Cutscene.Starting = function(_Data)
---     end
---     Cutscene.Finished = function(_Data)
---     end
---     API.StartCutscene(Cutscene, _Name, _PlayerID);
--- end
--- ```
---
--- @param _Cutscene table   Cutscene table
--- @param _Name string      Name of the cutscene
--- @param _PlayerID integer Player ID of the recipient
function StartCutscene(_Cutscene, _Name, _PlayerID)
end
API.StartCutscene = StartCutscene;

--- Asks the player for permission to change graphics settings.
---
--- If the BriefingSystem or DialogSystem is loaded, their functions are used instead.
---
--- This functionality is disabled in multiplayer.
function RequestCutsceneAlternateGraphics()
end
API.RequestCutsceneAlternateGraphics = RequestCutsceneAlternateGraphics;

--- Checks whether a cutscene is currently active.
--- @param _PlayerID integer Player ID of the recipient
--- @return boolean IsActive Cutscene is active
function IsCutsceneActive(_PlayerID)
    return true;
end
API.IsCutsceneActive = IsCutsceneActive;

--- Prepares the cutscene and returns the page function.
---
--- Must be called before pages are added.
--- @param _Cutscene table Cutscene table
--- @return function AP  Page function
function AddCutscenePages(_Cutscene)
    return function(...) end;
end
API.AddCutscenePages = AddCutscenePages;

--- Creates a page.
---
--- #### Fields `_Data`:
--- * `Flight`          <b>string</b> Name of the flight XML (without .cs)
--- * `Title`           (optional) <b>any</b> Displayed page title
--- * `Text`            (optional) <b>any</b> Displayed page text
--- * `Speech`          (optional) <b>string</b> Path to the voiceover (MP3 file)
--- * `Action`          (optional) <b>function</b> Function called when the page is shown
--- * `FarClipPlane`    (optional) <b>boolean</b>Rendering distance
--- * `FadeIn`          (optional) <b>float</b> Duration of fade-in from black
--- * `FadeOut`         (optional) <b>float</b> Duration of fade-out to black
--- * `FaderAlpha`      (optional) <b>float</b> Mask alpha
--- * `DisableSkipping` (optional) <b>boolean</b> Allow/disallow skipping of pages
--- * `BarOpacity`      (optional) <b>float</b> Opacity of the bars
--- * `BigBars`         (optional) <b>boolean</b> Use large cinematic bars
---
--- * `Flight`          - Name of the flight XML (without .cs)
--- * `Title`           - Displayed page title
--- * `Text`            - Displayed page text
--- * `Speech`          - Path to the voiceover (MP3 file)
--- * `Action`          - Function called when the page is shown
--- * `FarClipPlane`    - Rendering distance
--- * `FadeIn`          - Duration of fade-in from black
--- * `FadeOut`         - Duration of fade-out to black
--- * `FaderAlpha`      - Mask alpha
--- * `DisableSkipping` - Allow/disallow skipping of pages
--- * `BarOpacity`      - Opacity of the bars
--- * `BigBars`         - Use large cinematic bars
---
--- #### Example:
---
--- ```lua
--- AP {
---     Flight       = "c02",
---     FarClipPlane = 45000,
---     Title        = "Title",
---     Text         = "Flight text.",
--- };
--- ```
---
--- @param _Data table Page data
--- @return table Page Created page
function AP(_Data)
    return {};
end

