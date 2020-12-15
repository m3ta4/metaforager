terraform {
  backend "s3" {
    bucket  = "us-west-2-metaforager-terraform"
    key     = "global/s3/us-west-2-metaforager-terraform/terraform.tfstate"
    profile = "stuart-cloud"
    region  = "us-west-2"
  }
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "us-west-2-metaforager-terraform"

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }

  policy = file("policy.json")
}

output "s3_bucket_arn" {
  value = aws_s3_bucket.terraform_state.arn
}
