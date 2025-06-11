package twa.librarian.librarian.logic.dependency.model;

import java.util.List;

public interface Module {
    String getName();
    void setName(String name);

    String getCanonicalName();
    void setCanonicalName(String name);

    String getPath();
    void setPath(String name);

    String getDescription();

    boolean isMandatory();

    List<String> getDependencies();
}
