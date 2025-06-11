package twa.librarian.librarian.logic.dependency.model;

import java.util.ArrayList;
import java.util.List;

public abstract class AbstractModule implements Module {
    protected String name;
    protected String canonicalName;
    protected String path;
    protected String description;
    protected List<String> dependencies;

    public AbstractModule(String name, String description) {
        this.dependencies = new ArrayList<>();
        this.name = name;
        this.description = description;
    }

    public AbstractModule(String name, String description, List<String> dependencies) {
        this.dependencies = dependencies;
        this.name = name;
        this.description = description;
    }

    @Override
    public void setName(String name) {
        this.name = name;
    }

    @Override
    public String getName() {
        return name;
    }

    public String getCanonicalName() {
        return canonicalName;
    }

    public void setCanonicalName(String canonicalName) {
        this.canonicalName = canonicalName;
    }

    @Override
    public String getPath() {
        return path;
    }

    @Override
    public void setPath(String path) {
        this.path = path;
    }

    @Override
    public String getDescription() {
        return description;
    }

    @Override
    public boolean isMandatory() {
        return false;
    }

    @Override
    public List<String> getDependencies() {
        return dependencies;
    }
}
