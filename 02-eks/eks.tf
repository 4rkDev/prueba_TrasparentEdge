module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "18.29.0"

  cluster_name    = "transparentEdge-eks"
  cluster_version = "1.23"

  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true

  vpc_id     = data.terraform_remote_state.vpc.outputs.vpc_id
  subnet_ids = data.terraform_remote_state.vpc.outputs.private_subnets

  node_security_group_additional_rules ={
    ingress_allow_access_form_control_plane= {
      type                     = "ingress"
      from_port                = 9443
      to_port                  = 9443
      protocol                 = "tcp"
      source_cluster_security_group = true
      
    }
    egess= {
      type                     = "egress"
      from_port                = 0
      to_port                  = 0
      protocol                 = "-1"
      cidr_blocks              = ["10.0.0.0/16"]

  }
  }


 

  eks_managed_node_groups = {
    default = {
      name = "node-group-1"
      instance_types = ["t3.medium"]
      min_size     = 1
      max_size     = 3
      desired_size = 1
      
    }


  }
}
