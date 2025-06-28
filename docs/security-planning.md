
# 🛡️ TechForce Services - Security Planning Document

## 🔐 1. Security Objectives
- Prevent unauthorized access to infrastructure and services.
- Ensure all data is encrypted in transit and at rest.
- Protect the Kimai application from common web vulnerabilities.
- Enforce least privilege access using IAM roles and policies.
- Monitor, log, and alert for suspicious activity.

---

## 🌐 2. Network Hardening
- Public-facing services (Load Balancer) expose only ports 80 (HTTP) and 443 (HTTPS).
- Bastion Host allows SSH only from trusted IP ranges (e.g., college/public IP).
- Application and DB servers reside in private subnets.
- Use of NAT Gateway for outbound traffic from private instances.
- Web Application Firewall (WAF) deployed with OWASP rule set.

---

## 🔑 3. Identity and Access Management (IAM)
- Roles:
  - `BastionRole`: SSH access permissions to internal nodes.
  - `AppServerRole`: Limited access to container runtime and logs.
  - `JenkinsRole`: Deployment permissions to EC2 and ECR only.
- MFA (Multi-Factor Authentication) required for console access.
- No IAM users have admin access without explicit approval.
- No credentials hardcoded in app or Jenkins; use IAM roles or secrets manager.

---

## 🗝️ 4. Secure Access Strategy
- All remote access done via Bastion Host (Jump Box).
- Key-based SSH authentication only (password login disabled).
- SSH key pairs stored securely and rotated every 90 days.
- No direct internet access to DB servers.

---

## 📦 5. Application Security
- Kimai runs as a non-root user in a Docker container.
- All containers are scanned for vulnerabilities (use tools like Trivy).
- TLS termination at Load Balancer (HTTPS enforced).
- Auto security patching enabled for Linux VMs.

---

## 🕵️ 6. Logging and Monitoring
- System and application logs forwarded to centralized logging (CloudWatch or ELK).
- IAM activities monitored using AWS CloudTrail or equivalent.
- Grafana alerts for:
  - CPU > 80% for 5 min
  - Disk usage > 90%
  - Failed health checks x3

---

## 🧪 7. Security Testing
- Run regular `nmap` scans to confirm open ports match design.
- Vulnerability scans using tools like:
  - OpenVAS
  - AWS Inspector
- Periodic manual review of security group and IAM policies.

---

## ✅ 8. Final Checklist
- [ ] No hardcoded secrets
- [ ] Private subnets in use for app and DB
- [ ] WAF active on Load Balancer
- [ ] SSH access only via Bastion
- [ ] IAM roles follow least privilege
- [ ] Logs and alerts are active
