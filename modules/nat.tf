resource "aws_eip" "nat_1" {
  vpc   = true

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_nat_gateway" "nat_gateway_1" {
  allocation_id = aws_eip.nat_1.id

  # Private subnet이 아니라 public subnet을 연결하셔야 합니다.
  subnet_id = "subnet-0d5b6d39febefabae"

  tags = {
    Name = "spoon-NAT-GW-1"
  }
}