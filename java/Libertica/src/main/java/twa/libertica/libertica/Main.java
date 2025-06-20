package twa.libertica.libertica;

import twa.libertica.libertica.logic.ProgramController;
import twa.libertica.libertica.logic.concat.ConcatinationManager;
import twa.libertica.libertica.logic.config.ConfigurationManager;
import twa.libertica.libertica.logic.dependency.DependencyManager;
import twa.libertica.libertica.ui.MainWindow;

import javax.swing.*;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        if (args.length == 0) {
            SwingUtilities.invokeLater(() -> {
                ConfigurationManager configurer = new ConfigurationManager("config/config.json");
                DependencyManager manager = new DependencyManager(configurer);
                ConcatinationManager concatinater = new ConcatinationManager(configurer, manager);
                ProgramController controller = new ProgramController(concatinater, configurer, manager);
                MainWindow window = MainWindow.create(controller, "Libertica");
                window.display();
            });
            return;
        }

        Main main = new Main();
        if (args[0].equals("lib") || args[0].equals("-l")) {
            String destination = args[1];
            String[] modules = Arrays.copyOfRange(args, 2, args.length);
            main.createLibrary(destination, modules);
        }
        else if (args[0].equals("single") || args[0].equals("-s")) {
            String destination = args[1];
            String[] modules = Arrays.copyOfRange(args, 2, args.length);
            main.createSingleFile(destination, modules);
        }
    }

    private List<String> getModules(String... modules) throws IOException {
        List<String> moduleList = new ArrayList<>();
        if (new File(modules[0]).exists()) {
            File loadOrder = new File(modules[0]);
            List<String> lines = Files.readAllLines(Paths.get(loadOrder.getAbsolutePath()));
            for (String line : lines) {
                if (!"".equals(line)) {
                    moduleList.add(line);
                }
            }
        }
        else {
            moduleList = Arrays.asList(modules);
        }
        return moduleList;
    }

    private void createLibrary(String destination, String... modules) {
        try {
            ConfigurationManager configManager = new ConfigurationManager("config/config.json");
            DependencyManager dependencyManager = new DependencyManager(configManager);
            ConcatinationManager concatinationManager = new ConcatinationManager(configManager, dependencyManager);

            List<String> moduleList = getModules(modules);
            concatinationManager.saveLibrary(moduleList, new File(destination));
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void createSingleFile(String destination, String... modules) {
        try {
            ConfigurationManager configManager = new ConfigurationManager("config/config.json");
            DependencyManager dependencyManager = new DependencyManager(configManager);
            ConcatinationManager concatinationManager = new ConcatinationManager(configManager, dependencyManager);

            List<String> moduleList = getModules(modules);
            concatinationManager.saveSingleFile(moduleList, new File(destination), "questsystembehavior.lua");
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }
}
