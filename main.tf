#####  CREATE A VPC #####

resource "aws_vpc" "proj-vpc" {
  cidr_block = var.vpc_cidr_value
  tags = {
    Name        = "proj-vpc"
    Environment = var.environment
  }
}

#### CRETATE INTERNET GATEWAY ####

resource "aws_internet_gateway" "proj-igw" {
  vpc_id = aws_vpc.proj-vpc.id
  tags = {
    Name       = "proj-igw"
    Environment = var.environment
  }
}

##### AWS SUBNET CREATION #####

resource "aws_subnet" "proj-public-subnet-1" {
  vpc_id                  = aws_vpc.proj-vpc.id
  cidr_block              = var.public_subnet_cidr_value
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[0]

  tags = {
    Name       = "proj-public-subne-1"
    Environment = var.environment
  }
}

resource "aws_subnet" "proj-public-subnet-2" {
  vpc_id                  = aws_vpc.proj-vpc.id
  cidr_block              = var.public_subnet_cidr_value_1
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[1]

  tags = {
    Name       = "proj-public-subnet-2"
    Environment = var.environment
  }
}

##### PRIVATE SUBNET CREATION #####

resource "aws_subnet" "proj-private-sunbnet-1" {
  vpc_id                  = aws_vpc.proj-vpc.id
  cidr_block              = var.private_subnet_cidr_value
  map_public_ip_on_launch = false
  availability_zone       = data.aws_availability_zones.available.names[0]

  tags = {
    Name       = "proj-private-subnet-1"
    Environment = var.environment
  }
}

resource "aws_subnet" "proj-private-sunbnet-2" {
  vpc_id                  = aws_vpc.proj-vpc.id
  cidr_block              = var.private_subnet_cidr_value_1
  map_public_ip_on_launch = false
  availability_zone       = data.aws_availability_zones.available.names[1]

  tags = {
    Name       = "proj-private-subnet-2"
    Environment = var.environment
  }
}


##### ROUTE TABLE CREATOIN ####

resource "aws_route_table" "proj-public-route-table-1" {
  vpc_id = aws_vpc.proj-vpc.id

  tags = {
    Name       = "proj-public-route-table-1"
    Environment = var.environment
  }
}

resource "aws_route_table" "proj-public-route-table-2" {
  vpc_id = aws_vpc.proj-vpc.id

  tags = {
    Name       = "proj-public-route-table-2"
    Environment = var.environment
  }
}


####   PRIVATE ROUTE TABLE ####

resource "aws_route_table" "proj-private-route-table-1" {
  vpc_id = aws_vpc.proj-vpc.id

  tags = {
    Name       = "proj-private-route-table-1"
    Environment = var.environment
  }
}

resource "aws_route_table" "proj-private-route-table-2" {
  vpc_id = aws_vpc.proj-vpc.id

  tags = {
    Name       = "proj-private-route-table-2"
    Environment = var.environment
  }
}

##### SUBNET ROUTE TABLE ASSOCIATION #####
resource "aws_route_table_association" "proj-public-route-table-association-1" {
  subnet_id      = aws_subnet.proj-public-subnet-1.id
  route_table_id = aws_route_table.proj-public-route-table-1.id
}

resource "aws_route_table_association" "proj-public-route-table-association-2" {
  subnet_id      = aws_subnet.proj-public-subnet-2.id
  route_table_id = aws_route_table.proj-public-route-table-2.id
}

resource "aws_route_table_association" "proj-private-route-table-association-1" {
  subnet_id      = aws_subnet.proj-private-sunbnet-1.id
  route_table_id = aws_route_table.proj-private-route-table-1.id
}

resource "aws_route_table_association" "proj-private-route-table-association-2" {
  subnet_id      = aws_subnet.proj-private-sunbnet-2.id
  route_table_id = aws_route_table.proj-private-route-table-2.id
}

##### ASSIGN ROTE AND INTERNET GATEWAY TO PUBLIC ROUTE TABLE #####

resource "aws_route" "public-route-1" {
  route_table_id         = aws_route_table.proj-public-route-table-1.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.proj-igw.id
}

resource "aws_route" "public-route-2" {
  route_table_id         = aws_route_table.proj-public-route-table-2.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.proj-igw.id
}

##### AWS SECURITY GROUP #####
resource "aws_security_group" "proj-security-group" {
  name        = "proj-security-group"
  description = "proj-security-group"
  vpc_id      = aws_vpc.proj-vpc.id

  tags = {
    Name       = "proj-security-group"
    Environment = var.environment
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_security_group" "proj-security-group-nexus" {
  name        = "proj-security-group-nexus"
  description = "proj-security-group"
  vpc_id      = aws_vpc.proj-vpc.id

  tags = {
    Name       = "proj-security-group-nexus"
    Environment = var.environment
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8081
    to_port     = 8081
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_security_group" "proj-security-group-sonar" {
  name        = "proj-security-group-sonar"
  description = "proj-security-group"
  vpc_id      = aws_vpc.proj-vpc.id

  tags = {
    Name       = "proj-security-group-sonar"
    Environment = var.environment
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}