package twa.libertica.libertica.logic.text.model;

import org.json.JSONArray;
import org.json.JSONObject;

import java.util.LinkedHashMap;
import java.util.Map;

public class StringTable {
    private String location;

    private Map<String, String> strings = new LinkedHashMap<>();

    public StringTable(String location, JSONObject data) {
        this.location = location;
        JSONArray sourceArray = data.getJSONArray("Strings");
        for (int i= 0; i < sourceArray.length(); i++) {
            JSONArray array = sourceArray.getJSONArray(i);
            strings.put(array.getString(0), array.getString(1));
        }
    }

    public String getLocation() {
        return location;
    }

    public String getString(String key) {
        return strings.get(key);
    }

    public void setString(String key, String value) {
        strings.put(key, value);
    }

    /**
     * Converts the internal model back to Json for saving.
     * @return Json object of strings
     */
    public JSONObject toJson() {
        JSONObject out = new JSONObject();
        JSONArray list = new JSONArray();
        for (Map.Entry<String, String> entry : strings.entrySet()) {
            JSONArray array = new JSONArray();
            array.put(entry.getKey());
            array.put(entry.getValue());
            list.put(array);
        }
        out.put("Strings", list);
        return out;
    }
}
