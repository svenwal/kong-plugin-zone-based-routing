local plugin = {
  PRIORITY = 1000, 
  VERSION = "1.0",
}

function plugin:rewrite(plugin_conf)
  local zone = os.getenv(plugin_conf.env_variable)
  ngx.req.set_header(plugin_conf.header_name, zone)
end

function plugin:access(plugin_conf)
  -- cleaning up the added header
  kong.service.request.clear_header(plugin_conf.header_name)
end

return plugin