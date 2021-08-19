variable "vpcid" {
	type = string
	default = "vpc-dc70f2a1"
}

resource "aws_security_group" "terraform_ec2_sg" {
	name ="terraform_ec2_sg"
	description = "terraform sg for ec2 instance"
	vpc_id = "${var.vpcid}"

	ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

 ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

/*  tags= {
    Name = var.security_group
  }
 */
}

variable "amiid" {
    default = "ami-09e67e426f25ce0d7"
}


resource "aws_instance" "terraform_ec2_instance" {
    ami = "${var.amiid}"
    instance_type = "t2.micro"
    key_name = "new-kondalu"
    vpc_security_group_ids = ["${aws_security_group.terraform_ec2_sg.id}"]
    tags = {
       Name = " Terraform EC2 instance"
    }
}

output "sg_id_output" {
    value = "${aws_security_group.terraform_ec2_sg.id}"
}