# create security group for the application load balancer
resource "aws_security_group" "alb_security_group" {
  name        = "alb security group"
  description = "enable http/https access on port 80/443"
  vpc_id      = var.vpc_id

  ingress {
    description      = "http access"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "https access"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = -1
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags   = {
    Name = "alb security group"
  }
}

#create security group for instance
resource "aws_security_group" "instance" {
    name = "instance_security_group"
    vpc_id = var.vpc_id

    ingress{
            from_port = 80
            to_port = 80
            protocol = "tcp"
            security_groups = [aws_security_group.alb_security_group.id]
        }

    ingress {    
            from_port = 443
            to_port = 443
            protocol = "tcp"
            security_groups = [aws_security_group.alb_security_group.id]
        }

    ingress {
            from_port = 22
            to_port = 22
            protocol = "tcp"
            security_groups = [aws_security_group.bastion_security_group.id]
        }


    egress {
    from_port        = 0
    to_port          = 0
    protocol         = -1
    cidr_blocks      = ["0.0.0.0/0"]
  }
  
  tags = {
    Name = "instance security group"
  }

}

# create security group for the bastion host
resource "aws_security_group" "bastion_security_group" {
  name        = "bastion security group"
  description = "enable ssh connectivity to private hosts"
  vpc_id      = var.vpc_id

  ingress {
    description      = "http access"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks  = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = -1
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags   = {
    Name = "sg_bastion"
  }
}