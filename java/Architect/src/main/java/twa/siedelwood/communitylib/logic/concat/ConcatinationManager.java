package twa.siedelwood.communitylib.logic.concat;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import twa.siedelwood.communitylib.logic.config.ConfigurationManager;
import twa.siedelwood.communitylib.logic.dependency.DependencyManager;
import twa.siedelwood.communitylib.logic.dependency.model.Module;

import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.*;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class ConcatinationManager {
    final static Logger logger = LoggerFactory.getLogger(ConcatinationManager.class);

    private ConfigurationManager config;
    private DependencyManager dependency;

    private Map<String, String> fileContent;

    public void setConfig(final ConfigurationManager config) {
        this.config = config;
    }

    public void setDependency(final DependencyManager dependency) {
        this.dependency = dependency;
    }

    public ConcatinationManager(
        final ConfigurationManager config,
        final DependencyManager dependency
    ) {
        this.config = config;
        this.dependency = dependency;

        this.fileContent = new LinkedHashMap<>();
    }

    public List<Module> getLoadOrder(final List<String> nameList) {
        return dependency.getLoadOrder(nameList);
    }

    public void saveSingleFile(
        final List<String> nameList,
        final File destination,
        final String filename
    ) throws Exception {
        Path location;
        String content;
        try {
            cleanSourceFiles();
            readAllModuleFiles(nameList);
            content = loadFile("loader_sf.lua", config.getConfig().getLuaSourcePathSf());
            for (Map.Entry<String, String> entry : fileContent.entrySet()) {
                content += entry.getValue();
            }
            // Save QSB
            location = Paths.get(destination.getAbsolutePath(), filename);
            location.toFile().mkdirs();
            Files.deleteIfExists(location);
            Files.write(location, content.getBytes(StandardCharsets.UTF_8), StandardOpenOption.CREATE);
            // Save global script
            content = loadFile("core/mapscript_sf.lua", config.getConfig().getLuaSourcePathSf());
            location = Paths.get(destination.getAbsolutePath(), "mapscript.lua");
            location.toFile().mkdirs();
            Files.deleteIfExists(location);
            Files.write(location, content.getBytes(StandardCharsets.UTF_8), StandardOpenOption.CREATE);
            // Save local script
            content = loadFile("core/localmapscript_sf.lua", config.getConfig().getLuaSourcePathSf());
            location = Paths.get(destination.getAbsolutePath(), "localmapscript.lua");
            location.toFile().mkdirs();
            Files.deleteIfExists(location);
            Files.write(location, content.getBytes(StandardCharsets.UTF_8), StandardOpenOption.CREATE);
        }
        catch (IOException e) {
            logger.error("Community Lib was not saved!", e);
            throw new Exception("Community Lib was not saved!", e);
        }
    }

    public void saveLibrary(List<String> nameList, File destination) throws Exception {
        Path location;
        String content;
        try {
            cleanSourceFiles();
            readAllModuleFiles(nameList);

            // Save global script
            content = loadFile("core/mapscript.lua", config.getConfig().getLuaSourcePath());
            location = Paths.get(destination.getAbsolutePath(), "mapscript.lua");
            location.toFile().mkdirs();
            Files.deleteIfExists(location);
            Files.write(location, content.getBytes(StandardCharsets.UTF_8), StandardOpenOption.CREATE);
            // Save local script
            content = loadFile("core/localmapscript.lua", config.getConfig().getLuaSourcePath());
            location = Paths.get(destination.getAbsolutePath(), "localmapscript.lua");
            location.toFile().mkdirs();
            Files.deleteIfExists(location);
            Files.write(location, content.getBytes(StandardCharsets.UTF_8), StandardOpenOption.CREATE);
            // Save local header
            content = loadFile("loader.lua", config.getConfig().getLuaSourcePath());
            location = Paths.get(destination.getAbsolutePath(), "loader.lua");
            location.toFile().mkdirs();
            Files.deleteIfExists(location);
            Files.write(location, content.getBytes(StandardCharsets.UTF_8), StandardOpenOption.CREATE);
            // Save modules
            for (Map.Entry<String, String> entry : fileContent.entrySet()) {
                location = Paths.get(destination.getAbsolutePath(), entry.getKey().toLowerCase() + ".lua");
                location.toFile().mkdirs();
                Files.deleteIfExists(location);
                Files.write(location, entry.getValue().getBytes(StandardCharsets.UTF_8), StandardOpenOption.CREATE);
            }
        }
        catch (IOException e) {
            logger.error("Community Lib was not saved!", e);
            throw new Exception("Community Lib was not saved!", e);
        }
    }

    private String loadFile(final String path) {
        return loadFile(path, config.getConfig().getLuaSourcePath());
    }

    private String loadFile(final String path, final String source) {
        String content = null;
        try {
            byte[] bytes = Files.readAllBytes(Paths.get(source, path));
            content = new String(bytes, StandardCharsets.UTF_8);
        }
        catch (IOException e) {
            logger.error("Error reading source file!", e);
        }
        return content;
    }

    private void cleanSourceFiles() {
        fileContent.clear();
    }

    private void readAllModuleFiles(final List<String> nameList) {
        List<Module> moduleList = dependency.getLoadOrder(nameList);
        moduleList.forEach(this::readModuleFile);
    }

    private void readModuleFile(final Module module) {
        try {
            byte[] bytes = Files.readAllBytes(Paths.get(module.getPath()));
            String content = new String(bytes, StandardCharsets.UTF_8);
            fileContent.put(module.getCanonicalName(), content);
        }
        catch (IOException e) {
            logger.error("Error reading source file!", e);
        }
    }
}
