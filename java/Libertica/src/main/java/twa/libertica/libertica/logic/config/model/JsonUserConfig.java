package twa.libertica.libertica.logic.config.model;

public class JsonUserConfig {
    private String language;
    private String savePath;

    public JsonUserConfig() {}

    public String getLanguage() {
        return language;
    }

    public void setLanguage(String language) {
        this.language = language;
    }

    public String getSavePath() {
        return savePath;
    }

    public void setSavePath(String savePath) {
        this.savePath = savePath;
    }
}
