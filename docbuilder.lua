local htmlparser = require("htmlparser");

LibScribe = {
    DocDirectory = "var/doc",
    HtmlDirectory = "var/doc/modules",
};

function LibScribe:UpdateDoc()
    -- Update files
    for _, File in pairs(self:ListFiles(self.HtmlDirectory)) do
        self:ReplaceHtmlHead(File, "web/html/module.head.template.html");
        self:ReplaceSimpleMarkdownWithHtml(File);
    end

    -- Copy prism library
    os.execute("cp web/css/prism.min.css \"" ..self.DocDirectory.. "\"");
    os.execute("cp web/js/prism.min.js \"" ..self.DocDirectory.. "\"");
    os.execute("cp web/js/prism-lua.min.js \"" ..self.DocDirectory.. "\"");
end

function LibScribe:ReplaceSimpleMarkdownWithHtml(_File)
    local fh, fc;

    -- Get file content
    fh = io.open(_File, "r");
    assert(fh ~= nil, "Could not find file: " ..tostring(_File));
    fc = fh:read("*all");
    fh:close();
    local nfc;
    -- Replace markdown
    nfc = fc:gsub("\r", "");
    nfc = nfc:gsub("####%s*(.-)%s*\n", "<h3>%1</h3>");
    nfc = nfc:gsub("```lua\n", "<pre><code class=\"language-lua\">");
    nfc = nfc:gsub("%s+```\n", "</code></pre>");
    -- Write file
    os.remove(_File);
    fh = io.open(_File, "w");
    assert(fh ~= nil, "File not created: " ..tostring(_File));
    fh:write(nfc);
    fh:close();
end

--- Replaces the head section of a doc file with a template.
--- @param _File string Path to file
--- @param _Tpl string Path to template
function LibScribe:ReplaceHtmlHead(_File, _Tpl)
    local fh, FileContent, TplContent;

    -- Get template content
    fh = io.open(_Tpl, "r");
    assert(fh ~= nil, "Could not find template: " ..tostring(_Tpl));
    TplContent = fh:read("*all");
    fh:close();
    -- Get file content
    fh = io.open(_File, "r");
    assert(fh ~= nil, "Could not find file: " ..tostring(_File));
    fc = fh:read("*all");
    fh:close();
    local tmp, nfc, s1, e1, s2, e2;
    nfc = fc;
    -- Replace header
    s1,e1 = nfc:find("<head>");
    s2,e2 = nfc:find("</head>");
    tmp = nfc:sub(1, s1-1) .. TplContent .. nfc:sub(e2+1);
    nfc = tmp;
    -- Remove function list
    if _File:find("modules/comfort") then
        s1,e1 = nfc:find("<h2><a%shref=\"#Functions\">");
        s2,e2 = nfc:find("<h2 class=\"section-header", nil, true);
        os.execute("echo \""..tostring(s1)..","..tostring(e1)..","..tostring(s2)..","..tostring(e2).."\" > foo.txt")
        tmp = nfc:sub(1, s1-1) .. nfc:sub(s2-1);
        nfc = tmp;
    end
    -- Write file
    os.remove(_File);
    fh = io.open(_File, "w");
    assert(fh ~= nil, "File not created: " ..tostring(_File));
    fh:write(nfc);
    fh:close();
end

--- Returns a list of all files in the directory.
--- @param _Path string Path to directory
--- @return table Files List of files
function LibScribe:ListFiles(_Path)
    os.execute("ls \"" .._Path.. "\" > files.tmp.txt");
    local Paths = {};
    for line in io.lines("files.tmp.txt") do
        table.insert(Paths, _Path .. "/" ..line);
    end
    os.execute("rm files.tmp.txt");
    return Paths;
end

--- Returns if the file is an directory.
--- @param _File string Path to file
--- @return boolean IsDir File is directory
function LibScribe:IsDir(_File)
    return self:FileExists(_File.. "/");
end

--- Checks if the file does exist.
--- @param _File string Path to file
--- @return boolean Exists File does exist
--- @return string? Error Optional error text
function LibScribe:FileExists(_File)
    local ok, err, code = os.rename(_File, _File);
    if not ok then
        if code == 13 then
            return true;
        end
    end
    return ok, err;
end

LibScribe:UpdateDoc()