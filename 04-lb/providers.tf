provider "kubernetes" {
  config_path = "~/.kube/config" 
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

resource "kubernetes_service_account_v1" "service-account" {
  metadata {
    name = "aws-load-balancer-controller"
    namespace = "kube-system"

    annotations = {
      "eks.amazonaws.com/role-arn" = data.terraform_remote_state.eks.outputs.lb_arn
    }
    
  }
}