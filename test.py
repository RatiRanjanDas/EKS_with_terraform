import os
import time


os.system("terraform init")
time.sleep(20)
os.system("terraform plan")
time.sleep(10)
os.system("terraform apply")
os.system("terraform output kubeconfig > ~/.kube/config")
os.system("aws eks --region ap-south-1 update-kubeconfig --name terraform-eks-demo")
os.system("terraform output config-map-aws-auth > config-map-aws-auth.yaml")
os.system("kubectl apply -f config-map-aws-auth.yaml")
os.system("kubectl create namespace service")
