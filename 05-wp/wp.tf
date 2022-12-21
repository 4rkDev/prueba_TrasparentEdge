resource "kubernetes_namespace" "wp" {
    metadata {
        name = "wordpress"
    }
}



resource "kubernetes_service" "wp" {
    metadata {
        name = "wordpress"
        namespace = "wordpress"
    }
    spec {
        selector = {
            app = "wordpress"
        }
        port {
            port = 80
            target_port = 80
        }
        
    }
}




resource "kubernetes_deployment_v1" "wp" {
    metadata {
        name = "wordpress"
        namespace = "wordpress"
        labels = {
            app = "wordpress"
        }
    }
    spec {
        selector {
            match_labels = {
                app = "wordpress"
            }
        }
        template {
            metadata {
                labels = {
                    app = "wordpress"
                }
            }
            spec {
                container {
                    name = "wordpress"
                    image = "wordpress:latest"
                    env {
                        name = "WORDPRESS_DB_HOST"
                        value = data.terraform_remote_state.rds.outputs.db_instance_address
                    }
                    env {
                        name = "WORDPRESS_DB_USER"
                        value = var.db_username
                    }
                    env {
                        name = "WORDPRESS_DB_PASSWORD"
                        value = var.db_password
                    }
                     port {
                    container_port = 80
                }
                   
                }
               
    
            }
        }
    }
    
    
}

resource "kubernetes_ingress_v1" "wp" {
    metadata {
        name = "wordpress"
        namespace = "wordpress"
        annotations = {
       
        "alb.ingress.kubernetes.io/scheme" = "internet-facing"
        "alb.ingress.kubernetes.io/target-type" = "ip"  
    }
    } 
    
    spec {
        ingress_class_name = "alb"

        rule {
            
            http {
                path {
                    path = "/"
                    path_type = "Prefix"
                    backend {
                        service {
                            name = "wordpress"
                            port {
                                number = 80
                            }
                        }
                    }
                }
            }
        }
    }
}