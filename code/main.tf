provider "aws" {
  region = var.region
}

resource "aws_security_group" "cba_tf_sg" {
  name        = "cba_tf_sg"
  description = "allow all traffic"
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
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name  = "CBAterraformSG"
    Owner = "samuelakosaonyejekwe"
  }
}

resource "aws_instance" "cba_tf_instance" {
  instance_type   = var.instance_type
  security_groups = [aws_security_group.cba_tf_sg.name]
  ami             = var.instance_ami
  key_name        = var.key_name
  user_data       = file("install_apache.sh")

  # user_data only runs on first boot, so force a replacement when it changes
  # (AWS provider v5+ would otherwise update it in place and Apache would never install)
  user_data_replace_on_change = true

  tags = {
    Name  = "CBATerraformInstance"
    Owner = "samuelakosaonyejekwe"
  }
}
