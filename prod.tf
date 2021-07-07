variable "whitelist" {
  type = list(string)
}
variable "web_image_id" {
  type = string
}
variable "web_instance_type" {
  type = string
}
variable "web_desired_capacity" {
  type = number
}
variable "web_max_size" {
  type = number
}
variable "web_min_size" {
  type = number
}
variable "web_env" {
  type = string
}

provider "aws" {
  profile = "aws_terraform"
  region  = "eu-central-1"
  default_tags {
    tags = {
      "Terraform": "true",
      "Environment": var.web_env 
    }
  }
}

resource "aws_s3_bucket" "prod_tf_course_bucket" {
  bucket = "tf-course-hdjkdhfkjasgdfafsdhja"
  acl    = "private"
}

resource "aws_default_vpc" "default" {}

resource "aws_default_subnet" "default_az1" {
  availability_zone = "eu-central-1a"
}

resource "aws_default_subnet" "default_az2" {
  availability_zone = "eu-central-1b"
}

resource "aws_security_group" "prod_web" {
  name        = "prod_web"
  description = "Allow standard http and port inbound and everything outbound"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.whitelist
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] 
  }
}

module "web_app" {
  source = "./modules/web_app"

  web_image_id         = var.web_image_id
  web_instance_type    = var.web_instance_type
  web_desired_capacity = var.web_desired_capacity
  web_max_size         = var.web_max_size
  web_min_size         = var.web_min_size
  subnets              = [aws_default_subnet.default_az1.id,aws_default_subnet.default_az2.id]
  security_groups      = [aws_security_group.prod_web.id]
  web_app	       = "prod"
}


