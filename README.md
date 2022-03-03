# WWT PoC

## Blueprints

* `aws-nginx.yaml` - Instantiates one or more instances on AWS
* `gcp-nginx.yaml` - Instantiates one or more instances on GCP
* `eaas.yaml` - Uses service composition to deploy one or more app servers, configured via Ansible, on AWS or GCP.

# Prerequisites

The blueprints assume that you have the following secrets defined:

* `aws_access_key_id` - AWS access key ID
* `aws_secret_access_key` - AWS secret access key
* `gcp_credentials_json` - Credentials file for GCP
* `private_key_content` - An SSH private key to install on the managed instances so that Ansible can connect
* `public_key_content` - An SSH public key for the corresponding private key

## Usage

First, upload the EaaS secrets file in [secrets/eaas_params_{dev/qa/prod}.json](./secrets/eaas_params_dev.json).

Then, upload the three necessary blueprints: `aws-nginx.yaml`, `gcp-nginx.yaml`, and `eaas.yaml`.

There is a helper script that you can run to handle this:

```
❯ ./upload_blueprints.sh
Secret `eaas_params` created
...
Uploading blueprint aws_blueprint.zip...
 aws_blueprint.zip |###################################################| 100.0%
Blueprint `aws-nginx` upload started.
2022-01-13 21:40:48.593  CFY <None> Starting 'upload_blueprint' workflow execution
2022-01-13 21:40:48.680  LOG <None> INFO: Blueprint archive uploaded. Extracting...
2022-01-13 21:40:48.787  LOG <None> INFO: Blueprint archive extracted. Parsing...
2022-01-13 21:40:52.645  LOG <None> INFO: Blueprint parsed. Updating DB with blueprint plan.
2022-01-13 21:40:52.870  CFY <None> 'upload_blueprint' workflow execution succeeded
Blueprint uploaded. The blueprint's id is aws-nginx
...
Uploading blueprint gcp_blueprint.zip...
 gcp_blueprint.zip |###################################################| 100.0%
Blueprint `gcp-nginx` upload started.
2022-01-13 21:40:58.590  CFY <None> Starting 'upload_blueprint' workflow execution
2022-01-13 21:40:58.681  LOG <None> INFO: Blueprint archive uploaded. Extracting...
2022-01-13 21:40:58.777  LOG <None> INFO: Blueprint archive extracted. Parsing...
2022-01-13 21:41:04.008  LOG <None> INFO: Blueprint parsed. Updating DB with blueprint plan.
2022-01-13 21:41:04.183  CFY <None> 'upload_blueprint' workflow execution succeeded
Blueprint uploaded. The blueprint's id is gcp-nginx
~/src ~/src/wwt-poc
...
Uploading blueprint eaas_nginx_blueprint.zip...
 eaas_nginx_bluepr... |################################################| 100.0%
Blueprint `nginx-eaas` upload started.
2022-01-13 21:41:08.506  CFY <None> Starting 'upload_blueprint' workflow execution
2022-01-13 21:41:08.606  LOG <None> INFO: Blueprint archive uploaded. Extracting...
2022-01-13 21:41:08.726  LOG <None> INFO: Blueprint archive extracted. Parsing...
2022-01-13 21:41:12.210  LOG <None> INFO: Blueprint parsed. Updating DB with blueprint plan.
2022-01-13 21:41:12.410  CFY <None> 'upload_blueprint' workflow execution succeeded
Blueprint uploaded. The blueprint's id is nginx-eaas
~/src/wwt-poc
```

You can now deploy the main `nginx-eaas` blueprint.