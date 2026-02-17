#!/bin/bash
set -e

ACTION=$1

apply_all () {
  for i in 00-vpc 10-sg 20-bastion 30-sg-rules 40-ecr 70-acm 80-ingress-alb 90-eks
  do
    echo "🚀 Applying $i"
    cd $i
    terraform init -input=false
    terraform apply -auto-approve -input=false
    cd ..
  done
}

destroy_all () {
  for i in 90-eks 80-ingress-alb 70-acm 40-ecr 30-sg-rules 20-bastion 10-sg 00-vpc
  do
    echo "Destroying $i"
    cd $i
    terraform destroy -auto-approve -input=false
    cd ..
  done
}

#IF ELSE starts here
if [ "$ACTION" = "apply" ]; then
  apply_all

elif [ "$ACTION" = "destroy" ]; then
  destroy_all

else
  echo "❌ Usage: ./infra.sh apply | destroy"
  exit 1
fi
