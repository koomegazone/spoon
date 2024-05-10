*** 1. 클러스터에 Cert-Manager 설치
```
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.8.2/cert-manager.yaml
```
*** 2. ARC를 Helm으로 설치
```
helm repo add actions-runner-controller https://actions-runner-controller.github.io/actions-runner-controller
```
*** 3. github token 입력 후 arc 설치
```
Github_token="깃헙토큰"
helm upgrade --install \
  --set=authSecret.create=true\
  --set=authSecret.github_token=${Github_token}\
  --wait actions-runner-controller actions-runner-controller/actions-runner-controller
```
*** 4. runner deploy
```
cat <<EOF | kubectl create -f -
apiVersion: actions.summerwind.dev/v1alpha1
kind: RunnerDeployment
metadata:
  name: github-runnerdeploy
spec:
  replicas: 1
  template:
    spec:
      repository: "koomegazone/spoon"
      # 개발/운영으로 github action runner를 구분할때 아래 labels 활용
      labels:
      - dev-self-hosted-runner
EOF
```
