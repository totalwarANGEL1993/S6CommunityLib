package twa.librarian.librarian.ui.components;

import twa.librarian.librarian.logic.ProgramController;
import twa.librarian.librarian.logic.dependency.model.Module;

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
 * UI for the assemble operation.
 */
public class AssemblePanel extends JPanel {
    private final ProgramController controller;
    private final JLabel moduleDescriptionText;
    private final JList<Module> leftModuleSelect;
    private final JList<Module> rightModuleSelect;

    private final List<Module> leftModuleList = new ArrayList<>();
    private final List<Module> rightModuleList = new ArrayList<>();

    public AssemblePanel(JPanel parent, ProgramController controller) {
        super(null);
        this.controller = controller;

        setSize(parent.getWidth() - 25, parent.getHeight() - 185);
        setBorder(BorderFactory.createTitledBorder("Assemble"));
        setLocation(5, 0);
        parent.add(this);

        moduleDescriptionText = new JLabel("<html></html>");
        moduleDescriptionText.setSize(getWidth() - 20, 40);
        moduleDescriptionText.setLocation(10, getHeight() - 50);
        moduleDescriptionText.setFont(new Font(Font.DIALOG, Font.PLAIN, 12));
        add(moduleDescriptionText);

        JLabel leftModuleText = new JLabel("Available modules:");
        leftModuleText.setFont(new Font(Font.DIALOG, Font.PLAIN, 12));
        leftModuleText.setSize(440, 15);
        leftModuleText.setLocation(10, 30);
        add(leftModuleText);

        JLabel rightModuleText = new JLabel("Selected modules:");
        rightModuleText.setFont(new Font(Font.DIALOG, Font.PLAIN, 12));
        rightModuleText.setSize(440, 15);
        rightModuleText.setLocation(getWidth() - 450, 30);
        add(rightModuleText);

        rightModuleSelect = new JList<>();
        leftModuleSelect = new JList<>();

        leftModuleSelect.setSelectionMode(ListSelectionModel.MULTIPLE_INTERVAL_SELECTION);
        leftModuleSelect.addListSelectionListener(e -> {
            SwingUtilities.invokeLater(() -> {
                int selectedIndex = leftModuleSelect.getSelectedIndex();
                updateModuleDescription(leftModuleSelect, selectedIndex);
            });
        });
        JScrollPane leftModuleScrollPane = new JScrollPane(leftModuleSelect);
        leftModuleScrollPane.setSize(440, 510);
        leftModuleScrollPane.setLocation(10, 50);
        add(leftModuleScrollPane);

        rightModuleSelect.setSelectionMode(ListSelectionModel.MULTIPLE_INTERVAL_SELECTION);
        rightModuleSelect.addListSelectionListener(e -> {
            SwingUtilities.invokeLater(() -> {
                int selectedIndex = rightModuleSelect.getSelectedIndex();
                updateModuleDescription(rightModuleSelect, selectedIndex);
            });
        });
        JScrollPane rightModuleScrollPane = new JScrollPane(rightModuleSelect);
        rightModuleScrollPane.setSize(440, 510);
        rightModuleScrollPane.setLocation(getWidth() - 450, 50);
        add(rightModuleScrollPane);

        int xCenter = (int) ((getWidth() * 0.5) - 25);
        int YCenter = (int) (getHeight() * 0.5);

        // <>≪≫
        // ◀◁▷▶

        JButton deselectAllButton = new JButton("≪");
        deselectAllButton.setSize(50, 50);
        deselectAllButton.setLocation(xCenter, YCenter - 140);
        deselectAllButton.setFont(new Font("Segoe UI Symbol", Font.BOLD, 16));
        deselectAllButton.setToolTipText("Move all modules back.");
        deselectAllButton.addActionListener(e -> onModuleSelectButtonClicked(ModuleAction.DESELECT_ALL, e));
        add(deselectAllButton);

        JButton deselectButton = new JButton("<");
        deselectButton.setSize(50, 50);
        deselectButton.setLocation(xCenter, YCenter - 85);
        deselectButton.setFont(new Font("Segoe UI Symbol", Font.BOLD, 18));
        deselectButton.setToolTipText("Move selected module(s) back.");
        deselectButton.addActionListener(e -> onModuleSelectButtonClicked(ModuleAction.DESELECT, e));
        add(deselectButton);

        JButton resetButton = new JButton("↺");
        resetButton.setSize(50, 50);
        resetButton.setLocation(xCenter, YCenter - 30);
        resetButton.setFont(new Font("Segoe UI Symbol", Font.BOLD, 18));
        resetButton.setToolTipText("Restores the default.");
        resetButton.addActionListener(e -> onModuleSelectButtonClicked(ModuleAction.RESET, e));
        add(resetButton);

        JButton selectButton = new JButton(">");
        selectButton.setSize(50, 50);
        selectButton.setLocation(xCenter, YCenter + 25);
        selectButton.setFont(new Font("Segoe UI Symbol", Font.BOLD, 18));
        selectButton.setToolTipText("Move selected module(s) right.");
        selectButton.addActionListener(e -> onModuleSelectButtonClicked(ModuleAction.SELECT, e));
        add(selectButton);

        JButton selectAllButton = new JButton("≫");
        selectAllButton.setSize(50, 50);
        selectAllButton.setLocation(xCenter, YCenter + 80);
        selectAllButton.setFont(new Font("Segoe UI Symbol", Font.BOLD, 16));
        selectAllButton.setToolTipText("Move all modules right.");
        selectAllButton.addActionListener(e -> onModuleSelectButtonClicked(ModuleAction.SELECT_ALL, e));
        add(selectAllButton);

        resetModuleLists();
    }

    private void updateModuleDescription(JList<Module> source, int firstIndex) {
        String text = "";
        if (null != source && firstIndex > -1) {
            Module module = source.getModel().getElementAt(firstIndex);
            text = "<html><b>Beschreibung:</b><br>" + module.getDescription() + "</html>";
        }
        moduleDescriptionText.setText(text);
    }

    private void onModuleSelectButtonClicked(ModuleAction action, ActionEvent e) {
        switch (action) {
            case DESELECT_ALL:
                deselectAllModules();
                break;
            case DESELECT:
                deselectChosenModules();
                break;
            case RESET:
                resetModuleLists();
                break;
            case SELECT:
                selectChosenModules();
                break;
            case SELECT_ALL:
                selectAllModules();
                break;
        }
    }

    private void deselectAllModules() {
        for (Module module : rightModuleList.stream().collect(Collectors.toList())) {
            final List<Module> moduleHeredity = controller.getModuleHeredity(module);
            for (Module heir : moduleHeredity) {
                if (!heir.isMandatory()) {
                    rightModuleList.remove(heir);
                    if (!leftModuleList.contains(heir)) {
                        leftModuleList.add(heir);
                    }
                }
            }
        }
        updateModuleLists();
    }

    private void deselectChosenModules() {
        for (Module module : rightModuleSelect.getSelectedValuesList()) {
            final List<Module> moduleHeredity = controller.getModuleHeredity(module);
            for (Module heir : moduleHeredity) {
                if (!heir.isMandatory()) {
                    rightModuleList.remove(heir);
                    if (!leftModuleList.contains(heir)) {
                        leftModuleList.add(heir);
                    }
                }
            }
        }
        updateModuleLists();
    }

    private void resetModuleLists() {
        List<Module> baseModuleList = filterInternalModules(controller.getModuleList());
        Module coreModule = baseModuleList.stream().filter((m) -> m.getCanonicalName().equals("core/Core")).findFirst().orElse(null);
        List<Module> coreAncestry = controller.getModuleAncestry(coreModule);
        baseModuleList.removeAll(coreAncestry);
        leftModuleList.clear();
        leftModuleList.addAll(baseModuleList);
        rightModuleList.clear();
        for (Module m : coreAncestry) {
            m.setMandatory(true);
            rightModuleList.add(m);
        }
        updateModuleLists();
    }

    private void selectChosenModules() {
        for (Module module : leftModuleSelect.getSelectedValuesList()) {
            final List<Module> moduleAncestry = controller.getModuleAncestry(module);
            for (Module ancestor : moduleAncestry) {
                if (!rightModuleList.contains(ancestor)) {
                    rightModuleList.add(ancestor);
                }
                leftModuleList.remove(ancestor);
            }
        }
        updateModuleLists();
    }

    private void selectAllModules() {
        for (Module module : leftModuleList.stream().collect(Collectors.toList())) {
            final List<Module> moduleAncestry = controller.getModuleAncestry(module);
            for (Module ancestor : moduleAncestry) {
                if (!rightModuleList.contains(ancestor)) {
                    rightModuleList.add(ancestor);
                }
                leftModuleList.remove(ancestor);
            }
        }
        updateModuleLists();
    }

    private void updateModuleLists() {
        List<Module> tmpLeftList = filterInternalModules(leftModuleList);
        List<Module> tmpRightList = filterInternalModules(rightModuleList);

        leftModuleList.clear();
        leftModuleList.addAll(tmpLeftList);
        rightModuleList.clear();
        rightModuleList.addAll(tmpRightList);

        // Always sort for better overview
        leftModuleList.sort(
            Comparator.comparingInt((ToIntFunction<Module>) v -> v.getCanonicalName().split("/").length)
                .thenComparing(Module::getCanonicalName)
        );

        leftModuleSelect.setListData(new Vector<>(leftModuleList));
        rightModuleSelect.setListData(new Vector<>(rightModuleList));

        // Save selection
        controller.getSelectedModules().clear();
        controller.getSelectedModules().addAll(rightModuleList);
        // Ensure last add are always visible
        int lastIndex = rightModuleSelect.getModel().getSize() - 1;
        if (lastIndex >= 0) {
            rightModuleSelect.ensureIndexIsVisible(lastIndex);
        }
    }

    private List<Module> filterInternalModules(List<Module> moduleList) {
        return moduleList
            .stream()
            .filter(module -> ("core/Core".equals(module.getCanonicalName()) ||
                !module.getCanonicalName().contains("_")) &&
                !"core/QSB".equals(module.getCanonicalName()))
            .collect(Collectors.toList());
    }

    public enum ModuleAction {
        DESELECT_ALL,
        DESELECT,
        RESET,
        SELECT,
        SELECT_ALL
    }
}
