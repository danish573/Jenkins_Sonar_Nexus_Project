output "vpc-id" {
  value = aws_vpc.proj-vpc.id
}

output "instance-id" {
  value = aws_instance.jenkins-server.id
}

# output "instance-id" {
#   value = aws_instance.nexus-server.id
# }

# output "instance-id" {
#   value = aws_instance.sonar-server.id
# }

output "jenkins-ip" {
  value = aws_instance.jenkins-server.public_ip
}

output "nexus-ip" {
  value = aws_instance.nexus-server.public_ip
}

output "sonar-ip" {
  value = aws_instance.sonar-server.public_ip
}