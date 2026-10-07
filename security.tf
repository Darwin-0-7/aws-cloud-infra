#Security Group for Web Server
resource "aws_security_group" "Web_sg" {
    name        = "darwin-web-sg"
    description = "Allow HTTP and SSH inbound traffic"
    vpc_id      = aws_vpc.main_vpc.id

    #SSH 
    ingress {
        description = "SSH Access"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    #HTTP
    ingress {
        description = "HTTP Access"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    #Outbound Traffic
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "darwin-web-sg"
    }
}