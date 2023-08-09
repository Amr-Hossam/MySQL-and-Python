# MySQL-and-Python

building infrastructure with terraform with all needed configuration with ansible for MYSQL-FLASK-APP production

## AWS Infrastructure using Terraform
### network module
* VPC
* 2 Public Subnets
* Route Table 
* Internet Getway
### EKS module
* eks
* nodes
### ECR module
* flask-app ecr
* mysql-db ecr
### EC2 module
* Security Group
* key Pair
* ec2 

__Build Infrastructure__

Clone [MySQL-and-Python](https://github.com/Amr-Hossam/MySQL-and-Python.git) Repo then run the bash script file that will apply the terraform and ansible code: 
```
bash terraform-ansible.sh 
```

Terraform output is the ip of Jenkins ec2

![image](https://github.com/Amr-Hossam/images/blob/main/jenkins_ip.PNG?raw=true)


* Ansible will configure jenkins, docker and awscli and adding aws credentials
* ansible will print the initial password of jenkins

![image](https://github.com/Amr-Hossam/images/blob/main/jenkins_pass.PNG?raw=tru)

## Jenkins 
__Browse with jenkins ip__

```
http://54.208.8.147:8080/
```
you don't need to install any plugins only the suggested pugins

![image](https://github.com/Amr-Hossam/images/blob/main/plugins.PNG?raw=true)

__Create webhook__

Go to [MySQL-and-Python](https://github.com/Amr-Hossam/MySQL-and-Python.git) repo (i add you as a collaborator)

![image](https://github.com/Amr-Hossam/images/blob/main/webhook-3.PNG?raw=true)

__Add GitHub Token and AWS Credentials in Jenkins Dashboard__

Dashboard > Manage Jenkins > Credentials > System > Global credentials (unrestricted)



__Create the Pipeline__

1. build-pipeline 

![image](https://github.com/Amr-Hossam/images/blob/main/first-pipeline.PNG?raw=true)

Dashboard > build-pipeline > Configuration > Build Triggers

check __GitHub hook trigger for GITScm polling__ option

![image](https://github.com/Amr-Hossam/images/blob/main/build-triggrs.PNG?raw=true)

Dashboard > build-pipeline > Configuration > Pipeline

add the [MySQL-and-Python](https://github.com/Amr-Hossam/MySQL-and-Python.git) and its Credentials and make sure that __Branches to build__ is __main__ 


__Script Path__
```
Jenkinsfile
```


So, with every push event in sprints-final-project repo the build-pipeline will build and give you the link of the ingress controller loadbalancer to access the application with it



![image](https://github.com/Amr-Hossam/images/blob/main//output.PNG?raw=true)


![image](https://github.com/Amr-Hossam/images/blob/main/website.PNG?raw=true)


## Destroying the environment

delete the ECRs first
```
aws ecr delete-repository --repository-name flask-app --force
```
```
aws ecr delete-repository --repository-name mysql-db --force
```
```
terraform destroy --auto-approve
```

