--- Allows defining dialogs.
---
--- Dialogs can be used to create conversations between characters using
--- animated heads in a function-stripped briefing.
---

--- Starts a dialog.
---
--- The dialog itself can have various attributes.
--- * `Starting`                - Function called when the dialog starts              
--- * `Finished`                - Function called when the dialog ends             
--- * `RestoreCamera`           - Camera position is saved and restored at the end of the dialog 
--- * `RestoreGameSpeed`        - Game speed is saved and restored at the end of the dialog      
--- * `EnableGlobalImmortality` - All units are invulnerable during the dialog       
--- * `EnableSky`               - Show sky during the dialog                  
--- * `EnableFoW`               - Show fog of war during the dialog          
--- * `EnableBorderPins`        - Show border pins during the dialog
--- * `HideNotes`               - Do not display messages
---
--- #### Example
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
--- The page can have various attributes.
--- * `Actor`      - (optional) Player ID of the speaker
--- * `Title`      - (optional) Name of the actor (only with Actor)
--- * `Text`       - (optional) Displayed page text
--- * `Speech`     - Path to the voiceover (MP3 file)
--- * `Position`   - Camera position (not with Target)
--- * `Target`     - Entity the camera follows (not with Position)
--- * `Distance`   - (optional) Camera distance
--- * `Action`     - (optional) Function called when the page is shown
--- * `FadeIn`     - (optional) Duration of fade-in from black
--- * `FadeOut`    - (optional) Duration of fade-out to black
--- * `FaderAlpha` - (optional) Mask alpha
--- * `MC`         - (optional) Table with options for branching dialogs
---
--- #### Example:
--- Create a simple page.
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
function AP(_Data)
end

--- Creates a page in a simplified way.
---
--- The function can automatically generate a page name based on the page index.
--- A name can be optionally provided as the first parameter.
---
--- #### Settings
--- The function expects the following parameters:
--- 
--- * `Name`         - (Optional) Name of the page
--- * `Sender`       - Player ID of the actor
--- * `Target`       - Entity the camera focuses on
--- * `Title`        - Displayed page title
--- * `Text`         - Displayed page text
--- * `DialogCamera` - Use dialog close-up camera
--- * `Action`       - (Optional) Action when the page is shown
---
--- #### Example:
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
--- @param ... any List of page settings
function ASP(...)
end

