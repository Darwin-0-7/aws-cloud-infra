terraform {
    backend "s3" {
        bucket               = "darwin-aws-portfolio-state"
        key                  = "state/terraform.tfstate"
        region               = "ap-south-1"
        dynamodb_table       = "darwin-infra-state-lock"
        encrypt              = true
    }
}