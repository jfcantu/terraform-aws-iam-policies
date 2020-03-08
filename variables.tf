variable "iam_policies" {
    description = "A list of objects whose keys match the arguments for the `aws_iam_policy` resource and the `aws_iam_policy_document` data source."
    type = list(object({
        name = string,
        path = string,
        name_prefix = string,
        description = string,
        statements = list(object({
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
        }))
    }))
    default = null
}