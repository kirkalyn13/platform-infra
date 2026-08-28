output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_id" {
  value = var.create_public_subnet ? aws_subnet.public[0].id : null
}

output "private_subnet_id" {
  value = var.create_private_subnet ? aws_subnet.private[0].id : null
}

output "nat_gateway_id" {
  value = (var.create_public_subnet && var.create_private_subnet) ? aws_nat_gateway.main[0].id : null
}

output "private_route_table_id" {
  value = var.create_private_subnet ? aws_route_table.private[0].id : null
}