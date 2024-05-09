# https://github.com/aws/secrets-store-csi-driver-provider-aws
# kms 서비스와 Secret Manager을 통해 EKS 내부의 k8s secret을 관리할수 있습니다.
#
```
helm repo add secrets-store-csi-driver https://kubernetes-sigs.github.io/secrets-store-csi-driver/charts
helm install -n kube-system csi-secrets-store secrets-store-csi-driver/secrets-store-csi-driver
kubectl apply -f https://raw.githubusercontent.com/aws/secrets-store-csi-driver-provider-aws/main/deployment/aws-provider-installer.yaml
```
#
# REGION=<REGION>
# CLUSTERNAME=<CLUSTERNAME>
#
```
aws --region "$REGION" secretsmanager  create-secret --name MySecret --secret-string '{"username":"memeuser", "password":"hunter2"}'

eksctl utils associate-iam-oidc-provider --region="$REGION" --cluster="$CLUSTERNAME" --approve # Only run this once

eksctl create iamserviceaccount --name nginx-deployment-sa --region="$REGION" --cluster "$CLUSTERNAME" --attach-policy-arn "$POLICY_ARN" --approve --override-existing-serviceaccounts

kubectl apply -f https://raw.githubusercontent.com/aws/secrets-store-csi-driver-provider-aws/main/examples/ExampleSecretProviderClass.yaml

kubectl apply -f https://raw.githubusercontent.com/aws/secrets-store-csi-driver-provider-aws/main/examples/ExampleDeployment.yaml

kubectl exec -it $(kubectl get pods | awk '/nginx-deployment/{print $1}' | head -1) cat /mnt/secrets-store/MySecret; echo
```