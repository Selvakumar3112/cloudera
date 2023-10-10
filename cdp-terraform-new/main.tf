terraform {
  required_providers {
    cdp = {
      source  = "cloudera/cdp"
      version = "0.1.4-pre"
    }
  }

  required_version = ">= 1.3.0"
}

resource "cdp_environments_aws_credential" "cdp-credential" {
  credential_name = "terraform-aws-cred"
  role_arn        = "arn:aws:iam::264240408057:role/cloudera-role"
  description     = "cdp-credential AWS Credentials"
}

resource "cdp_environments_aws_environment" "cdp-env" {
  environment_name = "cdp-terraform-demo"
  credential_name  = cdp_environments_aws_credential.cdp-credential.credential_name
  region           = "eu-west-2"
  security_access = {
    cidr = "0.0.0.0/0"
  }
#  network_cidr = "10.10.0.0/16"
  vpc_id                             = "vpc-0474aada39cc06e80"
  subnet_ids                         = ["subnet-0d70b4536819c93f7","subnet-0b1259f21b2efc580","subnet-087be58e339764c9a"]
  authentication = {
    public_key_id = "cloudera"
  }
freeipa = {
    instance_count_by_group = 1
    multi_az                = false
    catalog                 = "cdp-default"
   # image_id                = "2023-08-25|ed0cbd97-006a-4448-bf8d-6ca588380d0c|"
   # instance_type           = "t2.micro"
  }
  log_storage = {
    storage_location_base = "s3a://cdcps3buck13/cdp/"
    instance_profile      = "arn:aws:iam::264240408057:instance-profile/CDP"
  }
}

# ------- CDP Datalake -------

#resource "cdp_datalake_aws_datalake" "cdp-datalake" {
#  datalake_name           = "demo-datalake-terraform"
#  environment_name        = "cdp-terraform-demo"
#  instance_profile        = "arn:aws:iam::264240408057:instance-profile/CDP"
#  storage_bucket_location = "s3a://cdcps3buck13/cdp/"
#}
