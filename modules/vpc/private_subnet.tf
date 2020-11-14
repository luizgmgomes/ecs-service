resource "aws_subnet" "private_subnet" {
  for_each  = { for subnet in var.private_subnet : subnet.cidr_block => subnet }

  vpc_id     = aws_vpc.vpc.id
  availability_zone = each.value.availability_zone
  cidr_block = each.value.cidr_block

  tags = merge(
    var.vpc_tags
  )
}


resource "aws_eip" "eip" {
  vpc      = true
}


resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public_subnet[var.public_subnet[0].cidr_block].id
}


resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.vpc.id

  tags = merge(
    var.vpc_tags
  )
  route {
      cidr_block     = "0.0.0.0/0"
      nat_gateway_id = aws_nat_gateway.nat_gw.id
  }
}


resource "aws_route_table_association" "private_route_table_association" {
  for_each  = { for subnet in var.private_subnet : subnet.cidr_block => subnet }
  
  subnet_id      = aws_subnet.private_subnet[each.value.cidr_block].id
  route_table_id = aws_route_table.private_route_table.id
}