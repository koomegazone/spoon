module "lb_controller_helm" {
  source = "github.com/lablabs/terraform-aws-eks-load-balancer-controller"
  
  enabled           = true
  argo_enabled      = false
  argo_helm_enabled = false

  cluster_name                     = module.eks.cluster_name
  cluster_identity_oidc_issuer     = module.eks.oidc_provider
  cluster_identity_oidc_issuer_arn = module.eks.oidc_provider_arn

  helm_release_name = "aws-lbc-helm"
  namespace         = "aws-lb-controller-helm"

  values = yamlencode({
    "podLabels" : {
      "app" : "aws-lbc-helm"
    }
  })

  helm_timeout = 240
  helm_wait    = true
}