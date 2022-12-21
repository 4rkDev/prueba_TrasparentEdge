module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "18.29.0"

  cluster_name    = "transparentEdge-eks"
  cluster_version = "1.24"

  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true

  vpc_id     = data.terraform_remote_state.vpc.outputs.vpc_id
  subnet_ids = data.terraform_remote_state.vpc.outputs.private_subnets

 

  eks_managed_node_groups = {
    default = {
      name = "node-group-1"
      instance_types = ["t3.micro"]
      min_size     = 1
      max_size     = 3
      desired_size = 1
      
    }


  }
}
