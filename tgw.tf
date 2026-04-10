resource "aws_ec2_transit_gateway" "tgw" {
  default_route_table_association = "enable"
  default_route_table_propagation = "enable"

  tags = {
    Name = "My-TGW"
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "vpc1_attach"{
    subnet_ids = [ aws_subnet.public_subnet_1.id ]
    transit_gateway_id = aws_ec2_transit_gateway.tgw.id
    vpc_id = aws_vpc.My_VPC_1.id
    tags = {
      Name = "VPC1-ATTACHMENT"
    }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "vpc2_attach"{
    subnet_ids = [ aws_subnet.public_subnet_2.id ]
    transit_gateway_id = aws_ec2_transit_gateway.tgw.id
    vpc_id = aws_vpc.My_VPC_2.id
    tags = {
      Name = "VPC2-ATTACHMENT"
    }
}