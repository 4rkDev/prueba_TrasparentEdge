module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.14.3"
  name = "vpc-trasparentEdge"
  cidr = "10.0.0.0/16"

  azs             = ["eu-west-1a", "eu-west-1b" , "eu-west-1c"]
 
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24","10.0.103.0/24"]


  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  tags = {
    Terraform   = "true" 
    Environment = "dev"
    }

  public_subnet_tags = {
    "kubernetes.io/cluster/transparentEdge-eks" = "shared"
    "kubernetes.io/role/elb"                      = 1
  }


  private_subnet_tags = {
    "kubernetes.io/cluster/transparentEdge-eks" = "shared"
    "kubernetes.io/role/internal-elb"             = 1
  }
  
  


}

