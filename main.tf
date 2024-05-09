provider "aws" {
  region = "ap-northeast-2"
}
module "eks" {
  source = "./eks_modules"
}
