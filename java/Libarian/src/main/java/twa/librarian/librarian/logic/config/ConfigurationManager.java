package twa.librarian.librarian.logic.config;

import org.json.JSONArray;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

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
            config.setLuaSourcePath(jsonObject.getString("LuaSourcePath"));
            config.setComfortRoot(jsonObject.getString("ComfortRoot"));
            config.setCoreRoot(jsonObject.getString("CoreRoot"));
            config.setModuleRoot(jsonObject.getString("ModuleRoot"));
            JSONArray blacklist = jsonObject.getJSONArray("ModuleNameBlacklist");
            for (int i = 0; i < blacklist.length(); i++) {
                config.getNameBlacklist().add(blacklist.getString(i));
            }
            this.config = config;
        }
        catch (Exception e) {
            logger.error("Error reading config file.", e);
        }
    }
}
