provider "aws" {
  version = "~> 2.0"
  region = "eu-north-1"

}
resource "aws_s3_bucket" "bucket-host" {
  bucket = "my-tf-bucket-host"
  acl    = "private"

  tags = {
    Managed = "Terraform"
  }
}

resource "aws_s3_bucket" "bucket-asset" {
  bucket = "my-tf-bucket-asset"
  acl    = "private"

  tags = {
    Managed = "Terraform"
  }
}

resource "aws_s3_bucket_policy" "bucket-host" {
  bucket = "my-tf-bucket-host"

  policy = templatefile("policy/public_bucket.json.tpl", {
    bucket_arn = aws_s3_bucket.bucket-host.arn
  })
}

resource "aws_s3_bucket_policy" "bucket-asset" {
  bucket = "my-tf-bucket-asset"

  policy = templatefile("policy/public_bucket.json.tpl", {
    bucket_arn = aws_s3_bucket.bucket-asset.arn
  })
}