output "instance_id" {
  value = aws_instance.app.id
}

output "instance_public_ip" {
  value = aws_instance.app.public_ip
}

output "security_group_id" {
  value = aws_security_group.ec2.id
}

output "iam_role_name" {
  value = aws_iam_role.ec2.name
}
