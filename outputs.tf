output "policy_ids" {
    description = "List of IDs of created policies."
    value = aws_iam_policy.policies.*.arn
}

output "policy_arns" {
    description = "List of ARNs of created policies."
    value = aws_iam_policy.policies.*.arn
}

output "policy_jsons" {
    description = "List of JSON representations of created policies."
    value = aws_iam_policy.policies.*.policy
}

output "policy_id_map" {
    description = "Map of policy names to IDs."
    value = zipmap(
        aws_iam_policy.policies.*.name,
        aws_iam_policy.policies.*.id
    )
}

output "policy_arn_map" {
    description = "Map of policy names to ARNs."
    value = zipmap(
        aws_iam_policy.policies.*.name,
        aws_iam_policy.policies.*.arn
    )
}

output "policy_json_map" {
    description = "Map of policy names to JSON documents."
    value = zipmap(
        aws_iam_policy.policies.*.name,
        aws_iam_policy.policies.*.policy
    )
}