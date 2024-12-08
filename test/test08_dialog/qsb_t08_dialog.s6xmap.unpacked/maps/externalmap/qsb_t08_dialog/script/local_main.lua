-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||| --
-- ||||                          LOKALES SKRIPT                          |||| --
-- ||||                    --------------------------                    |||| --
-- ||||                            Testmap 21                            |||| --
-- ||||                           totalwarANGEL                          |||| --
-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||| --

-- ========================================================================== --

function ModeSelection_ShowBuildLimitation()
    local Title  = {de = "Restriktiver Bau", en = "Restrictive Build"};
    local Button = {de = "Weiter", en = "Continue"};
    local Text   = {de = "Dieser Modus schränkt die Baumöglichkeiten ein, "..
                         "sodass der Bau der Stadt bessere Planung erfordert."..
                         "{cr}{cr}{cr}"..
                         "1. Im Heimatgebiet können alle Stadtgebäude gebaut "..
                         "werden aber nur 3 verschiedene Sammlergebäude. "..
                         "Stadtgebäude können nur auf dem Heimatgebiet "..
                         "gebaut werden."..
                         "{cr}{cr}"..
                         "2. Die Ausbaustufe der Burg bestimmt, wie viele "..
                         "Territorien eingenommen werden können. Wird das "..
                         "Limit überschritten (z.B. durch Eroberung), "..
                         "werden Strafsteuern fällig. Erzherzog erlaubt "..
                         "noch weitere Territorien. "..
                         "{cr}{cr}"..
                         "3. Mauern und Palisaden kosten Unterhalt. Kann der "..
                         "Unterhalt nicht bezahlt werden, werden die Anlagen "..
                         "mit der Zeit verfallen."..
                         "{cr}{cr}"..
                         "4. Geschütztürme können nur mit Mauerkatapulten "..
                         "erweitert werden, wenn sie genug Abstand "..
                         "zueinander haben."..
                         "{cr}{cr}"..
                         "5. In anderen Territorien können nur 2 Gebäude "..
                         "gebaut werden. Jeder Gebäudetyp kann nur einmal "..
                         "auf dem Territorien gebaut werden."..
                         "{cr}{cr}"..
                         "6. Der Ausbau des Außenposten erlaubt ein weiteres "..
                         "Gebäude im Territorium. Er erlaubt außerdem, Typen "..
                         "doppelt zu errichten."..
                         "{cr}{cr}"..
                         "7. Getreidefarmen können nur in Territorien mit "..
                         "reichlich hellgrünen Wiesen gebaut werden."..
                         "{cr}{cr}"..
                         "8. Tierfarmen können nur auf Territorien mit "..
                         "reichlich dunkelgrünen Wiesen gebaut werden."..
                         "{cr}{cr}"..
                         "9. Bienenstöcke konnen allen Wiesen gebaut werden, "..
                         "auf denen es viele Blumen gibt."..
                         "{cr}{cr}"..
                         "10. Bienenstöcke, Felder und Ziergebäude zählen "..
                         "nicht als Gebäude.",
                    en = "This mode narrows down the settlement building to "..
                         "make planing the game more difficult."..
                         "{cr}{cr}{cr}"..
                         "1. In the home territory all city buildings can be "..
                         "placed but only up to 3 gatherer buildings. City "..
                         "buildings can only beplaced on the home territory."..
                         "{cr}{cr}"..
                         "2. The amount of allowed outposts depends on the "..
                         "castle upgrade level. Exceecing the limit (e.g. by "..
                         "conquest) will result in penalty taxes. Becoming "..
                         "archduke grants additional territories. "..
                         "{cr}{cr}"..
                         "3. Walls and palisades will have maintenance cost. "..
                         "If the ipkeep cannot be paid, the structures will "..
                         "deteriorate over time."..
                         "{cr}{cr}"..
                         "4. Turrets can only be upgraded with catapults if "..
                         "two turrets have sufficient distance to each other."..
                         "{cr}{cr}"..
                         "5. Other territories are limited to 2 buildings. "..
                         "At the beginning, each type can only be build once."..
                         "{cr}{cr}"..
                         "6. Upgrading outposts allows to place a additional "..
                         "building in the territory. Also a building type "..
                         "can be placed twice. "..
                         "{cr}{cr}"..
                         "7. Grainfarms can only be build on territories "..
                         "with lots of bright grass."..
                         "{cr}{cr}"..
                         "8. Animal farms canonly be build on territories "..
                         "with lots of dark grass."..
                         "{cr}{cr}"..
                         "9. Beekeeper can only be build on territories "..
                         "with lots of flowers."..
                         "{cr}{cr}"..
                         "10. Beehives, beautifications and fields do not "..
                         "count as buildings."};

    Lib.Requester.Local:ShowTextWindow {
        PlayerID     = 1,
        Caption      = Localize(Title),
        Content      = Localize(Text),
        DisableClose = true,
        Button = {
            Text   = Localize(Button),
            Action = function(_Data)
                Lib.Requester.Local:RestoreChatLog();
                XGUIEng.ShowWidget("/InGame/Root/Normal/ChatOptions",0);
            end
        },
    };
end

-- ========================================================================== --

function GameCallback_Lib_LoadingFinished()
end

