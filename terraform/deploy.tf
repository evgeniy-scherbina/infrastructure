provider "aws" {
  profile    = "terraform_sotonamitol"
  region     = var.region
}

resource "aws_key_pair" "ssh-login-key" {
  key_name   = "ssh-login-key"
  public_key = "${file("/Users/evgeniyscherbina/.ssh/id_rsa_test.pub")}"
}

// TODO(evg): either rename or create few security groups
resource "aws_security_group" "allow-ssh-login" {
  name        = "allow-ssh-login"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    # Please restrict your ingress to only necessary IPs and ports.
    # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
    cidr_blocks = ["0.0.0.0/0"] # add a CIDR block here
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    # Please restrict your ingress to only necessary IPs and ports.
    # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
    cidr_blocks = ["0.0.0.0/0"] # add a CIDR block here
  }

  egress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

// TODO(evg): rename to jenkins master
resource "aws_instance" "example" {
  ami             = var.amis[var.region]
  instance_type   = "t2.micro"
  key_name        = "ssh-login-key"
  security_groups = ["allow-ssh-login"]

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "ubuntu"
      host        = aws_instance.example.public_ip
      agent       = "false"
      private_key = "${file("/Users/evgeniyscherbina/.ssh/id_rsa_test")}"
    }

    script = "wait_proper_init.sh"
  }
}

resource "aws_instance" "jenkins_slave_1" {
  ami             = var.amis[var.region]
  instance_type   = "t2.micro"
  key_name        = "ssh-login-key"
  security_groups = ["allow-ssh-login"]

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "ubuntu"
      host        = aws_instance.jenkins_slave_1.public_ip
      agent       = "false"
      private_key = "${file("/Users/evgeniyscherbina/.ssh/id_rsa_test")}"
    }

    script = "jenkins_slave_1.sh"
  }
}
