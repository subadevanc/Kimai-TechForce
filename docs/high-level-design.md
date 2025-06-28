# High-Level Design (HLD) – Kimai Infrastructure

## 1. Project Overview
TechForce Services is migrating the on-premise Kimai timesheet application to a secure, scalable, and cost-effective multi-cloud infrastructure using cloud-native and open-source tools.

## 2. Multi-Cloud Strategy
- AWS: Core application hosting, CI/CD (Jenkins), Bastion Host, RDS PostgreSQL
- GCP: Logging and monitoring stack (Prometheus, Grafana, or Google Cloud Operations)

## 3. Key Components
- VPC (AWS) with public/private subnets
- Bastion Host (for secure access)
- Jenkins Server (CI/CD pipeline)
- Dockerized Kimai App (behind a Load Balancer)
- RDS PostgreSQL (database)
- GCP: Logging (ELK or Stackdriver), Monitoring (Grafana)

## 4. Technology Stack

| Function        | Technology         | Reason                                 |
|----------------|--------------------|----------------------------------------|
| Infrastructure | Terraform          | IaC tool, cloud-agnostic               |
| Containerization | Docker           | Portable, consistent runtime           |
| CI/CD          | Jenkins            | Reliable, open-source CI/CD            |
| Database       | RDS PostgreSQL     | Managed database, backups, scaling     |
| Monitoring     | Prometheus + Grafana | Real-time metrics and alerts        |
| Logging        | ELK / GCP Logging  | Centralized log management             |
| Security       | IAM, SGs, WAF      | Least privilege, controlled access     |

## 5. Architecture Diagram

![Kimai Architecture Diagram](kimai-architecture.png)
