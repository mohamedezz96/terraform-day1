resource "aws_key_pair" "deployer" {
  key_name   = var.key-name
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDJE0JYQR68DB4NSDePm05ry4FtWeS4dfjrb6UO7y//spEkCVtXNY5XAUXliejahsuGfalTEdz5kB0pxkpFF/EjsXnk8GMxcAuVYGqS8GVe73EfTaNqwduIW0eFZjF8oBywyefIdBA7BrjXbJkba0TiAM7Wvw6tdo837ZOVHyAUVMqHPHDUFgKtibvEXHkR6HYOs5ZHM34ODLiNNhqDg74CNDwq0r+UeDD+6cLB0q8Y8EoyXP0cYnoIIW1joO8IlLu0Avc3CttBX7gLZUudcbeSF9eXbOMCdtFibtd3+5YW6E+ddzt4Ke5BHo2KQ3/gm9DdUegLuEV31Gtf60NGF7afzmZVhFdyt8bhlIpCJxAyiqakmwD3MIkNp5m+4eSW8Krzey7zJJgyZLjAUqt8tEekYNspoxvyrXUWueBzOFKgZ8w36a2m9+gKHW0qTHXIglxwIC9Utw8fmwVIvnhLnCrUi3098MU/2NKKgNRc4Z3lQDCKswxxor2/2Pf+sEUJew0= ezz@ezz-virtual-machine"
}



resource "aws_security_group" "project-iac-sg" {
  name = "Sg-1"
  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
}

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }

}



resource "aws_instance" "vm" {
  ami           = "ami-00ee4df451840fa9d"
  instance_type = var.ec2_instance_type
  key_name      = "deployer-key"
  vpc_security_group_ids = [
    aws_security_group.project-iac-sg.id
  ]

  tags = {
    Name = "my-second-tf-instance"
  }
}


output "instance_ip_addr" {
  value       = aws_instance.vm.private_ip
  description = "The private IP address of the main server instance."
}

output "instance_ip_addr_public" {
  value       = aws_instance.vm.public_ip
  description = "The public IP address of the main server instance."
}





