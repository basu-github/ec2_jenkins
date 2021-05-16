data "aws_ami" "Amazon_Linux_AMI" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }


  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.default.id
}

output "default_subnets" {
  value = data.aws_subnet_ids.default
}

output "defaulut_vpc" {
  value = data.aws_vpc.default.id
}

resource "aws_security_group" "sg_ssh" {
  vpc_id = data.aws_vpc.default.id

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
  }


}

resource "aws_instance" "ec2-1" {
  ami           = data.aws_ami.Amazon_Linux_AMI.id
  instance_type = "t2.micro"
  #subnet_id = data.aws_subnet_ids.default.ids[0]
  vpc_security_group_ids = [aws_security_group.sg_ssh.id]
  user_data              = file("httpd.json")
  tags = {
    Name = "ec2-tf"
  }
}


output "public_url" {
  value = aws_instance.ec2-1.public_dns

}
