variable "aws_region" {
  description = "AWS Region"
  type        = string
}
variable "project_name" {
  description = "Project Name"
  type        = string
}
variable "vpc_cidr" {
  description = "CIDR block"
  type        = string
}
variable "public_subnet_cidr" {
  description = "public subnet for VPC"
  type        = string
}
variable "instance_type" {
  description = "EC2 Instance type"
  type        = string
}
variable "key_name" {
  description = "key pair value"
  type        = string
}