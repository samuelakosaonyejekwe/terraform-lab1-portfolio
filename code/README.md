# cba_terraform

**Lab 1 – Spinning up an Apache Web Server on AWS using Terraform** (Platform Engineering / AWS Cloud DevOps)

Author: Samuel Akosa Onyejekwe ([@samuelakosaonyejekwe](https://github.com/samuelakosaonyejekwe))

## What this provisions
| Resource | Terraform address | Details |
|---|---|---|
| Security group | `aws_security_group.cba_tf_sg` | `cba_tf_sg` – inbound SSH (22) & HTTP (80) from 0.0.0.0/0, all outbound |
| EC2 instance | `aws_instance.cba_tf_instance` | `CBATerraformInstance` – Amazon Linux 2, `t3.micro`, key pair `cba-akosa-keypair`, default VPC |
| User data | `install_apache.sh` | Installs & starts Apache (httpd) and serves *Hello World from &lt;hostname&gt;* |

Region: `eu-west-2` (London)

## Files
- `variables.tf` – region, instance type, AMI, VPC id, key-pair name
- `main.tf` – AWS provider, security group and EC2 instance (with `user_data`)
- `install_apache.sh` – bootstrap script run by cloud-init on first boot

## Usage
```bash
terraform init
terraform plan
terraform apply      # type 'yes'
# open http://<instance-public-ip> in a browser
terraform destroy    # type 'yes' – tear everything down to avoid cost
```

## Notes
- `t3.micro` is used instead of the lab's `t2.micro` because `t2.micro` is no longer Free Tier eligible on this account.
- `user_data_replace_on_change = true` forces the instance to be recreated when the bootstrap script changes – user data only runs on first boot, so an in-place update would never install Apache.
- `.tfstate` files and `.terraform/` are excluded by the Terraform `.gitignore` template.
