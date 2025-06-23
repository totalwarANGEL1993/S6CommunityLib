#include <iostream>
#include <cstdlib>
#include <windows.h>

int startCommandlineProcess(int argc, char** argv);
int startInvisibleProcess(int argc, char** argv);

int main(int argc, char** argv) {
	if (argc == 1) {
		return startInvisibleProcess(argc, argv);
	}
    return startCommandlineProcess(argc, argv);
}

int startInvisibleProcess(int argc, char** argv) {
    // Get PWD
    char pwd[MAX_PATH];
    GetCurrentDirectoryA(MAX_PATH, pwd);
    // Make window invisible
    STARTUPINFOA si = { sizeof(STARTUPINFOA) };
    PROCESS_INFORMATION pi;
    si.dwFlags = STARTF_USESHOWWINDOW;
    si.wShowWindow = SW_HIDE;
    // Create command string
    std::string command;
    command += "..\\jre\\bin\\java -Dfile.encoding=UTF8 -jar ";
    command += "S6CommunityLib.jar\"";
    // Create process
    char* cmdLine = _strdup(command.c_str());
    if (CreateProcessA( NULL, cmdLine, NULL, NULL, FALSE, 0, NULL, NULL, &si, &pi)) {
        CloseHandle(pi.hProcess);
        CloseHandle(pi.hThread);
    }
    else {
        MessageBoxA(NULL, "Failed to create new process! Aborting...", "Error", MB_OK | MB_ICONERROR);
    }
    free(cmdLine);
    return 0;
}

int startCommandlineProcess(int argc, char** argv) {
    std::string command = "%cd%\\..\\jre\\bin\\java -Dfile.encoding=UTF8 -jar \"%cd%\\S6CommunityLib.jar\"";
    for (int i = 1; i < argc; ++i) {
        command += " \"";
        command += argv[i];
        command += "\"";
    }
    int result = system(command.c_str());
    if (result != 0) {
        std::cerr << "Error runnung JAR file: " << result << std::endl;
        return 1;
    }
    return 0;
}
