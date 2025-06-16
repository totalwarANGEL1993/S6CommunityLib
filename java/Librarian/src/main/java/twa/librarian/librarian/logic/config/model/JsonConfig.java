package twa.librarian.librarian.logic.config.model;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class JsonConfig {
    private String LuaSourcePath;
    private String ConfigPath;
    private String comfortRoot;
    private String coreRoot;
    private String moduleRoot;
    private Map<String, Object> userConfig = new LinkedHashMap<>();
    private List<String> nameBlacklist = new ArrayList<>();
    private Map<String, String> moduleDescriptions = new LinkedHashMap<>();

    public String getLuaSourcePath() {
        return LuaSourcePath;
    }

    public void setLuaSourcePath(String luaSourcePath) {
        LuaSourcePath = luaSourcePath;
    }

    public String getComfortRoot() {
        return comfortRoot;
    }

    public void setComfortRoot(String comfortRoot) {
        this.comfortRoot = comfortRoot;
    }

    public String getCoreRoot() {
        return coreRoot;
    }

    public void setCoreRoot(String coreRoot) {
        this.coreRoot = coreRoot;
    }

    public String getModuleRoot() {
        return moduleRoot;
    }

    public void setModuleRoot(String moduleRoot) {
        this.moduleRoot = moduleRoot;
    }

    public List<String> getNameBlacklist() {
        return nameBlacklist;
    }

    public void setNameBlacklist(List<String> nameBlacklist) {
        this.nameBlacklist = nameBlacklist;
    }

    public Map<String, String> getModuleDescriptions() {
        return moduleDescriptions;
    }

    public void setModuleDescriptions(Map<String, String> moduleDescriptions) {
        this.moduleDescriptions = moduleDescriptions;
    }

    public Map<String, Object> getUserConfig() {
        return userConfig;
    }

    public void setUserConfig(Map<String, Object> userConfig) {
        this.userConfig = userConfig;
    }

    public String getConfigPath() {
        return ConfigPath;
    }

    public void setConfigPath(String configPath) {
        ConfigPath = configPath;
    }
}
