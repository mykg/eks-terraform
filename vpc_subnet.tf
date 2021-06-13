resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
      Name = "main-vpc"
  }
}


resource "aws_subnet" "example1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-south-1a"
  depends_on = [
    aws_vpc.main
  ]

  tags = {
    Name = "Main1"
  }
}

resource "aws_subnet" "example2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "ap-south-1b"
  depends_on = [
    aws_vpc.main
  ]

  tags = {
    Name = "Main2"
  }
}