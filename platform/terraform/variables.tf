variable "account_id" {
    default = "522796919834"
}

variable "app_name" {
    default = "kimbo-backoffice"
}

variable "vpc" {
    default = {
        id   = "vpc-cb469db2"
        cidr = "172.31.0.0/16"
        subnets = ["subnet-0087604b", "subnet-1f0b1f79", "subnet-b00756ea"]
    }
}

variable "loadbalancer_config" {
    default = {
        access_logs_prefix = "load_balancer/access_logs"
    }
}

variable "dns" {
    default = {
        public = {
            id = "Z0703165UIMAZOXD5I2O"
        }
        private = {
            id = null
        }
    }
}