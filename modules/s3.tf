provider "aws" {
  region = "ap-northeast-2"
}
module "my-s3" {
  source = "./modules"
}
