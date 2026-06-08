# platform-infra

Infrastructure as Code (IaC) for all platform services, managed with Terraform.

## Overview

This repository centralizes infrastructure definitions for all backend services, frontend applications, and data pipelines. It targets **AWS** (via LocalStack for local development) and **Vercel/Render** for frontend and app hosting.

## Stack

- **Terraform** — infrastructure provisioning
- **LocalStack** — local AWS emulation for development
- **AWS** — cloud infrastructure (EC2, RDS, S3, and more)
- **Vercel** — React app deployments
- **Render** — Node.js server deployments

## Repository Structure

```
platform-infra/
├── modules/                  # Reusable infrastructure modules
│   ├── networking/           # VPC, subnets, security groups
│   ├── ec2/                  # EC2 instance definitions
│   ├── rds/                  # PostgreSQL RDS instances
│   ├── s3/                   # S3 buckets
│   ├── vercel/               # Vercel project definitions
│   └── render/               # Render service definitions
├── environments/
│   └── dev/                  # Development environment entrypoint
│       ├── main.tf
│       ├── variables.tf
│       ├── outputs.tf
│       ├── providers.tf
│       └── terraform.tfvars  # gitignored — never commit this
└── README.md
```

## Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/install)
- [LocalStack](https://docs.localstack.cloud/getting-started/installation/)
- [tflocal](https://github.com/localstack/terraform-local) — `pip install terraform-local`
- [awslocal](https://github.com/localstack/awscli-local) — `pip install awscli-local`
- Docker (required by LocalStack)

## Getting Started

### 1. Start LocalStack

```bash
export LOCALSTACK_AUTH_TOKEN=your_token_here
localstack start
```

### 2. Configure variables

Copy and fill in your variables:

```bash
cp environments/dev/terraform.tfvars.example environments/dev/terraform.tfvars
```

### 3. Initialize and apply

```bash
cd environments/dev
tflocal init
tflocal plan
tflocal apply
```


## Notes

- `terraform.tfvars` is gitignored — never commit secrets
- Always run `tflocal plan` before `tflocal apply`
- LocalStack runs on `http://localhost:4566`
- For real AWS deployment, use `terraform` instead of `tflocal`