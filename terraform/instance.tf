resource "aws_key_pair" "emby-key" {
  key_name   = "emby"
  public_key = file("emby.pub")
}

resource "aws_instance" "emby-terraform" {
  ami                    = var.AMIS[var.REGION]
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.emby-pub-1.id
  key_name               = aws_key_pair.emby-key.key_name
  vpc_security_group_ids = [aws_security_group.emby_terraform_sg.id]

  tags = {
    Name = "emby-terraform"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x /tmp/ec2.sh",
      "sudo sh /tmp/ec2.sh"
    ]
  }

  connection {
    user        = var.USER
    private_key = file(var.PRIV_KEY)
    host        = self.public_ip
  }
}

output "PublicIP" {
  value = aws_instance.emby-terraform.public_ip
}
