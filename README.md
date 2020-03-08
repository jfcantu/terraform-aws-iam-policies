# AWS IAM Policies Terraform Module

Very simple module to create multiple AWS IAM policies from a single module invocation.

This was originally authored for use with Terragrunt, so that you can create multiple IAM policies without having to create multiple `terragrunt.hcl` files to call a single module repeatedly.

## How To Use it

The module takes a single input, `iam_policies`, which is a list of objects representing IAM policies.

### Important note! ###

Even if you don't use an object's attribute, you must still give it a value (`null`, `{}`, or `[]` as appropriate.)

Example:

    iam_policies = [{
        name = "ReadInstanceTags",
        path = null,
        name_prefix = null,
        description = null,
        statements = [{
            sid = "ReadEC2Tags"
            actions = [
                "ec2:DescribeInstances"
            ],
            effect = "Allow",
            resources = ["*"],
            not_actions = [],
            not_resources = [],
            principals = [],
            condition = []
        }],
    }]

**Explanation**

This module uses `dynamic {}` blocks combined with `for_each` to iterate over lists of objects. Terraform expects all object attributes referenced in the `dynamic {}` block to exist in the object, effectively making all of them mandatory.

### IAM Policy Object

The policy object's attributes mostly mirror the attributes for the `aws_iam_policy` resource, with the exception of the `policy` attribute (see below):

Policy object definition:

    object({
        name = string,
        path = string,
        name_prefix = string,
        description = string,
        statements = list(object({
            [... see next section]
        }))
    })

## IAM Statement Object

Within each policy object, the `policy` attribute that would normally appear in an `aws_iam_policy`, is replaced with a `statement` attribute. The `statement` attribute contains a list of objects representing policy statements, which are identical to `statement {}` blocks in an `aws_iam_policy_document` data source.

Statement object definition:

    object({
            sid = string,
            effect = string,
            actions = list(string),
            not_actions = list(string),
            resources = list(string),
            not_resources = list(string),
            principals = list(object({
                type = string,
                identifiers = list(string)
            })),
            condition = list(object({
                test = string,
                variable = string,
                values = list(string)
            }))
        })