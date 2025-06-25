package twa.siedelwood.communitylib.junit;

import org.junit.jupiter.api.Test;
import twa.siedelwood.communitylib.logic.config.ConfigurationManager;

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
