package twa.siedelwood.communitylib.logic.dependency.model;

import java.util.List;
import java.util.Objects;

public class ComfortModule extends AbstractModule {
    public ComfortModule(String name) {
        super(name, "");
    }

    public ComfortModule(String name, List<String> dependencies) {
        super(name, "", dependencies);
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
