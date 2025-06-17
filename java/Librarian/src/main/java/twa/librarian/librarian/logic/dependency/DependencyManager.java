package twa.librarian.librarian.logic.dependency;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import twa.librarian.librarian.logic.config.ConfigurationManager;
import twa.librarian.librarian.logic.dependency.model.ComfortModule;
import twa.librarian.librarian.logic.dependency.model.CoreModule;
import twa.librarian.librarian.logic.dependency.model.FeatureModule;
import twa.librarian.librarian.logic.dependency.model.Module;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.function.ToIntFunction;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * This class manages dependencies of modules.
 * <p>
 * Pass a list of module names to this class to get a list of modules
 * required to run the specified modules.
 */
public class DependencyManager {
    final static Logger logger = LoggerFactory.getLogger(DependencyManager.class);

    private ConfigurationManager config;
    private List<Module> modules;

    public void setConfig(ConfigurationManager config) {
        this.config = config;
    }

    /**
     * @param config Config
     */
    public DependencyManager(ConfigurationManager config) {
        this.config = config;
        updateModuleList();
    }

    /**
     * Returns a list of all required modules depending on the parameter list.
     * @param parameterList List with canonical names
     * @return List of modules
     */
    public List<Module> getLoadOrder(List<String> parameterList) {
        final List<String> canonicalNameList = getCanonizedLoadOrderParameterList(parameterList);
        final List<Module> moduleList = new ArrayList<>();
        // Add all mandatory
        for (Module mandatory : this.modules) {
            if (mandatory.isMandatory()) {
                moduleList.add(mandatory);
            }
        }
        // Add from load order
        for (String canonicalName : canonicalNameList) {
            final Module module = getModuleByCanonicalName(canonicalName);
            if (null != module) {
                for (Module dependency : getModuleAncestry(module)) {
                    if (!moduleList.contains(dependency)) {
                        moduleList.add(dependency);
                    }
                }
                if (!moduleList.contains(module)) {
                    moduleList.add(module);
                }
            }
        }
        // Sort list
        moduleList.sort(Comparator
            .comparingInt((ToIntFunction<Module>) v -> v.getCanonicalName().split("/").length)
            .thenComparing(Module::getCanonicalName));

        // Set module/QSB first
        Module moduleQsb = moduleList
            .stream()
            .filter((m) -> m.getCanonicalName().equals("core/QSB"))
            .findFirst()
            .orElse(null);
        moduleList.remove(moduleQsb);
        moduleList.add(0, moduleQsb);
        return moduleList;
    }

    /**
     * Returns the internal module list.
     * @return List of modules
     */
    public List<Module> getModuleList() {
        return this.modules;
    }

    private List<String> getCanonizedLoadOrderParameterList(List<String> parameterList) {
        List<String> canonicalNameList = new ArrayList<>();
        for (String name : parameterList) {
            if (!name.equals("core/QSB") && !name.equals("core/Core")) {
                canonicalNameList.add(name);
            }
        }
        canonicalNameList.add(0, "core/Core");
        canonicalNameList.add(0, "core/QSB");
        return canonicalNameList;
    }

    /**
     * Returns the module and all of its descendants.
     * @param module Module to inspect
     * @return Heredity, including inspected module
     */
    public List<Module> getModuleHeredity(Module module) {
        final List<Module> dependingList = new ArrayList<>();
        final String canonicalName = module.getCanonicalName();
        for (Module child : this.modules) {
            for (String dependency : child.getDependencies()) {
                if (dependency.equals(canonicalName)) {
                    for (Module grandchild : getModuleHeredity(child)) {
                        if (!dependingList.contains(grandchild)) {
                            dependingList.add(grandchild);
                        }
                    }
                }
            }
        }
        if (!dependingList.contains(module)) {
            dependingList.add(module);
        }
        return dependingList;
    }

    /**
     * Returns the module and all of its ancestors.
     * @param module Module to inspect
     * @return Ancestry, including inspected module
     */
    public List<Module> getModuleAncestry(Module module) {
        final List<Module> dependencyList = new ArrayList<>();
        if (null != module.getDependencies()) {
            for (String canonicalName : module.getDependencies()) {
                final Module child = getModuleByCanonicalName(canonicalName);
                if (null != child) {
                    for (Module grandchild : getModuleAncestry(child)) {
                        if (!dependencyList.contains(grandchild)) {
                            dependencyList.add(grandchild);
                        }
                    }
                }
            }
        }
        if (!dependencyList.contains(module)) {
            dependencyList.add(module);
        }
        return dependencyList;
    }

    /**
     * Returns the module by the given canonical name.
     * @param canonicalName Name of module
     * @return Module object
     */
    public Module getModuleByCanonicalName(String canonicalName) {
        return this.modules
            .stream()
            .filter((m) -> m.getCanonicalName().equals(canonicalName))
            .findFirst()
            .orElse(null);
    }

    /**
     * Reloads the internal module list.
     */
    public void updateModuleList() {
        List<Module> moduleList = new ArrayList<>();
        moduleList.addAll(getComfortModuleList());
        moduleList.addAll(getCoreModuleList());
        moduleList.addAll(getFeatureModuleList());
        this.modules = moduleList;
    }

    private List<Module> getComfortModuleList() {
        List<Module> moduleList = new ArrayList<>();

        String luaRoot = config.getConfig().getLuaSourcePath();
        String comfortRoot = config.getConfig().getComfortRoot();
        File sourcePath = Paths.get(luaRoot, comfortRoot).toFile();

        File[] fileList = sourcePath.listFiles();
        for (File file : fileList) {
            List<Module> module = createModuleFromSubFolder(file);
            moduleList.addAll(module);
        }
        return moduleList;
    }

    private List<Module> getCoreModuleList() {
        List<Module> moduleList = new ArrayList<>();

        String luaRoot = config.getConfig().getLuaSourcePath();
        String coreRoot = config.getConfig().getCoreRoot();
        File sourcePath = Paths.get(luaRoot, coreRoot).toFile();

        File[] fileList = sourcePath.listFiles();
        for (File file : fileList) {
            List<Module> module = createModuleFromSubFolder(file);
            moduleList.addAll(module);
        }
        return moduleList;
    }

    private List<Module> getFeatureModuleList() {
        List<Module> moduleList = new ArrayList<>();

        String luaRoot = config.getConfig().getLuaSourcePath();
        String moduleRoot = config.getConfig().getModuleRoot();
        File sourcePath = Paths.get(luaRoot, moduleRoot).toFile();

        File[] fileList = sourcePath.listFiles();
        for (File file : fileList) {
            List<Module> module = createModuleFromSubFolder(file);
            moduleList.addAll(module);
        }
        return moduleList;
    }

    private List<Module> createModuleFromSubFolder(File file) {
        List<Module> moduleList = new ArrayList<>();
        File[] fileList = file.listFiles();
        if (null != fileList && fileList.length > 0) {
            for (File folderFile : fileList) {
                Module module = createModuleFromFile(folderFile);
                if (null != module) {
                    moduleList.add(module);
                }
            }
            return moduleList;
        }
        Module module = createModuleFromFile(file);
        if (null != module) {
            moduleList.add(module);
        }
        return moduleList;
    }

    private Module createModuleFromFile(File file) {
        Module module = null;

        int lastDot = file.getName().lastIndexOf(".");
        if (lastDot == -1) {
            return null;
        }
        String moduleName = file.getName().substring(0, lastDot);
        if (config.getConfig().getNameBlacklist().contains(moduleName)) {
            return null;
        }

        if (file.getPath().contains(config.getConfig().getComfortRoot())) {
            module = new ComfortModule(moduleName);
        }
        else if (file.getPath().contains(config.getConfig().getCoreRoot())) {
            module = new CoreModule(moduleName);
        }
        else if (file.getPath().contains(config.getConfig().getModuleRoot())) {
            module = new FeatureModule(moduleName);
        }
        else {
            return null;
        }

        try {
            module.setPath(file.getAbsolutePath());

            boolean IsModule = false;
            List<String> lines = Files.readAllLines(Paths.get(file.getAbsolutePath()));
            for (String line : lines) {
                if (line.startsWith("Lib.Register(")) {
                    IsModule = true;
                    Pattern pattern = Pattern.compile("\"([^\"]*)\"");
                    Matcher matcher = pattern.matcher(line);
                    if (matcher.find()) {
                        int start = matcher.group(1).lastIndexOf("/") +1;
                        String description = config.getConfig().getModuleDescriptions().get(matcher.group(1));
                        module.setName(matcher.group(1).substring(start));
                        module.setCanonicalName(matcher.group(1));
                        module.setDescription(description);
                    }
                    break;
                }
                if (line.startsWith("Lib.Require(")) {
                    IsModule = true;
                    Pattern pattern = Pattern.compile("\"([^\"]*)\"");
                    Matcher matcher = pattern.matcher(line);
                    if (matcher.find()) {
                        module.getDependencies().add(matcher.group(1));
                    }
                }
            }
            if (!IsModule) {
                module = null;
            }
        }
        catch (Exception e) {
            logger.error("Error reading file.", e);
            module = null;
        }

        return module;
    }
}
