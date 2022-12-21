
resource "aws_security_group" "rds-internal" {
  name_prefix = "rds"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id

  ingress {
    from_port = 3306
    to_port   = 3306
    protocol  = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_db_subnet_group" "default" {
  name       = "private-subnet-group"
  subnet_ids = data.terraform_remote_state.vpc.outputs.private_subnets

  tags = {
    Name = "My private DB subnet group"
  }
}