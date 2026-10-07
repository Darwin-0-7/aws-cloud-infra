resource "aws_vpc" "main_vpc" {
    cidr_block               = "10.0.0.0/16"
    enable_dns_support       = true
    enable_dns_hostnames     = true

    tags = {
        Name = "darwin-enterprise-vpc"
    }
}
#Internet Gateway
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.main_vpc.id

    tags = {
      Name = "darwin-igw"
    }
}

#Public Subnet
resource "aws_subnet" "public_subnet_1" {
    vpc_id                  = aws_vpc.main_vpc.id
    cidr_block              = "10.0.1.0/24"
    availability_zone       = "ap-south-1b"
    map_public_ip_on_launch = true

    tags = {
      Name = "darwin-public-subnet-1"
    }
}

#Private Subnet
resource "aws_subnet" "private_subnet_1" {
    vpc_id                  = aws_vpc.main_vpc.id
    cidr_block              = "10.0.2.0/24"
    availability_zone       = "ap-south-1b"
    map_public_ip_on_launch = true

    tags = {
      Name = "darwin-private-subnet-1"
    } 
}

#Public Route Table
resource "aws_route_table" "public_rt" {
    vpc_id = aws_vpc.main_vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }

    tags = {
        Name = "darwin-public-rt"
    }
}

#Public Subnet Association
resource "aws_route_table_association" "public_assoc" {
    subnet_id      = aws_subnet.public_subnet_1.id
    route_table_id = aws_route_table.public_rt.id  
} 

#Second Public Subnet 
resource "aws_subnet" "public_subnet_2" {
    vpc_id                  = aws_vpc.main_vpc.id
    cidr_block              = "10.0.3.0/24"
    availability_zone       = "ap-south-1c"
    map_public_ip_on_launch = true

    tags = {
      Name = "darwin-public-subnet-2"
    }
}

#Association in Route Table
resource "aws_route_table_association" "public_assoc_2" {
    subnet_id      = aws_subnet.public_subnet_2.id
    route_table_id = aws_route_table.public_rt.id
}
