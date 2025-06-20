package twa.libertica.libertica.junit;

import org.junit.jupiter.api.Test;
import twa.libertica.libertica.logic.concat.ConcatinationManager;
import twa.libertica.libertica.logic.config.ConfigurationManager;
import twa.libertica.libertica.logic.dependency.DependencyManager;

import java.io.File;
import java.util.Arrays;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertTrue;

public class ConcatinationManagerTest {
    @Test
    public void testSaveSingleFile() throws Exception {
        ConfigurationManager configurationManager = new ConfigurationManager("config/config_test.json");
        DependencyManager dependencyManager = new DependencyManager(configurationManager);
        ConcatinationManager concatinationManager = new ConcatinationManager(configurationManager, dependencyManager);

        List<String> canonicalNameList = Arrays.asList(
            "core/Core",
            "comfort/GetRandomSettlerType",
            "module/information/BriefingSystem",
            "module/faker/Permadeath"
        );

        concatinationManager.saveSingleFile(
            canonicalNameList,
            new File("var/single"),
            "questsystembehavior.lua"
        );

        assertTrue(new File("var/single/questsystembehavior.lua").exists());
    }
    @Test
    public void testSaveLibrary() throws Exception {
        ConfigurationManager configurationManager = new ConfigurationManager("config/config_test.json");
        DependencyManager dependencyManager = new DependencyManager(configurationManager);
        ConcatinationManager concatinationManager = new ConcatinationManager(configurationManager, dependencyManager);

        List<String> canonicalNameList = Arrays.asList(
            "core/Core",
            "comfort/GetRandomSettlerType",
            "module/information/BriefingSystem",
            "module/faker/Permadeath"
        );

        concatinationManager.saveLibrary(
            canonicalNameList,
            new File("var/library")
        );

        assertTrue(new File("var/library/librarian.lua").exists());
    }
}
