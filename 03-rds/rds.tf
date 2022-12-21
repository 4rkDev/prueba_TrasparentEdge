

module "database" {
    source  = "terraform-aws-modules/rds/aws"
    version = "5.2.1"

    identifier = "wordpress-prod-db"

    engine         = "mysql"
    engine_version = "5.7"
    instance_class = "db.t2.small"
    allocated_storage = 5
    
    vpc_security_group_ids = [aws_security_group.rds-internal.id]

    
    db_name = "wordpress"
    username = var.db_username
    password = var.db_password
    port     = "3306"

    

    
    
    
    db_subnet_group_name = "private-subnet-group"
    

    maintenance_window = "Mon:00:00-Mon:03:00"
    backup_window      = "03:00-06:00"

    multi_az = true
    
    
    family = "mysql5.7"
    major_engine_version = "5.7"
}
