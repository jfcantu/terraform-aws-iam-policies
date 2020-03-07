# AWS IAM Policies Terraform Module

Very simple module to create multiple AWS IAM policies from a single module invocation.

This was originally authored for use with Terragrunt, so that you can create multiple IAM policies without having to call a single module repeatedly from different `terragrunt.hcl` files.
