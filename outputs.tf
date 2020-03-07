output "policy_ids" {
    value = aws_iam_policy.policies.*.arn
}

output "policy_arns" {
    value = aws_iam_policy.policies.*.arn
}