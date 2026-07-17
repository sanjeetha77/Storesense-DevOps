output "vpc_id" {
  description = "ID for Storesense VPC"
  value       = aws_vpc.Storesense-vpc.id
}

output "app_public_ip" {
  description = "Public IP address of the EC2 app server"
  value       = aws_instance.app_server.public_ip
}
