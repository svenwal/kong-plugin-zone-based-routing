#!/bin/sh
curl -i -X POST http://localhost:8001/plugins -F name=pre-function -F config.rewrite[1]=@zone-serverless.lua
