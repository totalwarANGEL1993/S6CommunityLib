package twa.librarian.librarian.ui.components;

import twa.librarian.librarian.logic.ProgramController;
import twa.librarian.librarian.ui.MainWindow;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.io.File;

/**
 * UI for the export operation.
 */
public class ExportPanel extends JPanel {
    private final ProgramController controller;
    private final JTextField directoryTextField;

    private ExportType exportType = ExportType.SINGLE_FILE;

    public ExportPanel(JPanel parent, ProgramController controller) {
        super(null);
        this.controller = controller;

        setSize(parent.getWidth() - 25, 80);
        setBorder(BorderFactory.createTitledBorder("Export"));
        setLocation(5, parent.getHeight() - 185);
        parent.add(this);

        directoryTextField = new JTextField();
        directoryTextField.setText(getInitialPath());
        directoryTextField.setFont(new Font(Font.MONOSPACED, Font.PLAIN, 12));
        directoryTextField.setSize(getWidth() - 280, 25);
        directoryTextField.setEditable(false);
        directoryTextField.setLocation(140, 40);
        add(directoryTextField);

        JButton updateButton = new JButton("Search");
        updateButton.addActionListener(this::onSelectDirectoryButtonClicked);
        updateButton.setSize(120, 25);
        updateButton.setLocation(10, 40);
        add(updateButton);

        JButton saveButton = new JButton("Save");
        saveButton.addActionListener(this::onSaveButtonClicked);
        saveButton.setSize(120, 25);
        saveButton.setLocation(getWidth() - 130, 40);
        add(saveButton);

        JRadioButton exportTypeOption1 = new JRadioButton();
        exportTypeOption1.setFont(new Font(Font.DIALOG, Font.PLAIN, 12));
        exportTypeOption1.setSize(150, 15);
        exportTypeOption1.setLocation(350, 20);
        exportTypeOption1.setAction(new AbstractAction("As single file") {
            @Override
            public void actionPerformed(ActionEvent e) {
                onExportTypeRadioChanged(ExportType.SINGLE_FILE, e);
            }
        });
        add(exportTypeOption1);

        JRadioButton exportTypeOption2 = new JRadioButton();
        exportTypeOption2.setFont(new Font(Font.DIALOG, Font.PLAIN, 12));
        exportTypeOption2.setSize(150, 15);
        exportTypeOption2.setLocation(500, 20);
        exportTypeOption2.setAction(new AbstractAction("As library") {
            @Override
            public void actionPerformed(ActionEvent e) {
                onExportTypeRadioChanged(ExportType.LIBRARY, e);
            }
        });
        add(exportTypeOption2);

        ButtonGroup exportTypeGroup = new ButtonGroup();
        exportTypeGroup.add(exportTypeOption1);
        exportTypeGroup.add(exportTypeOption2);
        exportTypeOption1.setSelected(true);
    }

    private String getInitialPath() {
        String savePath = controller.getSavePath();
        if (null != savePath && !"".equals(savePath)) {
            return savePath;
        }
        return System.getProperty("user.home") + File.separator + "Downloads";
    }

    private void onSelectDirectoryButtonClicked(ActionEvent e) {
        JFileChooser chooser = new JFileChooser();
        chooser.setFileSelectionMode(JFileChooser.DIRECTORIES_ONLY);
        chooser.setCurrentDirectory(new File(directoryTextField.getText()));
        int result = chooser.showOpenDialog(MainWindow.getInstance());
        if (result == JFileChooser.APPROVE_OPTION) {
            File selectedDir = chooser.getSelectedFile();
            directoryTextField.setText(selectedDir.getAbsolutePath());
        }
    }

    private void onExportTypeRadioChanged(ExportType type, ActionEvent event) {
        exportType = type;
    }

    private void onSaveButtonClicked(ActionEvent e) {
        controller.exportQsb(exportType, directoryTextField.getText());
    }

    public enum ExportType {
        SINGLE_FILE,
        LIBRARY
    }
}
