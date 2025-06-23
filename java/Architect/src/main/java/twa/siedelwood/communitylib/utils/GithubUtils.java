package twa.siedelwood.communitylib.utils;

import org.json.JSONObject;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;

/**
 * Utils class to work with a Github repository.
 */
public class GithubUtils {
    /**
     * Returns the latest release from the repositories archive.
     * @param owner Owner of repository
     * @param repository Name of repository
     * @return URL of latest release
     */
    public static String getLatestRelease(String owner, String repository) {
        String urlString = null;
        try {
            String apiUrl = String.format("https://api.github.com/repos/%s/%s/releases/latest", owner, repository);
            HttpURLConnection connection = null;
            connection = (HttpURLConnection) new URL(apiUrl).openConnection();
            connection.setRequestProperty("Accept", "application/vnd.github.v3+json");
            connection.setRequestProperty("User-Agent", "Java");
            InputStream inputStream = connection.getInputStream();

            String jsonText = readStreamToString(inputStream);
            JSONObject json = new JSONObject(jsonText);
            String tag = json.getString("tag_name");
            System.out.println("Release-Tag: " + tag);
            urlString = "https://github.com/" + owner + "/" + repository + "/archive/refs/tags/" + tag + ".zip";
        }
        catch (IOException ignore) {}
        return urlString;
    }

    /**
     * Downloads the release the link is pointing to as the passed file.
     * @param url URL to release
     * @param destination Destination file
     * @return Downloading was successful
     */
    public static boolean downloadReleaseSource(String url, File destination) {
        try {
            destination.delete();
            destination.getParentFile().mkdirs();
            try (InputStream in = new URL(url).openStream();
                FileOutputStream out = new FileOutputStream(destination)) {
                byte[] buffer = new byte[8192];
                int bytesRead;
                while ((bytesRead = in.read(buffer)) != -1) {
                    out.write(buffer, 0, bytesRead);
                }
            }
            return true;
        }
        catch (IOException e) {
            return false;
        }
    }

    private static String readStreamToString(InputStream inputStream) throws IOException {
        StringBuilder sb = new StringBuilder();
        BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream, StandardCharsets.UTF_8));
        String line;
        while ((line = reader.readLine()) != null) {
            sb.append(line);
        }
        return sb.toString();
    }
}