![header](https://capsule-render.vercel.app/api?type=wave&color=auto&height=300&section=header&text=spoon%20radio&fontSize=90)


## 실습 (k8s) 
* AWS의 모든 자원은 IaC(terraform, ansible, eksctl yaml.. etc)로 구성 합니다.
* 네트워크 구성은 다음을 따릅니다.
* VPC는 default vpc를 사용해도 무방합니다.
* Subnet은 2개로 구성하며 Public Subnet 제외한 Private
Subnet는 NAT 구성 합니다.
* Application Load Balancer(ALB)는 인터넷으로 접근이 가능하며 k8s
에 구성된 Pod로 라우팅합니다.
* k8s의 ingress는 AWS Load Balancer Controller를 사용합니다.
* Deployment에 구성되는 Pod는 nginx 이미지를 사용합니다.

