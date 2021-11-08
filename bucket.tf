resource "aws_s3_bucket" "b" {
  bucket = "bharath.vasireddy"
  acl    = "private"

  tags = {
    Name        = "bharath.vasireddy"
    Environment = "Dev"
  }
}