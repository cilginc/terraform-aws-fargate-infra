# Deployment Guide

## Local Deployment (Manual)

To deploy locally, simply run the provided shell script:

```bash
bash deploy-manual.sh
```

> **Note:** If you are not using an S3 backend for Terraform state, you may need to comment out or remove the `backend "s3"` block in `infra/production/provider.tf`.

---

## GitHub Actions Deployment (Production-Like)

The GitHub Actions workflow automates deployment when a new tag is pushed. Follow these steps:

### 1. Set Required Environment Variables

Add the following secrets in your GitHub repository with **read/write access** for GitHub Actions:

- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`

If using an S3 backend for Terraform state (recommended), also add:

- `BUCKET_NAME`
- `DYNAMODB_TABLE`

You can follow this guide to set up the S3 backend: [Terraform S3 Backend Guide](https://cilginc.github.io/posts/HowToMake-TerraformS3Backend/)

---

### 2. Configure Application Ports

- Update the ports in `variables.tf` according to your application needs.
- Update the container port variable in the GitHub Actions workflow if necessary.

---

### 3. Deployment Process

1. Push a new tag to the repository.
2. GitHub Actions will automatically:
   - Build a Docker container
   - Push it to GitHub Container Registry (GHCR)
   - Apply Terraform to deploy the application

> **Note:** This configuration does not include SSL or a custom domain. You can modify the ALB and security group rules to enable these features.
