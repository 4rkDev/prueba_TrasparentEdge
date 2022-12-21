module "database" {
    source  = "terraform-aws-modules/rds/aws"
    version = "5.2.1"

    identifier = "wordpress-prod-db"

    engine         = "mysql"
    engine_version = "5.7"
    instance_class = "db.t2.small"
    allocated_storage = 5
    
   
    db_name = "wordpress"
    username = var.db_username
    password = var.db_password
    port     = "3306"
    subnet_ids = data.terraform_remote_state.vpc.outputs.private_subnets

    maintenance_window = "Mon:00:00-Mon:03:00"
    backup_window      = "03:00-06:00"
    
    
    family = "mysql5.7"
    major_engine_version = "5.7"
}