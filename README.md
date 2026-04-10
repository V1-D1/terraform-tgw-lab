# terraform-tgw-lab

# Terraform AWS Transit Gateway Lab

## Architecture
- 2 VPCs
- 1 Transit Gateway
- EC2 instances in each VPC

## Features
- Cross VPC communication using TGW
- Public subnets with IGW
- Security groups for SSH + ICMP

## Testing
- Verified bidirectional ping between VPCs

## Tech Used
- Terraform
- AWS EC2, VPC, TGW
