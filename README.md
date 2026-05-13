# TP Terraform & AWS

## Description

Objectif :
- déployer une infrastructure AWS avec Terraform ;
- tester l'infrastructure localement avec LocalStack ;
- automatiser le provisioning réseau et EC2 ;
- utiliser Git et une organisation par phases.

## Membres

- Oscar DEBEURET
- Geoffrey IBOS

---

# Prérequis

## Logiciels

- Terraform >= 1.6
- AWS CLI v2
- Docker
- LocalStack
- tflocal (terraform-local)
- OpenSSH

## Comptes

- Compte AWS
- Compte GitHub

---

# Structure du projet

```txt
tp-terraform-aws/
├── main.tf
├── provider.tf
├── versions.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars
├── .gitignore
└── README.md
```

## Description des fichiers

| Fichier | Rôle |
|---|---|
| versions.tf | Version Terraform et providers |
| provider.tf | Configuration du provider AWS |
| variables.tf | Variables Terraform |
| terraform.tfvars | Valeurs personnalisées |
| main.tf | Ressources AWS |
| outputs.tf | Outputs Terraform |
| .gitignore | Fichiers ignorés par Git |

---

# Déploiement LocalStack

## Démarrage

```bash
localstack start -d
```

## Vérification

```bash
localstack status services
curl http://localhost:4566/_localstack/health
```

## Variables AWS fake

```bash
export AWS_ACCESS_KEY_ID=test
export AWS_SECRET_ACCESS_KEY=test
export AWS_DEFAULT_REGION=us-east-1
```

## Utilisation de tflocal

```bash
tflocal init
tflocal plan
tflocal apply
```

---

# Déploiement AWS réel

## Configuration AWS CLI

```bash
aws configure
```

## Vérification

```bash
aws sts get-caller-identity
```

## Déploiement Terraform

```bash
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
```

---

# Infrastructure créée

## Réseau

- VPC
- Internet Gateway
- Subnet public
- Route Table
- Route Table Association

## Sécurité

- Security Group HTTP / HTTPS / SSH
- Restriction SSH via `my_ip`

## Compute

- Instance EC2 Ubuntu 24.04
- Clé SSH importée dans AWS

## Stockage

- Bucket S3
- Versioning activé
- Chiffrement AES256

---

# Connexion SSH

## Récupération IP

```bash
terraform output instance_public_ip
```

## Connexion

```bash
ssh -i ~/.ssh/tp_terraform ubuntu@<IP_PUBLIQUE>
```

## Vérifications sur l'instance

```bash
uname -a
curl ifconfig.me
df -h
```

---

# Terraform apply réussi

<img width="1572" height="952" alt="image" src="https://github.com/user-attachments/assets/0cf105a5-f01b-47e2-9f65-eacc7cbc8c64" />

---

# Capture connexion SSH

<img width="1280" height="923" alt="image" src="https://github.com/user-attachments/assets/1048e745-438f-4c0e-b25a-41141e7c1dd3" />
<img width="1455" height="302" alt="image" src="https://github.com/user-attachments/assets/9d16c7cb-281d-4a83-bc05-4086856fa72a" />

---

# Destruction de l'infrastructure

```bash
terraform destroy
```

Validation :

```bash
terraform state list
```

Aucune ressource ne doit rester active afin d'éviter toute consommation de crédits AWS.
