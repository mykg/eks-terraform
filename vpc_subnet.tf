resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
      Name = "main-vpc"
  }
}


resource "aws_subnet" "example1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.4.0/24"
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
  cidr_block = "10.0.5.0/24"
  availability_zone = "ap-south-1b"
  depends_on = [
    aws_vpc.main
  ]

  tags = {
    Name = "Main2"
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "example3" {
  count = 2

  availability_zone = data.aws_availability_zones.available.names[count.index]
  cidr_block        = cidrsubnet(aws_vpc.main.cidr_block, 8, count.index)
  vpc_id            = aws_vpc.main.id
  depends_on = [
    aws_vpc.main
  ]

  tags = {
    "kubernetes.io/cluster/${aws_eks_cluster.example.name}" = "shared"
  }
}