variable "region_aws" {
    default = "ap-south-1"
}

variable "vpc_cidr" {
    default = "10.0.0.0/16"
}

variable "vpc_subnets" {
    type = list
    default = [ "10.0.1.0/24" , "10.0.2.0/24" ]
}

variable "awz" {
    default = [ "ap-south-1a" , "ap-south-1b"]  
}