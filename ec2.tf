resource "aws_instance" "shardeum_validator" {

  ami           = lookup(var.AMI, var.AWS_REGION)
  instance_type = "t2.small"

  # VPC
  subnet_id = aws_subnet.shardeum_subnet_public_1.id

  # Security Group
  vpc_security_group_ids = [aws_security_group.shardeum_validator_sg.id]

  # the Public SSH key
  key_name = aws_key_pair.shardeum_key_pair.id

  # root disk
  root_block_device {
    volume_size           = "50"
    volume_type           = "gp3"
    encrypted             = true
    delete_on_termination = true
  }

  # docker and docker-compose installation
  provisioner "file" {
    source      = "docker_install.sh"
    destination = "/tmp/docker_install.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/docker_install.sh",
      "sudo /tmp/docker_install.sh"
    ]
  }

  connection {
    user        = var.EC2_USER
    host        = self.public_ip
    private_key = file(var.PRIVATE_KEY_PATH)
  }

  tags = {
    Name = "shardeum_validator"
  }
}

resource "aws_key_pair" "shardeum_key_pair" {
  key_name   = "shardeum_key_pair"
  public_key = file(var.PUBLIC_KEY_PATH)
}
