#vpc-1
resource "aws_vpc" "My_VPC_1" {
  cidr_block = "10.1.0.0/16"
  tags = {
    Name = "My-VPC-1"
  }
}

#subnets for vpc-1
resource "aws_subnet" "public_subnet_1" {
  vpc_id = aws_vpc.My_VPC_1.id
  cidr_block = "10.1.1.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "Public-Subnet-1"
  }
}

#igw for vpc-1
resource "aws_internet_gateway" "igw1" {
  vpc_id = aws_vpc.My_VPC_1.id
}

#rt for vpc-1
resource "aws_route_table" "rt1" {
  vpc_id = aws_vpc.My_VPC_1.id
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw1.id
    
  }

  route {
    cidr_block = "10.2.0.0/16"
    transit_gateway_id = aws_ec2_transit_gateway.tgw.id
  }

  tags = {
    Name = "RT-1"
  }
}

#associate route to rt1
resource "aws_route_table_association" "rtassoc1" {
  route_table_id = aws_route_table.rt1.id
  subnet_id = aws_subnet.public_subnet_1.id
}

#vpc-2
resource "aws_vpc" "My_VPC_2" {
  cidr_block = "10.2.0.0/16"
  tags = {
    Name = "My-VPC-2"
  }
}

#subnets for vpc-2
resource "aws_subnet" "public_subnet_2" {
  vpc_id = aws_vpc.My_VPC_2.id
  cidr_block = "10.2.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "Public-Subnet-2"
  }
}

#igw for vpc-2
resource "aws_internet_gateway" "igw2" {
  vpc_id = aws_vpc.My_VPC_2.id
}

#rt for vpc-2
resource "aws_route_table" "rt2" {
  vpc_id = aws_vpc.My_VPC_2.id
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw2.id
   
  }

  route {
    cidr_block = "10.1.0.0/16"
    transit_gateway_id = aws_ec2_transit_gateway.tgw.id
  }

  tags = {
    Name = "RT-2"
  }

}

#associate route to rt2
resource "aws_route_table_association" "rtassoc2" {
  route_table_id = aws_route_table.rt2.id
  subnet_id = aws_subnet.public_subnet_2.id
}
