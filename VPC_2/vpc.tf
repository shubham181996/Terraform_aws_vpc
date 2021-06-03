resource "aws_vpc" "main" {
    cidr_block = var.vpc_cidr
    tags = {
      Name = "MyVPC"
    }  
}

resource "aws_internet_gateway" "gw" {
    vpc_id = aws_vpc.main.id
    tags = {
      Name = "MyGW"
    }
}

#length: Length give us optput for value how much inside(lits, map). For example here we give count = 2
#and we used function length now our code is dynamic whatever subnets fix in variable they take automatically.
#index:- finds the element index for a given value in a list. 
#element:- function is work like for example we have a list [1,2,3,4] now to want to print 1 postion value than we give ([1,2,3,4] , 0).
#count.index:- count.index have a capabililty for in a loop they count and give me output. 
#map_public_ip_on_launch:- This option put always ture because whenever we launch instance then aws give public ip there this option always ture os on. 
resource "aws_subnet" "subnets" {
    count = length(var.vpc_subnets)
    vpc_id = aws_vpc.main.id
    cidr_block = element(var.vpc_subnets, count.index )
    availability_zone = element(var.awz, count.index )
    map_public_ip_on_launch = true
    tags = {
      Name = "Subnet-${count.index +1}"
    }
  
}

resource "aws_route_table" "route" {
    vpc_id = aws_vpc.main.id

    route {
        cidr_block = "0.0.0.0/24"
        gateway_id = aws_internet_gateway.gw.id
    }
    tags = {
       Name = "MyRTexample"
    }

  
}

resource "aws_route_table_association" "a" {
    count = length(var.vpc_subnets)
  subnet_id      = element(aws_subnet.subnets.*.id, count.index)
  route_table_id = aws_route_table.route.id
  
}