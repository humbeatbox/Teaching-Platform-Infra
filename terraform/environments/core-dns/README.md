# Core DNS Infrastructure

## 📖 Overview
This project (`core-dns`) manages the persistent DNS infrastructure for the application. It decouples the lifecycle of the **Route53 Hosted Zone** and **Cloudflare Nameservers** from the ephemeral application environments (like `sandbox`).

### Why separate this?
1.  **Stability**: Prevents the Route53 Hosted Zone from being deleted when you destroy the sandbox environment.
2.  **Efficiency**: Eliminates the need to update Cloudflare Nameservers (and wait for propagation) every time you redeploy the infrastructure.
3.  **Safety**: Reduces the "Blast Radius". Destroying the sandbox will never accidentally wipe out your DNS configuration.

## 🏗 Architecture
*   **Resource**: `aws_route53_zone` (Hosted Zone for `mern.garychang1214.com`)
*   **Resource**: `cloudflare_record` (NS records pointing to AWS Name Servers)
*   **Outputs**: Exports `zone_id` and `nameservers` for other projects to consume.

## 💰 Cost Implications (AWS)
*   **Fixed Cost**: **$0.50 USD / month** per Hosted Zone.
    *   This is charged as long as this project exists (i.e., the Zone exists), even if the sandbox is destroyed.
*   **Variable Cost**: DNS Queries are essentially free when using Alias records pointing to AWS resources (like CloudFront).

## 🚀 Usage Guide

### 1. Prerequisites
You need a `terraform.tfvars` file with your Cloudflare credentials.
```hcl
# terraform.tfvars
cloudflare_api_token = "your-token"
cloudflare_zone_id   = "your-zone-id"
```

### 2. Deployment
This layer should be deployed **once** and left running.

```bash
# Initialize Terraform
terraform init

# Apply Configuration
terraform apply
```

### 3. Destruction (Danger Zone ⚠️)
> [!CAUTION]
> **CRITICAL WARNING**: NEVER destroy this environment without explicit confirmation from the Project Owner (Gary).
>
> Destroying this will:
> 1.  **Delete the Hosted Zone**: This breaks ALL DNS resolution for `mern.garychang1214.com`.
> 2.  **Break Cloudflare**: You will have to manually login to Cloudflare and update Nameservers again if you recreate it.
> 3.  **Incur Downtime**: Propagation can take up to 24-48 hours.
>
> **Do not run `terraform destroy` here unless you are absolutely sure you want to decommission the domain.**

```bash
# ONLY run if explicitly authorized
terraform destroy
```

## 🔗 Integration with Sandbox
The `sandbox` environment automatically finds this zone using a Data Source:

```hcl
data "aws_route53_zone" "primary" {
  name = var.domain_name
}
```
It does **not** create a new zone; it simply reads the ID of the one created here.
