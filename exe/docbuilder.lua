LibScribe = {
    DocDirectory = "../var/release/s6communitylib/doc",
    HtmlDirectory = "../var/release/s6communitylib/doc/modules",
    WebDirectory = "../web",
};

function LibScribe:UpdateDoc()
    -- Update files
    for _, File in pairs(self:ListFiles(self.HtmlDirectory)) do
        self:ReplaceHtmlElements(File, self.WebDirectory.. "/html/module.head.template.html");
        self:ReplaceSimpleMarkdownWithHtml(File);
    end

    -- Copy prism library
    os.execute("cp \"" ..self.WebDirectory.. "\"/css/prism.min.css \"" ..self.DocDirectory.. "\"");
    os.execute("cp \"" ..self.WebDirectory.. "\"/js/prism.min.js \"" ..self.DocDirectory.. "\"");
    os.execute("cp \"" ..self.WebDirectory.. "\"/js/prism-lua.min.js \"" ..self.DocDirectory.. "\"");
    os.execute("cp \"" ..self.WebDirectory.. "\"/js/prism-xml.min.js \"" ..self.DocDirectory.. "\"");
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
    nfc = nfc:gsub("```xml\n", "<pre><code class=\"language-xml\">");
    nfc = nfc:gsub("%s+xml```\n", "</code></pre>");
    nfc = nfc:gsub("%s%*%s*(.-)\n", "<li>%1</li>");
    nfc = nfc:gsub("`(.-)`", "<code>%1</code>");
    -- Replace parameter types
    nfc = nfc:gsub("</span>%s+any%s", "</span> <b>any</b> ");
    nfc = nfc:gsub("</span>%s+?%sany%s", "</span> (optional) <b>any</b> ");
    nfc = nfc:gsub("</span>%s+boolean%s", "</span> <b>boolean</b> ");
    nfc = nfc:gsub("</span>%s+?%sboolean%s", "</span> (optional) <b>boolean</b> ");
    nfc = nfc:gsub("</span>%s+number%s", "</span> <b>number</b> ");
    nfc = nfc:gsub("</span>%s+?%snumber%s", "</span> (optional) <b>number</b> ");
    nfc = nfc:gsub("</span>%s+float%s", "</span> <b>float</b> ");
    nfc = nfc:gsub("</span>%s+?%sfloat%s", "</span> (optional) <b>float</b> ");
    nfc = nfc:gsub("</span>%s+integer%s", "</span> <b>integer</b> ");
    nfc = nfc:gsub("</span>%s+?%sinteger%s", "</span> (optional) <b>integer</b> ");
    nfc = nfc:gsub("</span>%s+string%s", "</span> <b>string</b> ");
    nfc = nfc:gsub("</span>%s+?%sstring%s", "</span> (optional) <b>string</b> ");
    nfc = nfc:gsub("</span>%s+table%s", "</span> <b>table</b> ");
    nfc = nfc:gsub("</span>%s+?%stable%s", "</span> (optional) <b>table</b> ");
    nfc = nfc:gsub("</span>%s+function%s", "</span> <b>function</b> ");
    nfc = nfc:gsub("</span>%s+?%sfunction%s", "</span> (optional) <b>function</b> ");
    nfc = nfc:gsub("</span>%s+userdata%s", "</span> <b>userdata</b> ");
    nfc = nfc:gsub("</span>%s+?%suserdata%s", "</span> (optional) <b>userdata</b> ");
    -- Replace result types
    nfc = nfc:gsub("<ol>%s+any%s", "<ol><b>any</b> ");
    nfc = nfc:gsub("<li>%s+any%s", "<li><b>any</b> ");
    nfc = nfc:gsub("<ol>%s+boolean%s", "<ol><b>boolean</b> ");
    nfc = nfc:gsub("<li>%s+boolean%s", "<li><b>boolean</b> ");
    nfc = nfc:gsub("<ol>%s+number%s", "<ol><b>number</b> ");
    nfc = nfc:gsub("<li>%s+number%s", "<li><b>number</b> ");
    nfc = nfc:gsub("<ol>%s+float%s", "<ol><b>float</b> ");
    nfc = nfc:gsub("<li>%s+float%s", "<li><b>float</b> ");
    nfc = nfc:gsub("<ol>%s+integer%s", "<ol><b>integer</b> ");
    nfc = nfc:gsub("<li>%s+integer%s", "<li><b>integer</b> ");
    nfc = nfc:gsub("<ol>%s+string%s", "<ol><b>string</b> ");
    nfc = nfc:gsub("<li>%s+string%s", "<li><b>string</b> ");
    nfc = nfc:gsub("<ol>%s+table%s", "<ol><b>table</b> ");
    nfc = nfc:gsub("<li>%s+table%s", "<li><b>table</b> ");
    nfc = nfc:gsub("<ol>%s+function%s", "<ol><b>function</b> ");
    nfc = nfc:gsub("<li>%s+function%s", "<li><b>function</b> ");
    nfc = nfc:gsub("<ol>%s+userdata%s", "<ol><b>userdata</b> ");
    nfc = nfc:gsub("<li>%s+userdata%s", "<li><b>userdata</b> ");
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
function LibScribe:ReplaceHtmlElements(_File, _Tpl)
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