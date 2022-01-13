#!/usr/bin/env bash

set -e

# Upload EaaS secret
cfy secrets create eaas_params -uf secrets/eaas_params.json

# Upload AWS blueprint
zip -r aws_blueprint.zip aws/
cfy blueprint upload -b aws-nginx -n aws-nginx.yaml aws_blueprint.zip

# Upload GCP blueprint
zip -r gcp_blueprint.zip gcp/
cfy blueprint upload -b gcp-nginx -n gcp-nginx.yaml gcp_blueprint.zip

# Cleanup
rm aws_blueprint.zip gcp_blueprint.zip

# Upload main EaaS blueprint
pushd ..
zip -r eaas_nginx_blueprint.zip wwt-poc/
cfy blueprint upload -b nginx-eaas -n eaas.yaml eaas_nginx_blueprint.zip

# Cleanup
rm eaas_nginx_blueprint.zip
popd
