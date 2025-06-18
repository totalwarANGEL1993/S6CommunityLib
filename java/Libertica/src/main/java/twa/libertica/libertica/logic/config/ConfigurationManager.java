package twa.libertica.libertica.logic.config;

import org.json.JSONArray;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import twa.libertica.libertica.logic.config.model.JsonApplicationConfig;
import twa.libertica.libertica.logic.config.model.Language;
import twa.libertica.libertica.logic.config.model.JsonUserConfig;

import java.nio.file.Files;
import java.nio.file.Paths;

/**
 * This class holds the configuration.
 */
public class ConfigurationManager {
    final static Logger logger = LoggerFactory.getLogger(ConfigurationManager.class);

    private JsonApplicationConfig config;
    private JsonUserConfig user;

    public JsonApplicationConfig getApplicationConfig() {
        return config;
    }

    public JsonUserConfig getUserConfig() {
        return user;
    }

    public ConfigurationManager() {
        this.config = new JsonApplicationConfig();
        this.user = new JsonUserConfig();
    }

    public ConfigurationManager(String config, String user) {
        this.config = new JsonApplicationConfig();
        this.user = new JsonUserConfig();
        readApplicationJson(config);
        readUserJson(user);
    }

    public void readUserJson(String path) {
        try {
            String jsonString = new String(Files.readAllBytes(Paths.get(path)));
            JSONObject jsonObject = new JSONObject(jsonString);

            JsonUserConfig user = new JsonUserConfig();
            user.setLanguage(jsonObject.getString("Language"));
            user.setSavePath(jsonObject.getString("SavePath"));
            this.user = user;
        }
        catch (Exception e) {
            logger.error("Error reading config file.", e);
        }
    }

    public void readApplicationJson(String path) {
        try {
            String jsonString = new String(Files.readAllBytes(Paths.get(path)));
            JSONObject jsonObject = new JSONObject(jsonString);

            JsonApplicationConfig config = new JsonApplicationConfig();
            config.setConfigPath(Paths.get(path).toFile().getAbsolutePath());
            config.setLuaSourcePath(jsonObject.getString("LuaSourcePath"));
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
            JSONArray languages = jsonObject.getJSONArray("Languages");
            for (int i = 0; i < languages.length(); i++) {
                JSONObject object = (JSONObject) languages.get(i);
                Language lng = new Language(
                    object.getString("ID"),
                    object.getString("Name"),
                    object.getString("Icon"),
                    object.getString("FileExt")
                );
                config.getLanguages().put(object.getString("ID"), lng);
            }
            this.config = config;
        }
        catch (Exception e) {
            logger.error("Error reading config file.", e);
        }
    }
}
