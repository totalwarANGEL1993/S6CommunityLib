--- Enables the definition of introductions.
---
--- The pinnacle for scripting dialogues and simple camera animations.
--- A versatile tool for scripting map presentations.
--- 
--- #### Options for Briefings
--- 
--- <p><b><u>Standard</u></b></p>
--- <p>
--- Briefings consist of pages that display text and are scenically staged
--- with a camera frame. A page is created using the function AP.
--- ```lua
--- AP {
---    Title        = "Marcus",
---    Text         = "This is a simple page.",
---    Position     = "Marcus",
---    Rotation     = 30,
---    DialogCamera = true,
--- };
--- ```
---
--- <p><b><u>Simplified</u></b></p>
--- <p>
--- The function ASP can be used to write simplified pages.
--- ```lua
--- ASP("Title", "Page text", false, "HQ");
--- ```
--- 
--- <p><b><u>Parallax</u></b></p>
--- <p>
--- A page can display up to 6 animated parallaxes — full-screen
--- graphics. With UV coordinates, sections of the graphics can be shown.
--- This allows for creating rudimentarily animated scenes.
--- ```lua
--- Briefing.PageParallax = {
---     ["Page1"] = {
---         {"maps/externalmap/mapname/graphics/sea.png", 60,
---          {0, 0, 0.8, 1, 255},
---          {0.2, 0, 1, 1, 255}},
---     },
--- };
--- ```
--- 
--- Several switches can be added to the parallax definition that affect
--- the behavior of the parallaxes.
--- * `Clear`  - All running parallaxes are cleared. Then the new ones are started.
--- * `Repeat` - The parallaxes start over after finishing.
--- 
--- <p><b><u>Animated</u></b></p>
--- <p>
--- It's possible to separate camera animations from the pages. This
--- allows for smoother text writing and implementing more complex movements.
--- 
--- Animations are defined in the table `Briefing.PageAnimation`. A page can
--- contain multiple animation sets. An animation set consists of
--- 2 or 4 directional vectors. A directional vector consists of the position
--- and the look-at direction. Vectors are created using `GetFrameVector`.
--- ```lua
--- Briefing.PageAnimation = {
---     ["Page1"] = {
---         {30, {GetFrameVector("pos1", 500, "pos2", -3000)},
---              {GetFrameVector("pos3", 500, "pos4", -3000)},
---              {GetFrameVector("pos7", 500, "pos8", -3000)},
---              {GetFrameVector("pos5", 500, "pos6", -3000)}},
---     },
--- };
--- ```
--- 
--- With the function ASP, pages can be created without camera definitions.
--- It's important that the name of the page in the briefing is unique.
--- When the page is reached, the animation sets are started.
--- ```lua
--- ASP("Page1", "Title", "This page is animated.");
--- ```
--- 
--- Several switches can be added to the animation definition that affect
--- the behavior of the animations.
--- * `Clear`    - All running animation sets are cleared. Then the new sets are started.
--- * `Repeat`   - The animation sets start over after finishing.
--- * `Postpone` - The running animation sets are postponed, and the sets of the page are started.
--- * `Local`    - The animation sets are played only on this page.



--- Starts a briefing.
--- 
--- The briefing itself can have various attributes:
--- * `Starting`                - Function called when the introduction starts              
--- * `Finished`                - Function called when the introduction ends             
--- * `RestoreCamera`           - Camera position is saved and restored after the introduction
--- * `RestoreGameSpeed`        - Game speed is saved and restored after the introduction      
--- * `EnableGlobalImmortality` - All entities are invulnerable during the introduction        
--- * `EnableSky`               - Shows the sky during the introduction                   
--- * `EnableFoW`               - Shows the fog of war during the introduction 
--- * `EnableBorderPins`        - Shows border pins during the introduction     
--- * `PreloadAssets`           - Allows a wide field of view during briefings
--- * `HideNotes`               - Hides messages
---
--- #### Example:
--- ```lua
--- function Briefing1(_Name, _PlayerID)
---     local Briefing = {};
---     local AP, ASP = AddBriefingPages(Briefing);
---     -- Pages
---     Briefing.Starting = function(_Data)
---     end
---     Briefing.Finished = function(_Data)
---     end
---     StartBriefing(Briefing, _Name, _PlayerID);
--- end
--- ```
---
--- @param _Briefing table   Briefing table
--- @param _Name string      Name of the briefing
--- @param _PlayerID integer ID of the player receiving the briefing
function StartBriefing(_Briefing, _Name, _PlayerID)
end
API.StartBriefing = StartBriefing;

--- Asks the player for permission to change graphics settings.
---
--- This functionality is disabled in multiplayer.
function RequestBriefingAlternateGraphics()
end
API.RequestBriefingAlternateGraphics = RequestBriefingAlternateGraphics;

--- Checks whether a briefing is currently active.
--- @param _PlayerID integer ID of the player
--- @return boolean IsActive true if a briefing is active
function IsBriefingActive(_PlayerID)
    return true;
end
API.IsBriefingActive = IsBriefingActive;

--- Creates a point from a position.
--- @param _Entity any      Target entity
--- @param _ZOffset integer Z offset (≠ 0 overrides Z)
--- @return number X X-coordinate
--- @return number Y Y-coordinate
--- @return number Z Z-coordinate
function GetFramePosition(_Entity, _ZOffset)
    return 0, 0, 0;
end

--- Creates a vector from 2 positions.
--- @param _Entity1 any      Source position entity
--- @param _ZOffset1 integer Z offset for position (≠ 0 overrides Z)
--- @param _Entity2 any      Target look-at entity
--- @param _ZOffset2 integer Z offset for look-at (≠ 0 overrides Z)
--- @return number X1        X-coordinate of position
--- @return number Y1        Y-coordinate of position
--- @return number Z1        Z-coordinate of position
--- @return number X2        X-coordinate of look-at
--- @return number Y2        Y-coordinate of look-at
--- @return number Z2        Z-coordinate of look-at
function GetFrameVector(_Entity1, _ZOffset1, _Entity2, _ZOffset2)
    return 0, 0, 0, 0, 0, 0;
end

--- Prepares the briefing and returns the page functions.
---
--- Must be called before pages are added.
--- @param _Briefing table Briefing table
--- @return function AP  Page function
--- @return function ASP Simplified page function
function AddBriefingPages(_Briefing)
    return function() end, function() end;
end
API.AddBriefingPages = AddBriefingPages;

--- Creates a page.
---
--- The page can have various attributes:
--- * `Title`           - Displayed page title
--- * `Text`            - Displayed page text
--- * `Speech`          - Path to voiceover (MP3 file)
--- * `Position`        - Script name of the position
--- * `Duration`        - Time until auto-skip
--- * `DialogCamera`    - Use close-up camera
--- * `DisableSkipping` - Allow/forbid skipping the page
--- * `Action`          - Function called when the page is shown
--- * `FarClipPlane`    - Render distance
--- * `Rotation`        - Camera rotation
--- * `Zoom`            - Camera zoom
--- * `Angle`           - Camera angle
--- * `FadeIn`          - Duration of fade-in from black
--- * `FadeOut`         - Duration of fade-out to black
--- * `FaderAlpha`      - Mask alpha
--- * `BarOpacity`      - Opacity of black bars
--- * `BigBars`         - Use large bars
--- * `FlyTo`           - Table with second camera configuration for fly-in
--- * `Performance`     - (Optional) Lower graphics settings for this page
--- * `MC`              - Table with choices for branching dialogues
---
--- #### Example:
--- Create a simple page.
--- ```lua
--- AP {
---    Title        = "Marcus",
---    Text         = "This is a simple page.",
---    Position     = "Marcus",
---    Rotation     = 30,
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
---    Position     = "Marcus",
---    Rotation     = 30,
---    DialogCamera = true,
---    MC = {
---        {"Option 1", "Option1"},
---        {"Option 2", "Option2"},
---    },
--- };
--- 
--- -- Branches in a briefing must be separated with an empty page
--- -- so the briefing knows it's over here.
--- ASP("Option1", "First Option", "This is the first option.", false, "Marcus");
--- AP();
--- ASP("Option2", "Second Option", "This is the second option.", false, "Marcus");
--- ```
---
--- #### Example:
--- The target of an option can be determined by a function.
--- ```lua
--- AP {
---    Title        = "Marcus",
---    Text         = "This is not such a simple page.",
---    Position     = "Marcus",
---    Rotation     = 30,
---    DialogCamera = true,
---    MC = {
---        {"Option 1", "Option1"},
---        {"Option 2", ForkingFunction},
---    },
--- };
--- ```
---
--- @param _Data table Page data
--- @return table Page Created page
function AP(_Data)
    return {};
end

--- Creates a simplified page.
---
--- The function can create an automatic page name based on the page index.
--- A name can be provided optionally as the first parameter.
--- The page won't proceed until the skip button is clicked.
---
--- Parameters expected:
--- * `Name`            - (Optional) Name of the page
--- * `Title`           - Displayed page title
--- * `Text`            - Displayed page text
--- * `DialogCamera`    - Use close-up camera
--- * `Position`        - (Optional) Script name of focused entity
--- * `Action`          - (Optional) Action called when the page is shown
---
--- #### Example:
---
--- ```lua
--- -- Wide view
--- ASP("Title", "Some important text.", false, "HQ");
--- -- Named page
--- ASP("Page1", "Title", "Some important text.", false, "HQ");
--- -- Close-up
--- ASP("Title", "Some important text.", true, "Marcus");
--- -- Call action
--- ASP("Title", "Some important text.", true, "Marcus", MyFunction);
--- -- Page without position
--- ASP("Seite1", "Titel", "Einige wichtige Texte.");
--- ```
---
--- @param _Name? string Name of page
--- @param _Title string Displayed title
--- @param _Text string Displayed text
--- @param _DialogCamera boolean Use dialog camera
--- @param _Position? string Scriptname of position
--- @param _Action? function Action function
--- @return table Page Created page
function ASP(...)
    return {};
end

