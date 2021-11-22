package = "kong-plugin-zone-based-routing" 
version = "1.0.0-1"  

local pluginName = package:match("^kong%-plugin%-(.+)$")

supported_platforms = {"linux", "macosx"}
source = {
  url = "https://github.com/svenwal/kong-plugin-zone-based-routing",
  tag = "1.0.0"
}

description = {
  summary = "This plugin provides a lightweight ability to make data planes nodes zone aware and having routes based on where the request is incoming.",
  homepage = "https://github.com/svenwal/kong-plugin-zone-based-routing",
  license = "BSD 2-Clause Simplified License"
}

dependencies = {
}

build = {
  type = "builtin",
  modules = {
    ["kong.plugins."..pluginName..".handler"] = "kong/plugins/"..pluginName.."/handler.lua",
    ["kong.plugins."..pluginName..".schema"] = "kong/plugins/"..pluginName.."/schema.lua",
  }
}
