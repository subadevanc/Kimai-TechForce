# ⏱️ Kimai-TechForce

Kimai-TechForce is a secure, cloud-native migration of the [Kimai](https://www.kimai.org/) time-tracking software—fully containerized, automated with CI/CD pipelines, and backed by robust infrastructure as code and multi-cloud monitoring.

> 📅 Project Started: 10-07-2025  
> 

---

## 📌 Project Goals

- 🚀 Containerize Kimai with Docker and Apache
- 🔄 Automate CI/CD with Jenkins
- ☁️ Use AWS for application, Jenkins, and database hosting
- 📊 Monitor metrics with Prometheus + Grafana on GCP
- 🔐 Harden infrastructure with IAM and Security Groups
- 📁 Provision infra using Terraform (IaC)
- 🛡️ Enable real-time logging, alerting, and backups

---

## 🧱 Infrastructure Design

### ☁️ Cloud Platforms

- **AWS** – App, Jenkins, Bastion Host, RDS
- **GCP** – Grafana + Prometheus stack for monitoring

### 📡 Network

- AWS VPC CIDR: `10.0.0.0/16` (Public: Jenkins/Bastion, Private: App/RDS)
- GCP VPC CIDR: `10.1.0.0/16` (Private Monitoring Stack)

### 🔧 Compute

- EC2: `t2.micro` (App, Jenkins, Bastion)
- GCP: `e2-micro` for Grafana/Prometheus
- Auto Scaling (App): min 1 – max 3 (triggered at >70% CPU)

### 💽 Storage

- RDS PostgreSQL (`db.t3.micro`, 20GB, encrypted, 7-day backup)
- Docker volumes for persistent data

---

## 📂 Repository Structure

```
Kimai-TechForce/
├── docker/              # Dockerfile + UI Redirect
│   ├── Dockerfile
│   └── index.html
├── jenkins/             # Jenkins Pipeline
│   └── Jenkinsfile
├── terraform/           # Infrastructure as Code
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── modules/
│       ├── network/
│       ├── compute/
│       └── security/
└── README.md
```

---

## 🐳 Docker Deployment

1. **Dockerfile** (NGINX + Redirect):

```Dockerfile
FROM nginx:alpine
WORKDIR /usr/share/nginx/html
COPY index.html .
EXPOSE 80
```

2. **Run Locally**

```bash
docker build -t kimai-html docker/
docker run -d -p 80:80 kimai-html
```

---

## 🔄 Jenkins CI/CD Pipeline

- **Trigger**: GitHub push
- **Pipeline Steps**:
  - Checkout
  - Build Docker Image
  - Push to DockerHub (`kalaisk/kimai-html:latest`)
  - Deploy on EC2

🔑 **DockerHub Credentials**: Set `docker-token` in Jenkins credentials  
📁 Jenkinsfile Path: `jenkins/Jenkinsfile`

---

## 🏗️ Terraform Infrastructure

- **Backend**: Remote S3 + DynamoDB lock
- **Modules**:
  - `network/` – VPC, subnets
  - `compute/` – EC2 for App, Jenkins, Bastion
  - `security/` – IAM roles, Security Groups

### Commands:

```bash
terraform init
terraform plan
terraform apply
```

---

## 🔐 Security Highlights

- IAM roles: JenkinsRole, AppServerRole, BastionRole
- Only SSH (22) + HTTP (80) exposed
- Bastion host with key-based auth only
- ALB across 2 AZs for HA web access
- Nmap + AWS Security Hub used for validation

---

## 📈 Monitoring & Alerts

- **Prometheus**: Node Exporter on EC2
- **Grafana**: Visual Dashboards via GCP
- **CloudWatch Logs**: Log storage and Grafana log view
- **Alerts**: CPU, Memory via SNS Email from Grafana

---

## 🌐 Live Demo

✅ Deployed at:  
`http://13.60.234.66` → Automatically redirects to [https://www.kimai.org/](https://www.kimai.org/)

---

## 🧠 Lessons Learned

- Effective use of Terraform modules and remote backend
- Jenkins and DockerHub integration improves deployment speed
- Grafana-SNS pipeline ensures proactive infrastructure monitoring

---

## 📜 License

This project is licensed under the MIT License.  
See [LICENSE](LICENSE) for details.

---

## 🙌 Contribute

Pull requests and feedback are welcome!  
Feel free to open an [issue](https://github.com/subadevanc/Kimai-TechForce/issues) or submit a PR.
