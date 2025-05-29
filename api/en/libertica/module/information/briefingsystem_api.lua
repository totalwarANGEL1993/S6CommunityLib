--- Allows to define briefings.
---
--- The apex for scripting dialogs and simple camera animations. A versatile
--- tool to script the plot of the map.
---



--- Starts a briefing.
---
--- Possible fields for the briefing table:
--- * `Starting`                - Function called when briefing is started              
--- * `Finished`                - Function called when briefing is finished             
--- * `RestoreCamera`           - Camera position is saved and restored at briefing end 
--- * `RestoreGameSpeed`        - Game speed is saved and restored at briefing end      
--- * `EnableGlobalImmortality` - During briefings all entities are invulnerable        
--- * `EnableSky`               - Display the sky during the briefing                   
--- * `EnableFoW`               - Displays the fog of war during the briefing           
--- * `EnableBorderPins`        - Displays the border pins during the briefing          
--- * `PreloadAssets`           - Allows to use a wide vision area in briefings
--- * `HideNotes`               - Do not show notes
---
--- *→ Example #1*
---
--- #### Animations
--- The camera settings can be separated from the text of the page. Not only
--- allows this to fluetly write dialogs, also more possibilities are unlocked
--- when using the notation. To create a animation the page musn't have a
--- position. Otherwise defaults will be used.
---
--- The animation frames should be provided as a table. The camera path will be 
--- calculated using Bézir Curves. This means 2 frames will result in a line,
--- 3 make it a parable and 4 or more result in a curve.
---
--- *→ Example #2*
---
--- *→ Example #3*
---
--- *→ Example #4*
---
--- The current animation can also be cached to start a new animation for a 
--- page, after which the previous one continues. The animation can also be 
--- set to only be valid for its current page and then deleted.
---
--- *→ Example #5*
---
--- #### Parallax
--- In the context of a video game parallaxes are scrollable backgrounds. This
--- technique was used by side scrollers. During a briefing page up to 4 layers
--- of graphics can be shown and animated. Parallaxes are notated similar to
--- camera animations. Scrolling is done by setting UV coordinates.
---
--- Graphics must allways be in 16:9 format. If a player has a 4:3 resolution
--- the image is cropped left and right to fit the frame. Coordinates - as long
--- as provided as relative coordinates - will be adjusted.
---
--- It is also possible to provide a table of animation frames for the image.
--- The frames are linearly interpolated, if there are at least 2 entries and
--- interpolated cubically if there are at least 4 entries.
---
--- *→ Example #6*
---
--- *→ Example #7*
---
--- *→ Example #8*
---
--- #### Examples
---
--- * Example #1: Basic structure
--- ```lua
--- function Briefing1(_Name, _PlayerID)
---     local Briefing = {};
---     local AP, ASP = AddBriefingPages(Briefing);
---
---     -- Pages ...
---
---     Briefing.Starting = function(_Data)
---     end
---     Briefing.Finished = function(_Data)
---     end
---     StartBriefing(Briefing, _Name, _PlayerID);
--- end
--- ```
---
--- * Example #2: Notation for animations
--- ```lua
--- Briefing.PageAnimation = {
---     ["Page1"] = {
---         {30, {GetFrameVector("pos1", 500, "pos2", 1000)},
---              {GetFrameVector("pos3", 500, "pos4", 1000)}},
---     },
---     ["Page3"] = {
---         {30, {GetFrameVector("pos1", 500, "pos2", 1000)},
---              {GetFrameVector("pos3", 500, "pos4", 1000)},
---              {GetFrameVector("pos7", 500, "pos8", 1000)},
---              {GetFrameVector("pos5", 500, "pos6", 1000)}},
---     },
--- };
--- ```
---
--- * Example #3: Replace animations
--- ```lua
--- Briefing.PageAnimation = {
---     ["Page1"] = {
---         Clear = true,
---         {30, {GetFrameVector("pos1", 500, "pos2", -3000)},
---              {GetFrameVector("pos3", 500, "pos4", -3000)}},
---     },
--- };
--- ```
---
--- * Example #4: Endlessly repeating animation
--- ```lua
--- Briefing.PageAnimation = {
---     ["Page1"] = {
---         Repeat = true,
---         {30, {GetFrameVector("pos1", 500, "pos2", -3000)},
---              {GetFrameVector("pos3", 500, "pos4", -3000)},
---              {GetFrameVector("pos7", 500, "pos8", -3000)},
---              {GetFrameVector("pos5", 500, "pos6", -3000)}},
---     },
--- };
--- ```
---
--- * Example #5: Inject animations
--- ```lua
--- Briefing.PageAnimation = {
---     ["Seite1"] = {
---         Postpone = true,
---         Local = true,
---         {30, {GetFrameVector("pos1", 500, "pos2", -3000)},
---              {GetFrameVector("pos3", 500, "pos4", -3000)},
---              {GetFrameVector("pos7", 500, "pos8", -3000)},
---              {GetFrameVector("pos5", 500, "pos6", -3000)}},
---     },
--- };
--- ```
---
--- * Example #6: Notation of paralaxes
--- ```lua
--- Briefing.PageParallax = {
---     ["Page1"] = {
---         {"maps/externalmap/mapname/graphics/Parallax6.png", 60,
---          {0, 0, 0.8, 1, 255},
---          {0.2, 0, 1, 1, 255}},
---     },
---     ["Page3"] = {
---         {"maps/externalmap/mapname/graphics/Parallax1.png", 1,
---          {0, 0, 0.8, 1, 255},
---          {0.2, 0, 1, 1, 255},
---          {0, 0, 0.8, 1, 255},
---          {0.2, 0, 1, 1, 255}},
---     },
---     ["Page7"] = {
---         {"maps/externalmap/mapname/graphics/Parallax6.png", 60,
---          {0, 0, 0.8, 1, 255}},
---     },
--- };
--- ```
---
--- * Example #7: Replace parallaxes
--- ```lua
--- Briefing.PageParallax = {
---     ["Page1"] = {
---         Clear = true,
---         {"maps/externalmap/mapname/graphics/Parallax6.png", 60,
---          {0, 0, 0.8, 1, 255},
---          {0.2, 0, 1, 1, 255}},
---     },
--- };
--- ```
---
--- * Example #8: Endlessly repeating parallaxes
--- ```lua
--- Briefing.PageParallax = {
---     ["Seite1"] = {
---         Repeat = true,
---         {"maps/externalmap/mapname/graphics/Parallax6.png", 60,
---          {0, 0, 0.8, 1, 255},
---          {0.2, 0, 1, 1, 255}},
---     },
--- };
--- ```
---
--- @param _Briefing table   Briefing table
--- @param _Name string      Name of briefing
--- @param _PlayerID integer Player ID of receiver
function StartBriefing(_Briefing, _Name, _PlayerID)
end
API.StartBriefing = StartBriefing;

--- Asks the player for the permission to change graphic settings.
---
--- This feature is deactivated in Multiplayer.
function RequestBriefingAlternateGraphics()
end
API.RequestBriefingAlternateGraphics = RequestBriefingAlternateGraphics;

--- Checks if a briefing ist active.
--- @param _PlayerID integer PlayerID of receiver
--- @return boolean IsActive Briefing is active
function IsBriefingActive(_PlayerID)
    return true;
end
API.IsBriefingActive = IsBriefingActive;

--- Creates a point from a position.
--- @param _Entity any      Target entity
--- @param _ZOffset integer Z-Offset (< 0 → Z overwrite)
--- @return number X X-Koordinate
--- @return number Y Y-Koordinate
--- @return number Z Z-Koordinate
function GetFramePosition(_Entity, _ZOffset)
    return 0, 0, 0;
end

--- Creates an vector from 2 positions.
--- @param _Entity1 any      Target position entity
--- @param _ZOffset1 integer Z-Offset of position (< 0 → Z overwrite)
--- @param _Entity2 any      Target lookat entity
--- @param _ZOffset2 integer Z-Offset of lookat (< 0 → Z overwrite)
--- @return number X1        X-Coordinate Position
--- @return number Y1        Y-Coordinate Position
--- @return number Z1        Z-Coordinate Position
--- @return number X2        X-Coordinate LookAt
--- @return number Y2        Y-Coordinate LookAt
--- @return number Z2        Z-Coordinate LookAt
function GetFrameVector(_Entity1, _ZOffset1, _Entity2, _ZOffset2)
    return 0, 0, 0, 0, 0, 0;
end

--- Prepares the briefing and returns the page functions.
---
--- Must be called before pages are added.
--- @param _Briefing table Briefing table
--- @return function AP  Page function
--- @return function ASP Short page function
function AddBriefingPages(_Briefing)
    return function() end, function() end;
end
API.AddBriefingPages = AddBriefingPages;

--- Creates a page.
---
--- Possible fields for the page:
---
--- * `Title`           - Displayed page title
--- * `Text`            - Displayed page text
--- * `Speech`          - Path to voiceover (MP3 file)
--- * `Position`        - Script name of position
--- * `Duration`        - Time until automatic skip
--- * `DialogCamera`    - Use closeup camera
--- * `DisableSkipping` - Allow/forbid skipping pages
--- * `Action`          - Function called when page is displayed
--- * `FarClipPlane`    - Render distance
--- * `Rotation`        - Camera rotation
--- * `Zoom`            - Camera zoom
--- * `Angle`           - Camera angle
--- * `FadeIn`          - Duration of fadein from black
--- * `FadeOut`         - Duration of fadeout to black
--- * `FaderAlpha`      - Mask alpha
--- * `BarOpacity`      - Opacity of bars
--- * `BigBars`         - Use big bars
--- * `FlyTo`           - Table with second set of camera configuration were camera flys to
--- * `Performance`     - (Optional) Lower graphic settings for this page
--- * `MC`              - Table with choices to branch of in dialogs
---
--- *→ Example #1*
---
--- #### Flow control
--- In a briefing the player can be forced to make a choice that will have
--- different results. That is called multiple choice. Options must be provided
--- in a table. The target page can be defined with it's name or a function can
--- be provided for more control over the flow. Such funktions must return a
--- page name.
---
--- *→ Example #2*
---
--- Additionally each funktion can be marked to be removed when used
--- and not shown again when reentering the page.
---
--- *→ Example #3*
---
--- Also pages can be hidden by providing a function to check conditions.
---
--- *→ Example #4*
---
--- If a briefing is branched it must be manually ended after a branch is done
--- or it just simply shows the next page. To end a briefing, an empty page
--- must be added.
---
--- *→ Example #5*
---
--- Alternativly the briefing can continue at a different page. This allows to
--- create repeating structures within a briefing.
---
--- *→ Example #6*
---
--- To obtain selected answers at a later point the selection can be saved in a
--- global variable either in a option callback or in the finished function. The
--- number returned is the ID of the answer.
---
--- *→ Example #7*
---
--- #### Example:
---
--- * Example #1: A simple page
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
--- * `Clear`:    (optional) <b>boolean</b> All running animation sets are cleared. Then the new sets are started.
--- * `Repeat`:   (optional) <b>boolean</b> The animation sets start over after finishing.
--- * `Postpone`: (optional) <b>boolean</b> The running animation sets are postponed, and the sets of the page are started.
--- * `Local`:    (optional) <b>boolean</b> The animation sets are played only on this page.



--- Starts a briefing.
--- 
--- #### Fields `_Briefing`:
--- * `Starting`:                (optional) <b>function</b> Function called when the introduction starts              
--- * `Finished`:                (optional) <b>function</b> Function called when the introduction ends             
--- * `RestoreCamera`:           (optional) <b>boolean</b> Camera position is saved and restored after the introduction
--- * `RestoreGameSpeed`:        (optional) <b>boolean</b> Game speed is saved and restored after the introduction      
--- * `EnableGlobalImmortality`: (optional) <b>boolean</b> All entities are invulnerable during the introduction        
--- * `EnableSky`:               (optional) <b>boolean</b> Shows the sky during the introduction                   
--- * `EnableFoW`:               (optional) <b>boolean</b> Shows the fog of war during the introduction 
--- * `EnableBorderPins`:        (optional) <b>boolean</b> Shows border pins during the introduction     
--- * `PreloadAssets`:           (optional) <b>boolean</b> Allows a wide field of view during briefings
--- * `HideNotes`:               (optional) <b>boolean</b> Hides messages
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
--- #### Fields `_Data`:
--- * `Title`:           <b>any</b> Displayed page title
--- * `Text`:            <b>any</b> Displayed page text
--- * `Speech`:          <b>string</b> Path to voiceover (MP3 file)
--- * `Position`:        (Optional) <b>string</b> Script name of the position
--- * `Duration`:        (Optional) <b>integer</b> Time until auto-skip
--- * `DialogCamera`:    (Optional) <b>boolean</b> Use close-up camera
--- * `DisableSkipping`: (Optional) <b>boolean</b> Allow/forbid skipping the page
--- * `Action`:          (Optional) <b>function</b> Function called when the page is shown
--- * `FarClipPlane`:    (Optional) <b>integer</b> Render distance
--- * `Rotation`:        (Optional) <b>float</b> Camera rotation
--- * `Zoom`:            (Optional) <b>float</b> Camera zoom
--- * `Angle`:           (Optional) <b>float</b> Camera angle
--- * `FadeIn`:          (Optional) <b>float</b> Duration of fade-in from black
--- * `FadeOut`:         (Optional) <b>float</b> Duration of fade-out to black
--- * `FaderAlpha`:      (Optional) <b>float</b> Mask alpha
--- * `BarOpacity`:      (Optional) <b>float</b> Opacity of black bars
--- * `BigBars`:         (Optional) <b>boolean</b> Use large bars
--- * `FlyTo`:           (Optional) <b>table</b> Table with second camera configuration for fly-in
--- * `Performance`:     (Optional) <b>boolean</b> Lower graphics settings for this page
--- * `MC`:              (Optional) <b>table</b> Table with choices for branching dialogues
--- 
--- #### Fields `_Data.FlyTo`:
--- * `Position`:     <b>string</b> Skriptname der Position
--- * `Action`:       <b>function</b> Funktion, die aufgerufen wird, wenn die Seite angezeigt wird
--- * `FarClipPlane`: <b>integer</b> Renderabstand
--- * `Rotation`:     <b>float</b> Kamerarotation
--- * `Zoom`:         <b>float</b> Kamerazoom
--- * `Angle`:        <b>float</b> Kamerawinkel
--- 
--- #### Fields `_Data.MC`:
--- * `[1]`: <b>any</b> Angezeigter Text (String oder Language Table)
--- * `[2]`: <b>any</b> Sprungziel (String oder Funktion)
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
--- The target of an option can be determined by a function. The function must
--- return the name pf the target page.
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
--- The function expects the following parameters:
--- 
--- * `Name`            - (Optional) Name of page
--- * `Title`           - Displayed page title
--- * `Text`            - Displayed page text
--- * `DialogCamera`    - Use closeup camera
--- * `Position`        - (Optional) Scriptname of focused entity
--- * `Action`          - (Optional) Action when page is shown
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

