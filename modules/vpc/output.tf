output "vpc_id" {
  value       = aws_vpc.vpc.id
  description = "VPC ID"
}

output "public_sub" {   
  value = [for sub in aws_subnet.public_subnet : sub.id] 
}

output "private_subnets" {
  value = [for v in aws_subnet.private_subnet : v.id]
}