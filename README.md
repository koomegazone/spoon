![header](https://capsule-render.vercel.app/api?type=wave&color=auto&height=300&section=header&text=spoon%20radio&fontSize=90)


## 실습 (k8s) 
* AWS의 모든 자원은 terraform으로 구성 하였습니다.
* 네트워크 구성은 vpc module을 그대로 활용했습니다.  
* 테라폼에서 권장하는 2개 이상의 az에 Subnet 3개씩 구성하며 Public Subnet과 Private 
Subnet을 구성하며 private Subnet은 NAT 구성 합니다.
* Application Load Balancer(ALB)는 인터넷으로 접근이 가능하며 k8s
에 구성된 Pod로 라우팅합니다. 
* k8s의 ingress는 AWS Load Balancer Controller를 사용합니다. 
* Deployment에 구성되는 Pod는 2048 게임 이미지를 사용합니다.

## 선택 실습 (Github action)
* Action Runner Controller을 설치하여 Action runner가 쿠버네티스 pod로 실행될수 있도록 구성합니다. 
* ARC/* directory 내부 README를 확인해주세요.
