package twa.librarian.librarian.ui.components;

import twa.librarian.librarian.logic.ProgramController;
import twa.librarian.librarian.logic.dependency.model.Module;

import javax.swing.*;
import java.util.Arrays;
import java.util.List;

/**
 * UI for the assemble operation.
 */
public class AssemblePanel extends JPanel {
    private final ProgramController controller;

    public AssemblePanel(JPanel parent, ProgramController controller) {
        super(null);
        this.controller = controller;

        setSize(parent.getWidth() - 25, parent.getHeight() - 185);
        setBorder(BorderFactory.createTitledBorder("Assemble"));
        setLocation(5, 0);
        parent.add(this);
    }
}
