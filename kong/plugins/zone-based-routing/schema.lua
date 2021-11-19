local typedefs = require "kong.db.schema.typedefs"

local plugin_name = ({...})[1]:match("^kong%.plugins%.([^%.]+)")

local schema = {
  name = plugin_name,
  fields = {
    { consumer = typedefs.no_consumer },
    { protocols = typedefs.protocols_http },
    { config = {
        type = "record",
        fields = {
          { env_variable = {
              type = "string",
              required = true,
              default = "KONG_ZONE_NAME" } },
          { header_name = {
              type = "string",
              required = true,
              default = "X-Kong-Zone" } },
        },
        entity_checks = {
        },
      },
    },
  },
}

return schema
