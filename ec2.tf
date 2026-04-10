data "aws_ami" "amz-linux" {
  most_recent = true
  owners = ["amazon"]
  filter {
    name = "name"
    values = [ "al2023-ami-*-x86_64" ]
  }

  filter{
    name = "virtualization-type"
    values = [ "hvm" ]
  }
}

resource "aws_instance" "My-Ec2-1" {
  ami = data.aws_ami.amz-linux.id
  instance_type = "t3.micro"
  subnet_id = aws_subnet.public_subnet_1.id
  key_name = aws_key_pair.lab_key.key_name
  vpc_security_group_ids = [ aws_security_group.sg_vpc1.id ]
  tags = {
    Name = "My-Ec2-1"
  }
}

resource "aws_instance" "My-Ec2-2" {
  ami = data.aws_ami.amz-linux.id
  instance_type = "t3.micro"
  subnet_id = aws_subnet.public_subnet_2.id
  key_name = aws_key_pair.lab_key.key_name
  vpc_security_group_ids = [ aws_security_group.sg_vpc2.id ]
  tags = {
    Name = "My-Ec2-2"
  }
}

resource "aws_key_pair" "lab_key" {
  key_name = "tgw-lab-key"
  public_key = file(pathexpand("~/.ssh/id_ed25519.pub"))
}

resource "aws_security_group" "sg_vpc1" {
  vpc_id = aws_vpc.My_VPC_1.id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  ingress {
    from_port = -1
    to_port = -1
    protocol = "icmp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
}

resource "aws_security_group" "sg_vpc2" {
  vpc_id = aws_vpc.My_VPC_2.id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  ingress {
    from_port = -1
    to_port = -1
    protocol = "icmp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
}