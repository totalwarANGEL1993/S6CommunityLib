package twa.siedelwood.communitylib.logic.config;

import org.json.JSONArray;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import twa.siedelwood.communitylib.logic.config.model.JsonConfig;

import java.nio.file.Files;
import java.nio.file.Paths;

/**
 * This class holds the configuration.
 */
public class ConfigurationManager {
    final static Logger logger = LoggerFactory.getLogger(ConfigurationManager.class);

    private JsonConfig config;

    public JsonConfig getConfig() {
        return config;
    }

    public ConfigurationManager() {
        this.config = new JsonConfig();
    }

    public ConfigurationManager(String path) {
        this.config = new JsonConfig();
        readJson(path);
    }

    public void readJson(String path) {
        try {
            String jsonString = new String(Files.readAllBytes(Paths.get(path)));
            JSONObject jsonObject = new JSONObject(jsonString);

            JsonConfig config = new JsonConfig();
            config.setConfigPath(Paths.get(path).toFile().getAbsolutePath());
            config.setLuaSourcePath(jsonObject.getString("LuaSourcePath"));
            config.setLuaSourcePathSf(jsonObject.getString("LuaSourcePathSf"));
            config.setComfortRoot(jsonObject.getString("ComfortRoot"));
            config.setCoreRoot(jsonObject.getString("CoreRoot"));
            config.setModuleRoot(jsonObject.getString("ModuleRoot"));
            JSONArray blacklist = jsonObject.getJSONArray("ModuleNameBlacklist");
            for (int i = 0; i < blacklist.length(); i++) {
                config.getNameBlacklist().add(blacklist.getString(i));
            }
            JSONArray descriptionList = jsonObject.getJSONArray("ModuleDescriptions");
            for (int i = 0; i < descriptionList.length(); i++) {
                JSONArray innerArray = descriptionList.getJSONArray(i);
                String name = innerArray.getString(0);
                String description = innerArray.getString(1);
                config.getModuleDescriptions().put(name, description);
            }
            JSONObject userConfig = jsonObject.getJSONObject("UserConfig");
            config.getUserConfig().put("SavePath", userConfig.getString("SavePath"));
            this.config = config;
        }
        catch (Exception e) {
            logger.error("Error reading config file.", e);
        }
    }
}
