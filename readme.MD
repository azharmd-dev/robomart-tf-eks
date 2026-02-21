# Robomart Infrastructure (Terraform + Jenkins)

This repository provisions the complete AWS infrastructure required to run the Robomart microservices application on Amazon EKS.

Infrastructure is created using Terraform and automated through Jenkins pipelines.

---

## Architecture Diagram

![Three Tier Architecture – VPC, Public, Private, Database Subnets](../assets/three-tier-architecture.png)

## 🏗️ Infrastructure Components

The following AWS resources are provisioned:

### Networking
- VPC with public and private subnets
- Internet Gateway & NAT Gateway
- Route tables

### Security
- Security Groups and rules
- Bastion host for private access

### Container Registry
- AWS ECR repositories for microservices

### Kubernetes Platform
- Amazon EKS Cluster
- Worker node groups
- IAM roles and policies

### Load Balancing & DNS
- AWS ACM SSL certificate
- Application Load Balancer (ALB Ingress)
- Route53 DNS configuration

---

## 📂 Repository Structure

| Folder | Purpose |
|---|---|
| `00-vpc` | VPC, subnets, NAT, networking |
| `10-sg` | Security groups |
| `20-bastion` | Bastion host for SSH access |
| `30-sg-rules` | Security group rules |
| `40-ecr` | ECR repositories |
| `70-acm` | SSL certificates |
| `80-ingress-alb` | ALB ingress controller |
| `90-eks` | EKS cluster & node groups |

---

## ⚙️ Provisioning Method

Infrastructure is deployed using Jenkins pipeline.

### Apply Infrastructure

```bash
./infra.sh apply
```
## Destroy Infrastructure

```bash 
./infra.sh destroy
```