#Security Group
resource "aws_security_group" "alb_sg" {
    name        = "darwin-alb-sg"
    description = "Allow HTTP to ALB"
    vpc_id      = aws_vpc.main_vpc.id

    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = -1
        cidr_blocks = ["0.0.0.0/0"]
    }
}

#Application Load Balancer
resource "aws_lb" "web_alb" {
    name               = "darwin-web-alb"
    internal           = false
    load_balancer_type = "application"
    security_groups    = [aws_security_group.alb_sg.id]
    # Mapping to both public subnets
    subnets            = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id] 
}

#Target Group
resource "aws_lb_target_group" "web_tg" {
  name     = "darwin-web-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main_vpc.id
}

#Target Group Attachment
resource "aws_lb_target_group_attachment" "web_tg_attach" {
    target_group_arn = aws_lb_target_group.web_tg.arn
    target_id        = aws_instance.web_server.id
    port             = 80
}

#ALB Listener
resource "aws_lb_listener" "web_listener" {
    load_balancer_arn = aws_lb.web_alb.arn
    port              = "80"
    protocol          = "HTTP"

    default_action {
      type             = "forward"
      target_group_arn = aws_lb_target_group.web_tg.arn
    }
}

#Output
output "load_balancer_dns" {
    value = aws_lb.web_alb.dns_name  
}