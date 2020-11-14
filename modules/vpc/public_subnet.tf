resource "aws_subnet" "public_subnet" {
  for_each  = { for subnet in var.public_subnet : subnet.cidr_block => subnet }

  vpc_id     = aws_vpc.vpc.id
  availability_zone = each.value.availability_zone
  cidr_block = each.value.cidr_block

  tags = merge(
    var.vpc_tags
  )
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = merge(
    var.vpc_tags
  )
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  tags = merge(
    var.vpc_tags
  )
}

resource "aws_route" "public_route" {
  route_table_id            = aws_route_table.public_route_table.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id                = aws_internet_gateway.igw.id
  depends_on                = [aws_route_table.public_route_table]
}


resource "aws_route_table_association" "public_route_table_association" {
  for_each  = { for subnet in var.public_subnet : subnet.cidr_block => subnet }
  
  subnet_id      = aws_subnet.public_subnet[each.value.cidr_block].id
  route_table_id = aws_route_table.public_route_table.id
}
