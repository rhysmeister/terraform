provider "aws" {
  profile = "default"
  region  = "eu-central-1"
}

resource "aws_s3_bucket" "tf_course_bucket" {
  bucket = "tf-course-hdjkdhfkjasgdfafsdhja"
  acl    = "private"
}
