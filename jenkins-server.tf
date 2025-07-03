resource "aws_instance" "jenkins-server" {
  ami                  = data.aws_ami.latest.id
  instance_type        = "t2.medium"
  subnet_id            = aws_subnet.proj-public-subnet-1.id
  user_data            = file("./jenkins-server.sh")
  key_name             = "Mumbai"
  iam_instance_profile = aws_iam_instance_profile.proj-instance-profile.name
  security_groups      = [aws_security_group.proj-security-group.id]
  root_block_device {
    volume_size = 20
  }
  tags = {
    Name       = "jenkins-server"
    Enviroment = var.environment
  }
}