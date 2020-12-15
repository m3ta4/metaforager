terraform {
  backend "s3" {
    bucket  = "us-west-2-metaforager-terraform"
    key     = "global/s3/metaforager.com/terraform.tfstate"
    profile = "stuart-cloud"
    region  = "us-west-2"
  }
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "metaforager.com"
  acl    = "public-read"
  policy = file("policy.json")

  website {
    index_document = "index.html"
    error_document = "error.html"
  }

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }

}

output "s3_bucket_arn" {
  value = aws_s3_bucket.terraform_state.arn
}

