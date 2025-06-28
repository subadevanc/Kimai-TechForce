# Kimai-TechForce Infrastructure Project

This project designs a **secure, multi-cloud infrastructure** for deploying the [Kimai](https://www.kimai.org/) time-tracking application, replacing TechForce Services' on-premise setup.

## 🧱 Architecture Overview

- **Clouds Used**: AWS (Core App) + GCP (Monitoring/Logging)
- **Tools**: Terraform, Docker, Jenkins, Grafana, CloudWatch
- **Key Features**:
  - Multi-cloud VPC design
  - Jenkins-based CI/CD pipeline
  - Dockerized Kimai deployment
  - Bastion-host access
  - WAF & IAM security
  - Centralized logging & alerting

## 📁 Repo Structure

```bash
Kimai-TechForce/
├── terraform/             # Infrastructure as Code
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── modules/
│       ├── networking/
│       ├── compute/
│       └── security/
├── docker/                # Dockerfile for Kimai
│   └── Dockerfile
├── jenkins/               # CI/CD pipeline
│   └── Jenkinsfile
├── docs/                  # Design documentation
│   ├── high-level-design.md
│   └── low-level-design.md
├── final-report.pdf       # Final project report (to be added)
└── README.md              # You're here
