#!/bin/bash

# Run terraform code
cd terraform
terraform init
terraform apply --auto-approve


# Run ansible code
cd ../ansible
ansible-playbook -i inventory --private-key ../terraform/jenkins_key.pem ./project.yml