package twa.libertica.libertica.junit;

import org.junit.jupiter.api.Test;
import twa.libertica.libertica.logic.config.ConfigurationManager;
import twa.libertica.libertica.logic.text.LocalizationManager;

import static org.junit.jupiter.api.Assertions.assertNotEquals;

public class LocalizationManagerTest {
    @Test
    public void testGetStringTableText() {
        ConfigurationManager configurationManager = new ConfigurationManager();
        configurationManager.readApplicationJson("config/config_test.json");
        configurationManager.readUserJson("config/user_test.json");
        LocalizationManager localizationManager = new LocalizationManager(configurationManager);

        configurationManager.getUserConfig().setLanguage("en");
        String textEn = localizationManager.getStringTableText("Behavior/comfort/AddWare");
        assertNotEquals(textEn, "");
        configurationManager.getUserConfig().setLanguage("de");
        String textDe = localizationManager.getStringTableText("Behavior/comfort/AddWare");
        assertNotEquals(textDe, "");
    }
}
