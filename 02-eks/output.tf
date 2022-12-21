
output "cluster_id" {
    value = module.eks.cluster_id
}

output "lb_arn" {
    value = module.lb_role.iam_role_arn
}
