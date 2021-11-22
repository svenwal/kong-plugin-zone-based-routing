# Zone based routing plugin for Kong

Note: if you don't want or can't install a custom plugin have a look at the [serverless]<serverless> folder in this repository.

## What it does

This plugin provides a lightweight ability to make data planes nodes zone aware and having routes based on where the request is incoming.

The idea behind is having a backend scaled out into multiple zone (regions, cloud-providers, data centers, ...) and each individual Kong data plane should route the traffic only to the backend in the same zone.

| Zone | Data plane | Route | Backend |
|---|---|---|---|
| aws-europe1 | hosted on AWS | Path /myRoute, Header aws-europe1 | Replica on AWS |
| azure-us-east  | hosted on Azure | Path /myRoute, Header azure-us-east | Replica on Azure |
| on-premises | hosted on on-premises | Path /myRoute, Header on-premises | Replica on on-premises |
| default | whatever is prefered | Path /myRoute | whatever is prefered |

## Prerequisites

As this plugin depends on a per data plane node parameter the nodes need to be started with two environment variables being set. Inline this can for example achieved like

```bash
KONG_ZONE_NAME=azure-us-east KONG_NGINX_MAIN_ENV=KONG_ZONE_NAME kong restart
```

* KONG_ZONE_NAME: freely definable environment variable (see also schema.lua) which hosts the zone name of the started data plane
* KONG_NGINX_MAIN_ENV: needs to be set to the environment variable above as default security settings are not exporting environment variables to Kong plugins

## Parameters

|FORM PARAMETER|DEFAULT|DESCRIPTION|
|:----|:------:|------:|
|config.env_variable|KONG_ZONE_NAME|The name of the environment variable set on the Kong node|
|config.header_name|X-Kong-Zone|The header name which will be used for storing the zone in the request|

## Usage

As this plugin is running before any route matching has taken place *it can only be applied globally*, for example:

```bash
curl -X POST http://localhost:8001/plugins --data "name=zone-based-routing
```

or using deck:

```YAML
plugins:
- name: zone-based-routing
```

The plugin only creates a header on the request, the routing itself then needs to be done with routes listening on the created header:

```bash
curl -X POST http://localhost:8001/services/my-service-on-aws/routes \
  --data "name=zone-based-routing-aws" \
  --data 'paths[]=/myRoute' \
  --data 'headers[].X-Kong-Zone[]=aws-europe1'

curl -X POST http://localhost:8001/services/my-service-on-azure/routes \
  --data "name=zone-based-routing-azure" \
  --data 'paths[]=/myRoute' \
  --data 'headers[].X-Kong-Zone[]=aws-europe1azure-us-east'

curl -X POST http://localhost:8001/services/my-service-on-whatever-default/routes \
  --data "name=zone-based-routing-default" \
  --data 'paths[]=/myRoute'
```
