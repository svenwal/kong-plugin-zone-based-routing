return function()
  ngx.req.set_header('X-Zone', os.getenv('KONG_ZONE'))
end