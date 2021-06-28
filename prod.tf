provider "aws" {
  profile = "aws_terraform"
  region  = "eu-central-1"
}

resource "aws_s3_bucket" "prod_tf_course_bucket" {
  bucket = "tf-course-hdjkdhfkjasgdfafsdhja"
  acl    = "private"
}

resource "aws_default_vpc" "default" {}

