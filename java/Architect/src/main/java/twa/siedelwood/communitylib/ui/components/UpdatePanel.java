package twa.siedelwood.communitylib.ui.components;

import twa.siedelwood.communitylib.logic.ProgramController;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;

/**
 * UI for the update operation.
 */
public class UpdatePanel extends JPanel {
    private final ProgramController controller;

    public UpdatePanel(JPanel parent, ProgramController controller) {
        super(null);
        this.controller = controller;

        setSize(parent.getWidth() - 25, 55);
        setBorder(BorderFactory.createTitledBorder("Update"));
        setLocation(5, parent.getHeight() - 100);
        parent.add(this);

        JLabel infoText = new JLabel("Download the latest release from the remote repository.");
        infoText.setFont(new Font(Font.DIALOG, Font.PLAIN, 12));
        infoText.setSize(getWidth() - 25, 20);
        infoText.setLocation(10, 20);
        add(infoText);

        JButton updateButton = new JButton("Update");
        updateButton.addActionListener(this::onUpdateButtonClicked);
        updateButton.setSize(120, 25);
        updateButton.setLocation(getWidth() - 130, 18);
        add(updateButton);
    }

    private void onUpdateButtonClicked(ActionEvent e) {
        controller.updateProgram();
    }
}
