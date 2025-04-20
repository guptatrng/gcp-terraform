##To get gcp default credentials
gcloud auth application-default login --impersonate-service-account=<service account name>

##Terraform init
terraform init --backend-config=./nginx-dev/dev.backend --upgrade

##Terraform plan
terraform plan --var-file=./nginx-dev/dev.tfvars

##Terraform apply
terraform apply --var-file=./nginx-dev/dev.tfvars
