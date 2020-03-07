data "aws_iam_policy_document" "policies" {
    count = length(var.iam_policies)

    dynamic "statement" {
        for_each = var.iam_policies[count.index].statements
        content {
            sid = statement.value["sid"]
            effect = statement.value["effect"]
            actions = statement.value["actions"]
            not_actions = statement.value["not_actions"]
            resources = statement.value["resources"]
            not_resources = statement.value["not_resources"]
            dynamic "principals" {
                for_each = statement.value["principals"]
                content {
                    type = principals.value["type"]
                    identifiers = principals.value["identifiers"]
                }
            }
            dynamic "condition" {
                for_each = statement.value["condition"]
                content {
                    test = condition.value["test"]
                    variable = condition.value["variable"]
                    values = condition.value["values"]
                }
            }
        }
    }
}

resource "aws_iam_policy" "policies" {
    count = length(var.iam_policies)

    name = var.iam_policies[count.index].name
    name_prefix = var.iam_policies[count.index].name_prefix
    path = var.iam_policies[count.index].path
    description = var.iam_policies[count.index].description
    policy = data.aws_iam_policy_document.policies[count.index].json
}