package twa.librarian.librarian.junit;

import org.junit.jupiter.api.Test;
import twa.librarian.librarian.logic.config.ConfigurationManager;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class ConfigurationManagerTest {
    @Test
    public void testReadConfig() {
        ConfigurationManager configurationManager = new ConfigurationManager();
        configurationManager.readJson("config/config_test.json");

        String luaPath = configurationManager.getConfig().getLuaSourcePath();
        assertEquals("../../lua", luaPath);
    }
}
