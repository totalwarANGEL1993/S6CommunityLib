package twa.librarian.librarian.logic.dependency;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

public class ComfortModule implements Module {
    private String name;
    private String canonicalName;
    private String path;
    private String description;
    private List<String> dependencies;

    public ComfortModule(String name) {
        this.dependencies = new ArrayList<String>();
        this.name = name;
        this.description = description;
    }

    public ComfortModule(String name, List<String> dependencies) {
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

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        ComfortModule that = (ComfortModule) o;
        return name.equals(that.name) &&
               canonicalName.equals(that.canonicalName);
    }

    @Override
    public int hashCode() {
        return Objects.hash(name, canonicalName);
    }
}
