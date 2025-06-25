#### Tags Variable ####
variable "environment" {
  description = "Enviroment Tag Variable"
  type        = string
  default     = "dev"
}


#### VPC CIDR VALUE ####
variable "vpc_cidr_value" {
  description = "CIDR Value for Proj-vpc"
  type        = string
  default     = "10.0.0.0/16"
}

#### PUBLIC SUBNET CIDR VALUE ####
variable "public_subnet_cidr_value" {
  description = "CIDR for Public Subnet Creation "
  type        = string
  default     = "10.0.0.0/24"
}

variable "public_subnet_cidr_value_1" {
  description = "CIDR for Public Subnet Creation "
  type        = string
  default     = "10.0.1.0/24"
}

#### PRIVATE SUBNET CIDR VALUE ####

variable "private_subnet_cidr_value" {
  description = "CIDR Value for Private Subnet Creation"
  type        = string
  default     = "10.0.2.0/24"
}

variable "private_subnet_cidr_value_1" {
  description = "CIDR Value for Private Subnet Creation"
  type        = string
  default     = "10.0.3.0/24"
}