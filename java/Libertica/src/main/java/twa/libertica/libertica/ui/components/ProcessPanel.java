package twa.libertica.libertica.ui.components;

import twa.libertica.libertica.logic.ProgramController;
import twa.libertica.libertica.logic.dependency.model.Module;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Vector;
import java.util.function.ToIntFunction;
import java.util.stream.Collectors;

/**
 * UI for a non-deterministic running process.
 */
public class ProcessPanel extends JPanel {
    private final ProgramController controller;

    public ProcessPanel(JPanel parent, ProgramController controller) {
        super(null);
        this.controller = controller;

        setSize(parent.getWidth(), parent.getHeight());
        setLocation(0, 0);
        parent.add(this);

        JLabel infoText = new JLabel("Please wait...");
        infoText.setFont(new Font(Font.DIALOG, Font.PLAIN, 12));
        infoText.setSize(getWidth() - 200, 15);
        infoText.setLocation(100, (int)(getHeight() * 0.4) + 5);
        infoText.setVisible(true);
        add(infoText);

        JProgressBar progressBar = new JProgressBar();
        progressBar.setIndeterminate(true);
        progressBar.setSize(getWidth() - 200, 30);
        progressBar.setLocation(100, (int)(getHeight() * 0.4) + 20);
        progressBar.setVisible(true);
        add(progressBar);

        setVisible(false);
    }
}
