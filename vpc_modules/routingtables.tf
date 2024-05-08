# public routingtable
resource "aws_route_table" "myrt" {
  vpc_id = aws_vpc.myvpc.id

  tags = {
    Name = "public-spoon-rt"
  }
}

resource "aws_route_table_association" "myrtassociation1" {
  subnet_id      = aws_subnet.mysubnet1.id
  route_table_id = aws_route_table.myrt.id
}


resource "aws_route" "mydefaultroute" {
  route_table_id         = aws_route_table.myrt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.myigw.id
}

resource "aws_route_table" "route_table_private_1" {
  vpc_id = aws_vpc.myvpc.id

  tags = {
    Name = "private-spoon-rt"
  }
}
resource "aws_route_table_association" "route_table_association_private_1" {
  subnet_id      = aws_subnet.mysubnet2.id
  route_table_id = aws_route_table.route_table_private_1.id
}

resource "aws_route" "private_nat_1" {
  route_table_id              = aws_route_table.route_table_private_1.id
  destination_cidr_block      = "0.0.0.0/0"
  nat_gateway_id              = aws_nat_gateway.nat_gateway_1.id
}
