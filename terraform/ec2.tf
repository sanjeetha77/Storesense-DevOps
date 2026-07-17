data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}
resource "aws_instance" "app_server" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type

  user_data = <<-EOF
#!/bin/bash
dnf update -y
dnf install docker -y
systemctl start docker
systemctl enable docker
dnf install git -y
usermod -aG docker ec2-user
mkdir -p /usr/local/lib/docker/cli-plugins
curl -SL \
https://github.com/docker/compose/releases/download/v2.39.1/docker-compose-linux-x86_64 \
-o /usr/local/lib/docker/cli-plugins/docker-compose
chmod +x /usr/local/lib/docker/cli-plugins/docker-compose
cd /home/ec2-user
git clone https://github.com/sanjeetha77/Storesense-DevOps.git
chown -R ec2-user:ec2-user /home/ec2-user/Storesense-DevOps
cd /home/ec2-user/Storesense-DevOps
docker compose pull
docker compose up -d
EOF
  subnet_id = aws_subnet.public_subnet.id
  key_name  = var.key_name
  vpc_security_group_ids = [
    aws_security_group.app.id
  ]
  associate_public_ip_address = true
  tags = {
    Name = "${var.project_name}-EC2"
  }
}