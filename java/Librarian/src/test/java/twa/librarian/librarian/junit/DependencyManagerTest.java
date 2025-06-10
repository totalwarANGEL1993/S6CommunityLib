package twa.librarian.librarian.junit;

import org.junit.jupiter.api.Test;
import twa.librarian.librarian.logic.config.ConfigurationManager;
import twa.librarian.librarian.logic.dependency.DependencyManager;
import twa.librarian.librarian.logic.dependency.Module;

import java.util.Arrays;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

public class DependencyManagerTest {
    private DependencyManager dependencyManager;

    @Test
    public void testgetLoadOrder() {
        Module testModule;
        List<String> canonicalNameList = Arrays.asList(
            "core/Core",
            "comfort/GetRandomSettlerType",
            "module/faker/Permadeath"
        );

        ConfigurationManager configurationManager = new ConfigurationManager("config/config_test.json");
        dependencyManager = new DependencyManager(configurationManager);
        List<Module> loadOrder = dependencyManager.getLoadOrder(canonicalNameList);

        testModule = loadOrder
            .stream()
            .filter((m) -> m.getName().equals("CopyTable"))
            .findFirst()
            .orElse(null);
        assertNotNull(testModule);

        testModule = loadOrder
            .stream()
            .filter((m) -> m.getName().equals("Core"))
            .findFirst()
            .orElse(null);
        assertNotNull(testModule);

        testModule = loadOrder
            .stream()
            .filter((m) -> m.getName().equals("Permadeath"))
            .findFirst()
            .orElse(null);
        assertNotNull(testModule);
    }

    @Test
    public void testUpdateModuleList() {
        Module testModule;

        ConfigurationManager configurationManager = new ConfigurationManager("config/config_test.json");
        dependencyManager = new DependencyManager(configurationManager);
        dependencyManager.updateModuleList();
        List<Module> modules = dependencyManager.getModuleList();

        testModule = modules
            .stream()
            .filter((m) -> m.getName().equals("GetAngleBetween"))
            .findFirst()
            .orElse(null);

        assertNotNull(testModule);
        assertEquals("comfort/GetPosition", testModule.getDependencies().get(0));

        testModule = modules
            .stream()
            .filter((m) -> m.getName().equals("Core_Debug"))
            .findFirst()
            .orElse(null);

        assertNotNull(testModule);
        assertEquals("core/feature/Core_Debug", testModule.getCanonicalName());

        testModule = modules
            .stream()
            .filter((m) -> m.getName().equals("Construction"))
            .findFirst()
            .orElse(null);

        assertNotNull(testModule);
        assertEquals("module/city/Construction", testModule.getCanonicalName());
    }
}
