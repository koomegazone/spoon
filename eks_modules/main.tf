terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws"

    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
  }
}


# Error handling with "The configmap "aws-auth" does not exist"
# https://github.com/terraform-aws-modules/terraform-aws-eks/issues/2009

data "aws_eks_cluster_auth" "default" {
  name = module.eks.cluster_name
}

provider "helm" {
  kubernetes {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
    token                  = data.aws_eks_cluster_auth.default.token
  }
}




provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.default.token

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    # This requires the awscli to be installed locally where Terraform is executed
    args = ["eks", "get-token", "--cluster-name", module.eks.cluster_name, "&&", "eks", "--region", local.region, "update-kubeconfig", "--name", local.name]
  }
}

data "aws_availability_zones" "available" {}
data "aws_caller_identity" "current" {}

locals {
  name            = "spoon-test"
  cluster_version = "1.26"
  region          = "ap-northeast-2"

  vpc_cidr = "10.110.0.0/16"
#  azs      = slice(data.aws_availability_zones.available.names, 0, 3)
  azs = ["ap-northeast-2a","ap-northeast-2b"]

  tags = {
    env  = "spoon"
    user = "jerry"
  }
}

resource "aws_iam_policy" "additional" {
  name = "${local.name}-additional"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

module "kms" {
  source  = "terraform-aws-modules/kms/aws"
  version = "1.1.0"

  aliases               = ["eks/${local.name}-2"]
  description           = "${local.name} cluster encryption key"
  enable_default_policy = true
  key_owners            = [data.aws_caller_identity.current.arn]

  tags = local.tags
}

