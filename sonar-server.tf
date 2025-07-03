resource "aws_instance" "sonar-server" {
    ami = data.aws_ami.latest.id
    instance_type = "t2.medium"
    subnet_id = aws_subnet.proj-public-subnet-1.id
    user_data = file("./sonar-server.sh")
    key_name = "Mumbai"
    security_groups = [aws_security_group.proj-security-group-sonar.id]
    root_block_device {
      volume_size = 20
    }
  tags = {
    Name = "sonar-server"
    Environment = var.environment
  }
}