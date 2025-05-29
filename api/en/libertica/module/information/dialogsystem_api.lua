--- Allows defining dialogs.
---
--- Dialogs can be used to create conversations between characters using
--- animated heads in a function-stripped briefing.
---



--- Starts a dialog.
---
--- Possible fields for the dialog table:
--- * `Starting`                - Function called when dialog is started              
--- * `Finished`                - Function called when dialog is finished             
--- * `RestoreCamera`           - Camera position is saved and restored at dialog end 
--- * `RestoreGameSpeed`        - Game speed is saved and restored at dialog end      
--- * `EnableGlobalImmortality` - During dialogs all entities are invulnerable        
--- * `EnableSky`               - Display the sky during the dialog                   
--- * `EnableFoW`               - Displays the fog of war during the dialog           
--- * `EnableBorderPins`        - Displays the border pins during the dialog
--- * `HideNotes`               - Do not show notes
---
--- #### Example:
---
--- ```lua
--- function Dialog1(_Name, _PlayerID)
---     local Dialog = {
---         DisableFow = true,
---         DisableBoderPins = true,
---     };
---     local AP, ASP = API.AddDialogPages(Dialog);
---     -- Pages
---     Dialog.Starting = function(_Data)
---     end
---     Dialog.Finished = function(_Data)
---     end
---     API.StartDialog(Dialog, _Name, _PlayerID);
--- end
--- ```
---
--- @param _Dialog table     Dialog table
--- @param _Name string      Name of the dialog
--- @param _PlayerID integer Player ID of the recipient
function StartDialog(_Dialog, _Name, _PlayerID)
end
API.StartDialog = StartDialog;

--- Asks the player for permission to change graphics settings.
---
--- If the BriefingSystem is loaded, its functionality is used.
---
--- This functionality is disabled in multiplayer.
function RequestDialogAlternateGraphics()
end
API.RequestDialogAlternateGraphics = RequestDialogAlternateGraphics;

--- Checks if a dialog is active.
--- @param _PlayerID integer Player ID of the recipient
--- @return boolean IsActive Dialog is active
function IsDialogActive(_PlayerID)
    return true;
end
API.IsDialogActive = IsDialogActive;

--- Prepares the dialog and returns the page functions.
---
--- Must be called before adding pages.
--- @param _Dialog table Dialog table
--- @return function AP  Page function
--- @return function ASP Simple page function
function AddDialogPages(_Dialog)
    return function(...) end, function(...) end
end
API.AddDialogPages = AddDialogPages;

--- Creates a page.
---
--- #### Fields `_Data`:
--- * `Actor`:      (optional) <b>integer</b> Player ID of actor
--- * `Title`:      (optional) <b>any</b> Name of actor (only with actor)
--- * `Text`:       (optional) <b>any</b> Displayed text (string or language table)
--- * `Speech`:     <b>string</b> Pfad zum Voiceover (MP3 file)
--- * `Position`:   <b>string</b> Position of camera (not with target)
--- * `Target`:     <b>string</b> Unit camera follows (not with position)
--- * `Distance`:   (optional) <b>float</b> Distance of camera
--- * `Action`:     (optional) <b>function</b> Function called when page is shown
--- * `FadeIn`:     (optional) <b>float</b> Duration of fade-in from black
--- * `FadeOut`:    (optional) <b>float</b> Duration of fade-out to black
--- * `FaderAlpha`: (optional) <b>float</b> Mask alpha
--- * `MC`:         (optional) <b>table</b> Table with choices for branching dialogues
--- 
--- #### Fields `_Data.MC`:
--- * `[1]`: <b>any</b> Displayed text (string oder language table)
--- * `[2]`: <b>any</b> Jump target (string or function)
---
--- * `Actor`           - (optional) PlayerID of speaker
--- * `Title`           - (optional) Name of actor (only with actor)
--- * `Text`            - (optional) Displayed page text
--- * `Speech`          - Path to voiceover (MP3 file)
--- * `Position`        - Position of camera (not with target)
--- * `Target`          - Entity the camera follows (not with position)
--- * `Distance`        - (optional) Distance of camera
--- * `Action`          - (optional) Function called when page is displayed
--- * `FadeIn`          - (optional) Duration of fadein from black
--- * `FadeOut`         - (optional) Duration of fadeout to black
--- * `FaderAlpha`      - (optional) Mask alpha
--- * `MC`              - (optional) Table with choices to branch of in dialogs
---
--- *→ Example #1*
---
--- #### Flow control
--- In a dialog the player can be forced to make a choice that will have
--- different results. That is called multiple choice. Options must be provided
--- in a table. The target page can be defined with it's name or a function can
--- be provided for more control over the flow. Such funktions must return a
--- page name.
---
--- *→ Example #2*
---
--- Additionally each function can be marked to be removed when used
--- and not shown again when reentering the page.
---
--- *→ Example #3*
---
--- Also pages can be hidden by providing a function to check conditions.
---
--- *→ Example #4*
---
--- If a dialog is branched it must be manually ended after a branch is done
--- or it just simply shows the next page. To end a dialog, an empty page
--- must be added.
---
--- *→ Example #5*
---
--- Alternativly the dialog can continue at a different page. This allows to
--- create repeating structures within a dialog.
---
--- *→ Example #6*
---
--- To obtain selected answers at a later point the selection can be saved in a
--- global variable either in a option callback or in the finished function. The
--- number returned is the ID of the answer.
---
--- *→ Example #7*
---
--- #### Examples
---
--- * Example #1: A simple page
--- ```lua
--- AP {
---    Title        = "Marcus",
---    Text         = "This is a simple page.",
---    Actor        = 1,
---    Duration     = 2,
---    FadeIn       = 2,
---    Position     = "npc1",
---    DialogCamera = true,
--- };
--- ```
---
--- #### Example:
--- Create a multiple choice page.
--- ```lua
--- AP {
---    Title        = "Marcus",
---    Text         = "This is not such a simple page.",
---    Actor        = 1,
---    Duration     = 2,
---    FadeIn       = 2,
---    Position     = "npc1",
---    DialogCamera = true,
---    MC = {
---        {"Option 1", "Option1"},
---        {"Option 2", "Option2"},
---    },
--- };
--- 
--- -- The branches in a briefing must be separated by an empty page
--- -- so the briefing knows it's done here.
--- ASP("Option1", "First Option", "This is the first option.", false, "Marcus");
--- AP();
--- ASP("Option2", "Second Option", "This is the second option.", false, "Marcus");
--- ```
---
--- #### Example:
--- The jump target of an option can be determined by a function.
--- ```lua
--- AP {
---    Title        = "Marcus",
---    Text         = "This is not such a simple page.",
---    Actor        = 1,
---    Duration     = 2,
---    FadeIn       = 2,
---    Position     = "npc1",
---    DialogCamera = true,
---    MC = {
---        {"Option 1", "Option1"},
---        {"Option 2", ForkingFunction},
---    },
--- };
--- ```
---
--- @param _Data table Seitendaten
--- @return table Erzeugte Seite
function AP(_Data)
    return {};
end

--- Creates a page in a simplified way.
---
--- The function can automatically generate a page name based on the page index.
--- A name can be optionally provided as the first parameter.
---
--- #### Example:
--- ```lua
--- -- Wide shot
--- ASP("Title", "Some important text.", false, "HQ");
--- -- With page name
--- ASP("Page1", "Title", "Some important text.", false, "HQ");
--- -- Close-up
--- ASP("Title", "Some important text.", true, "Marcus");
--- -- Triggering an action
--- ASP("Title", "Some important text.", true, "Marcus", MyFunction);
--- -- Allowing/disallowing skip
--- ASP("Title", "Some important text.", true, "HQ", nil, true);
--- ```
---
--- @param _Name? string Name of page
--- @param _Sender integer Player ID of actor
--- @param _Target string Entity the camera focuses on
--- @param _Title string Displayed page title
--- @param _Text string Displayed page text
--- @param _DialogCamera boolean Use dialog close-up camera
--- @param _Action? boolean Action when the page is shown
--- @return table Page Created page
function ASP(...)
    return {};
end

