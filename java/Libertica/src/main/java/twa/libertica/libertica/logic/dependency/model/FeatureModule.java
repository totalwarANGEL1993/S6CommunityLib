package twa.libertica.libertica.logic.dependency.model;

import java.util.List;
import java.util.Objects;

public class FeatureModule extends AbstractModule {
    public FeatureModule(String name) {
        super(name, "");
    }

    public FeatureModule(String name, List<String> dependencies) {
        super(name, "", dependencies);
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        FeatureModule that = (FeatureModule) o;
        return name.equals(that.name) &&
               canonicalName.equals(that.canonicalName);
    }

    @Override
    public int hashCode() {
        return Objects.hash(name, canonicalName);
    }
}
