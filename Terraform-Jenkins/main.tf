resource "aws_instance" "Jenkins" {
  ami           = "ami-0fc5d935ebf8bc3bc"
  instance_type = "t2.large"
  key_name      = key-login
  vpc_security_group_ids = [aws_security_group.Jenkins-sg.id]
  user_data     = templatefile("./install.sh", {})

  tags = {
    Name = "Jenkins"
  }

  root_block_device {
    volume_size = 30
  }
}

resource "aws_security_group" "Jenkins-sg" {
  name        = "Jenkins-sg"
  description = "Allow TLS inbound traffic"

  ingress = [
    for port in [22, 80, 443, 8080, 9000, 3000] : {
      description      = "inbound rules"
      from_port        = port
      to_port          = port
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "jenkins-sg"
  }
}