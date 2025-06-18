package twa.libertica.libertica.ui;

import twa.libertica.libertica.logic.ProgramController;
import twa.libertica.libertica.ui.components.AssemblePanel;
import twa.libertica.libertica.ui.components.ExportPanel;
import twa.libertica.libertica.ui.components.UpdatePanel;

import javax.swing.*;
import java.awt.*;
import java.util.Objects;

public class MainWindow extends JFrame {
    private static MainWindow instance;

    private final ProgramController controller;
    private final JPanel view;
    private final AssemblePanel assemblePanel;
    private final ExportPanel exportPanel;
    private final UpdatePanel updatePanel;

    public AssemblePanel getAssemblePanel() {
        return assemblePanel;
    }

    public ExportPanel getExportPanel() {
        return exportPanel;
    }

    public UpdatePanel getUpdatePanel() {
        return updatePanel;
    }

    public JPanel getView() {
        return view;
    }

    public static MainWindow getInstance() {
        Objects.requireNonNull(instance);
        return instance;
    }

    public void display() {
        setVisible(true);
    }

    public void conceal() {
        setVisible(false);
    }

    private MainWindow(ProgramController controller, String title) throws HeadlessException {
        super(title);
        this.controller = controller;

        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setSize(1000, 800);
        setLocationRelativeTo(null);
        setVisible(false);
        setResizable(false);

        view = new JPanel(null);
        view.setSize(getWidth(), getHeight());
        view.setLocation(0, 0);
        view.setVisible(true);
        add(view);

        assemblePanel = new AssemblePanel(view, controller);
        exportPanel = new ExportPanel(view, controller);
        updatePanel = new UpdatePanel(view, controller);
    }

    public static MainWindow create(ProgramController controller, String title) {
        if (null == instance) {
            instance = new MainWindow(controller, title);
        }
        return instance;
    }
}
