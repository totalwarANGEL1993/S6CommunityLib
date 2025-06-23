package twa.siedelwood.communitylib.junit;

import org.junit.jupiter.api.Test;
import twa.siedelwood.communitylib.utils.GithubUtils;

import java.io.File;

import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

public class GithubUtilsTest {
    @Test
    public void testGetLatestRelease() {
        String url = GithubUtils.getLatestRelease("totalwarANGEL1993", "libertica_release");
        assertNotNull(url);
    }

    @Test
    public void testDownloadReleaseSource() {
        String url = "https://github.com/totalwarANGEL1993/libertica_release/archive/refs/tags/Beta.zip";
        File destination = new File("var/update.zip");
        boolean success = GithubUtils.downloadReleaseSource(url, destination);
        assertTrue(success);
    }

    @Test
    public void testUpdateScript() throws Exception {
        String url = "https://github.com/totalwarANGEL1993/libertica_release/archive/refs/tags/Beta.zip";
        File destination = new File("var/update.zip");
        GithubUtils.downloadReleaseSource(url, destination);
        String scriptPath = "E:\\Repositories\\libertica\\java\\Librarian\\script\\update_test.bat";
        ProcessBuilder pb = new ProcessBuilder("cmd.exe", "/c", "start", "", scriptPath);
        pb.start();
    }
}
