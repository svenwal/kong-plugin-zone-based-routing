# Serverless

If you can't or don't want to apply a custom plugin to you Kong installation you can instead also use the [Serverless Functions](https://docs.konghq.com/hub/kong-inc/serverless-functions/) plugin which comes as a default with your Kong installation.

I have created a script called `apply-serverless-plugin.sh` and the corresponding `zone-serverless.lua` which adds the same functionality as a script, but you can also achieve the same directly with this one easy admin-api all:

```bash
curl -i -X POST http://localhost:8001/plugins -F name=pre-function -F config.rewrite[1]='ngx.req.set_header("X-Zone", os.getenv("KONG_ZONE"))'
````

