# Serverless

If you can't (or don't want to) apply a custom plugin to your Kong installation you can instead also use the [Serverless Functions](https://docs.konghq.com/hub/kong-inc/serverless-functions/) plugin which comes as a default with your Kong installation.

I have created a script called `apply-serverless-plugin.sh` and the corresponding `zone-serverless.lua` which adds the same functionality as a script.

You can also achieve the same directly with this one easy admin-api all:

```bash
curl -i -X POST http://localhost:8001/plugins -F name=pre-function -F "config.rewrite[1]=ngx.req.set_header('X-Zone', os.getenv('KONG_ZONE'))"
````
**IMPORTANT NOTE 1:** this plugin must be applied globally (not per service or route) as the header must be set before route matching even happens

**IMPORTANT NOTE 2:** the serverless plugin by default runs in a sandbox Lua environment. Because of this access to `os.getenv` is not allowed on a node.
In order to invoke this function you need to set [untrusted_lua](https://docs.konghq.com/gateway/2.6.x/reference/configuration/#untrusted_lua) to `on` (or specify to only enable this `os.` function as desribed in the following paragraphs in the documentation)
