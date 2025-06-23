package twa.siedelwood.communitylib.logic;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.exception.ExceptionUtils;
import twa.siedelwood.communitylib.logic.concat.ConcatinationManager;
import twa.siedelwood.communitylib.logic.config.ConfigurationManager;
import twa.siedelwood.communitylib.logic.dependency.DependencyManager;
import twa.siedelwood.communitylib.logic.dependency.model.Module;
import twa.siedelwood.communitylib.ui.MainWindow;
import twa.siedelwood.communitylib.ui.components.ExportPanel;
import twa.siedelwood.communitylib.utils.GithubUtils;

import javax.swing.*;
import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class ProgramController {
    private final ConcatinationManager concatinationManager;
    private final ConfigurationManager configurationManager;
    private final DependencyManager dependencyManager;

    private final List<Module> selectedModules = new ArrayList<>();

    public ProgramController(
        ConcatinationManager concatinationManager,
        ConfigurationManager configurationManager,
        DependencyManager dependencyManager
    ) {
        this.concatinationManager = concatinationManager;
        this.configurationManager = configurationManager;
        this.dependencyManager = dependencyManager;
    }

    /**
     * Exports the QSB to the target destination.
     * @param type Export type
     * @param destination Destination
     */
    public void exportQsb(ExportPanel.ExportType type, String destination) {
        MainWindow.getInstance().showProcessRunning();
        Thread thread = new Thread(() -> {
            try {
                List<Module> selectedModules = getSelectedModules();
                List<String> moduleList = selectedModules.stream().map(Module::getCanonicalName).collect(Collectors.toList());
                File destinationFile = new File(destination + File.separator + "s6communitylib");
                if (destinationFile.exists()) {
                    FileUtils.deleteDirectory(destinationFile);
                }
                destinationFile.mkdirs();
                if (ExportPanel.ExportType.SINGLE_FILE.equals(type)) {
                    concatinationManager.saveSingleFile(moduleList, destinationFile, "questsystembehavior.lua");
                }
                if (ExportPanel.ExportType.LIBRARY.equals(type)) {
                    concatinationManager.saveLibrary(moduleList, destinationFile);
                }
                MainWindow.getInstance().hideProcessRunning();
                JOptionPane.showMessageDialog(
                    MainWindow.getInstance(),
                    "QSB has been saved successfully.",
                    "Info",
                    JOptionPane.INFORMATION_MESSAGE
                );
            }
            catch (Exception e) {
                MainWindow.getInstance().hideProcessRunning();
                JOptionPane.showMessageDialog(
                    MainWindow.getInstance(),
                    ExceptionUtils.getStackTrace(e),
                    "Error",
                    JOptionPane.ERROR_MESSAGE
                );
            }
        });
        thread.start();
    }

    /**
     * Downloads the update, runs the update script and then self-closes.
     */
    public void updateProgram() {
        MainWindow.getInstance().showProcessRunning();
        Thread thread = new Thread(() -> {
            try {
                String url = GithubUtils.getLatestRelease("totalwarANGEL1993", "libertica_release");
                if (!GithubUtils.downloadReleaseSource(url, new File("var/update.zip"))) {
                    JOptionPane.showMessageDialog(
                        MainWindow.getInstance(),
                        "Unable to download update from: " + url,
                        "Error",
                        JOptionPane.ERROR_MESSAGE
                    );
                    return;
                }
                String scriptPath = "script\\update.bat";
                ProcessBuilder pb = new ProcessBuilder("cmd.exe", "/c", "start", "", scriptPath);
                pb.start();
                System.exit(0);
            }
            catch (Exception e) {
                MainWindow.getInstance().hideProcessRunning();
                JOptionPane.showMessageDialog(
                    MainWindow.getInstance(),
                    ExceptionUtils.getStackTrace(e),
                    "Error",
                    JOptionPane.ERROR_MESSAGE
                );
            }
        });
        thread.start();
    }

    /**
     * Returns the module list.
     * @return List of modules
     */
    public List<Module> getModuleList() {
        return dependencyManager.getModuleList();
    }

    /**
     * Returns the module and all of its ancestors as a list.
     * @param module Module
     * @return List of modules
     */
    public List<Module> getModuleAncestry(Module module) {
        return dependencyManager.getModuleAncestry(module);
    }

    /**
     * Returns the module and all modules depending on it.
     * @param module Module
     * @return List of modules
     */
    public List<Module> getModuleHeredity(Module module) {
        return dependencyManager.getModuleHeredity(module);
    }

    /**
     * Returns the selected modules.
     * @return Module List
     */
    public List<Module> getSelectedModules() {
        return this.selectedModules;
    }

    /**
     * Returns the export path for the QSB.
     * @return Path
     */
    public String getSavePath() {
        return (String) configurationManager.getConfig().getUserConfig().get("SavePath");
    }
}
