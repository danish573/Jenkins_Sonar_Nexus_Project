resource "aws_instance" "nexus-server" {
    ami = data.aws_ami.latest.id
    instance_type = "t2.medium"
    subnet_id = aws_subnet.proj-public-subnet-1.id
    user_data = file("./nexus-server.sh")
    key_name = "Mumbai"
    security_groups = [aws_security_group.proj-security-group-nexus.id]
    root_block_device {
      volume_size = 20
    }
    tags = {
      Name = "nexus-server"
      Environment=var.environment
    }
}