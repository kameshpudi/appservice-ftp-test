#!/bin/bash

az login --service-principal -u ${client_id} -p ${client_secret} --tenant ${tenant_id}
ftpname=$(az webapp deployment list-publishing-credentials -n ${app_service_name} -g ${app_rg_name} --query name) 
publishingPassword=$(az webapp deployment list-publishing-credentials -n ${app_service_name} -g ${app_rg_name} --query publishingPassword)
ftpPublishingUrl=$(az webapp show -n ${app_service_name} -g ${app_rg_name} --query ftpPublishingUrl)
ftpname=$(eval echo $ftpname)
publishingPassword=$(eval echo $publishingPassword)
ftpPublishingUrl="$(eval echo $ftpPublishingUrl)/"

curl -T data.jar -u $ftpname:$publishingPassword $ftpPublishingUrl