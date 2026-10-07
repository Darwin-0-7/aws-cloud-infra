data "aws_ami" "ubuntu" {
    most_recent = true
    owners = ["099720109477"] #Canonical's official AWS ID

    filter {
      name = "name"
      values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
    }
}

# EC2 Instance
resource "aws_instance" "web_server" {
    ami = data.aws_ami.ubuntu.id
    instance_type = "t3.micro"
    
    subnet_id = aws_subnet.public_subnet_1.id
    vpc_security_group_ids = [aws_security_group.Web_sg.id]

    instance_market_options {
      market_type = "spot"
    }

    # Docker Automation Script
    user_data = <<-EOF
                #!/bin/bash 
                # 1. Install Docker 
                sudo apt update -y 
                sudo apt install docker.io -y 
                sudo systemctl start docker
                sudo systemctl enable docker
                # 2. Start the Nginx container natively
                sudo docker run -d -p 80:80 --name my-web-container nginx:alpine

                # 3. Wait for 5 seconds to ensure container is fully up
                sleep 5

                # 4. Inject our custom HTML directly INSIDE the running container
                sudo docker exec my-web-container sh -c "echo '<!DOCTYPE html><html><body><h1>Welcome to Darwin s Dockerized Enterprise Cloud Portfolio!</h1><p>Container Direct Injection | Provisioned via Terraform | Routed via ALB</p></body></html>' > /usr/share/nginx/html/index.html"
                EOF

    tags = {
      Name = "darwin-spot-web-server"
    }  
}

output "server_public_ip" {
    value = aws_instance.web_server.public_ip
}