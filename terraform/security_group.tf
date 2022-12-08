resource "aws_security_group" "emby_terraform_sg" {
  vpc_id      = aws_vpc.emby-project.id
  name        = "emby-stack-sg"
  description = "Group for emby server"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH Anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.MYANYWHERE]
  }

  ingress {
    description = "Allow emby port"
    from_port   = 8096
    to_port     = 8096
    protocol    = "tcp"
    cidr_blocks = [var.MYANYWHERE]
  }

  ingress {
    description = "Allow portainer port"
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = [var.MYANYWHERE]
  }

  tags = {
    Name = "emby-terraform-sg"
  }
}