
variable "db_password" {
  description = "Password for the RDS database"
  type        = string
  sensitive   = true
}

variable "db_username" {
  description = "Username for the RDS database"
  type        = string
  sensitive = true
  
}
data "terraform_remote_state" "rds"{
    backend = "local"
    config = {
        path = "../03-rds/terraform.tfstate"
    }
}
