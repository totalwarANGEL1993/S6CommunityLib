package twa.libertica.libertica.logic.config.model;

public class Language {
    private String id;
    private String name;
    private String icon;
    private String fileExtension;

    public Language(String id, String name, String icon, String fileExtension) {
        this.id = id;
        this.name = name;
        this.icon = icon;
        this.fileExtension = fileExtension;
    }

    public String getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public String getIcon() {
        return icon;
    }

    public String getFileExtension() {
        return fileExtension;
    }
}
