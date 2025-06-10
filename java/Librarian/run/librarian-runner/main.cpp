#include <iostream>
#include <cstdlib>

int main(int argc, char** argv) {
	// Start in GUI mode
	if (argc == 1) {
		system("start /b %cd%\\..\\..\\jre\\bin\\java -Dfile.encoding=UTF8 -jar \"%cd%\\Librarian.jar\"");
		return 0;
	}
	
	// Start in console mode
    std::string command = "%cd%\\..\\..\\jre\\bin\\java -Dfile.encoding=UTF8 -jar \"%cd%\\Librarian.jar\"";
    for (int i = 1; i < argc; ++i) {
        command += " \"";
        command += argv[i];
        command += "\"";
    }
    int result = system(command.c_str());
    if (result != 0) {
        std::cerr << "Fehler beim Ausführen der JAR-Datei: " << result << std::endl;
        return 1;
    }
    return 0;
}
