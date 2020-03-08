provider "aws" {
    region = "us-west-2"
}

resource "aws_iam_role" "role" {
    name = "ExampleRole"

    assume_role_policy = data.aws_iam_policy_document.instance_assume_role_policy.json
}

data "aws_iam_policy_document" "instance_assume_role_policy" {
    statement {
        actions = ["sts:AssumeRole"]

        principals {
            type        = "Service"
            identifiers = ["ec2.amazonaws.com"]
        }
    }
}

module "policies" {
    source = "../.."

    iam_policies = [
        {
            name = "ReadS3Bucket",
            path = null,
            description = null,
            name_prefix = null,
            statements = [{
                sid = "ReadS3Bucket"
                actions = [
                    "s3:GetObject",
                    "s3:ListBucket"
                ],
                effect = "Allow",
                resources = [
                    "arn:aws:s3:::MyBucket",
                    "arn:aws:s3:::MyBucket/*"
                ],
                not_actions = [],
                not_resources = [],
                principals = [],
                condition = []
            }]
        },
        {
            name = "ReadInstanceTags",
            path = null,
            name_prefix = null,
            description = null,
            statements = [{
                sid = "ReadEC2Tags",
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
        }
    ]
}

resource "aws_iam_role_policy_attachment" "policy_attachment" {
    count = length(module.policies.policy_arns)
    role = aws_iam_role.role.name
    policy_arn = module.policies.policy_arns[count.index]
}