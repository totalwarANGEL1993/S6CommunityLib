package twa.libertica.libertica.logic.text;

import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import twa.libertica.libertica.logic.config.ConfigurationManager;
import twa.libertica.libertica.logic.config.model.Language;
import twa.libertica.libertica.logic.text.model.StringTable;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.LinkedHashMap;
import java.util.Map;

public class LocalizationManager {
    final static Logger logger = LoggerFactory.getLogger(LocalizationManager.class);

    private ConfigurationManager config;

    private Map<String, Map<String, StringTable>> localization = new LinkedHashMap<>();

    public LocalizationManager(ConfigurationManager config) {
        this.config = config;
        loadLanguages();
    }

    /**
     * Returns a string for the current language.
     * @param path Path to string
     * @return Text
     */
    public String getStringTableText(String path) {
        String text = "";
        try {
            final String language = config.getUserConfig().getLanguage();
            final String category = path.substring(0, path.indexOf("/"));
            final String stringKey = path.substring(path.indexOf("/") +1);

            Map<String, StringTable> stringKeys = localization.get(language);
            text = stringKeys.get(category).getString(stringKey);
        }
        catch (Exception ignore) {}
        return text;
    }

    /**
     * Saves a string into the current language.
     * @param path Path to string
     * @param text Text
     */
    public void setStringTableText(String path, String text) {
        try {
            final String language = config.getUserConfig().getLanguage();
            final String category = path.substring(0, path.indexOf("/"));
            final String stringKey = path.substring(path.indexOf("/") +1);

            Map<String, StringTable> stringKeys = localization.get(language);
            stringKeys.get(category).setString(stringKey, text);
        }
        catch (Exception ignore) {}
    }

    /**
     * Loads all languages and stores them.
     */
    public void loadLanguages() {
        try {
            for (Map.Entry<String, Language> lng : config.getApplicationConfig().getLanguages().entrySet()) {
                final String lngId = lng.getKey();
                final String ext = lng.getValue().getFileExtension();
                final Map<String, StringTable> stringsMap = new LinkedHashMap<>();

                // Behavior
                final Path behaviorPath = Paths.get("text", "behavior" + ext + ".json");
                final byte[] behaviorBytes = Files.readAllBytes(behaviorPath);
                final String behaviorString = new String(behaviorBytes, StandardCharsets.UTF_8);
                final JSONObject behaviorObject = new JSONObject(behaviorString);
                final StringTable behavior = new StringTable(behaviorPath.toFile().getPath(), behaviorObject);
                stringsMap.put("Behavior", behavior);
                // Window
                final Path windowPath = Paths.get("text", "window" + ext + ".json");
                final byte[] windowBytes = Files.readAllBytes(windowPath);
                final String windowString = new String(windowBytes, StandardCharsets.UTF_8);
                final JSONObject windowObject = new JSONObject(windowString);
                final StringTable window = new StringTable(windowPath.toFile().getPath(), windowObject);
                stringsMap.put("Window", window);

                localization.put(lngId, stringsMap);
            }
        }
        catch (IOException e) {
            logger.error("Error loading localization!", e);
        }
    }
}
