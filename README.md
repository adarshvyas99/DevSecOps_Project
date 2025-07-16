# DevSecOps Microservice Deployment on AWS (CI/CD + IaC + Security)

This project demonstrates an end-to-end **DevSecOps pipeline** for deploying a secure, containerized Node.js microservice with a MongoDB backend (via MongoDB Atlas) to **AWS ECS Fargate**, using **GitHub Actions**, **Terraform** with remote state, and best-in-class security tooling.

---

## Project Structure

DevSecOps_Project/
├── app/ # Node.js Express Application
│ ├── src/ # App source code
│ ├── Dockerfile # Hardened Dockerfile
│ ├── package.json
│ └── package-lock.json
├── .github/workflows/ # CI/CD Pipelines (GitHub Actions)
│ └── devsecops.yml
├── infrastructure/ # Terraform-based IaC
│  ├── modules/ # Reusable Terraform modules
│  │     ├── vpc/
│  │     ├── security_groups/
│  │     ├── alb/
│  │     ├── ecr/
│  │     ├── ecs/
│  │     └── secrets_manager/
│  ├── environments/
│        └── dev/
│        │     ├── main.tf # Dev environment infrastructure
│        │     ├── terraform.tfvars # tfvars wired from GitHub Environments
│        │     └── outputs.tf
│        └── prod/
├── security/                    # Security config and overrides
│   └── semgrep.yml              # Custom Semgrep rules (optional override)
├── docker-compose.yml # For local development (optional)
├── .gitignore
└── README.md

---

##  Features Implemented

###  Deployment
- Containerized **Node.js/Express** app
- Uses **MongoDB Atlas** (secured connection string from Secrets Manager)
- Runs on **AWS ECS Fargate**
- Uses **ECR** for container registry

### DevSecOps & CI/CD
- GitHub Actions CI pipeline with:
  -  Code checkout & build
  -  Static code analysis (Semgrep)
  -  Vulnerability scanning (Trivy)
  -  Docker best practices (Dockle)
  -  Infrastructure as Code (tfsec)
  -  Signed container images (cosign)
- Pushes Docker images to **ECR**
- Signs and verifies image integrity with OIDC + Cosign

###  Infrastructure as Code (Terraform)
- Modular structure for VPC, ALB, ECS, Secrets Manager, etc.
- Secrets pulled from **AWS Secrets Manager**
- Environments separated (`dev`, `prod` ready)
- Uses **GitHub Environments** to wire sensitive tfvars

---

##  CI/CD Workflow Highlights

| Stage            | Tool/Feature       | Description                                   |
|------------------|--------------------|-----------------------------------------------|
| Build            | Docker             | Multi-stage, non-root, Alpine base            |
| SAST             | Semgrep            | Analyzes `app/` source for security flaws     |
| Dependency Scan  | `npm audit`        | Detects vulnerable Node.js packages           |
| Image Scan       | Trivy              | Checks built image for OS & app vulnerabilities |
| Lint Dockerfile  | Dockle             | Warns against Dockerfile misconfigurations    |
| IaC Scan         | tfsec              | Analyzes Terraform for security issues        |
| Container Signing| Cosign + OIDC      | Signs & verifies container integrity          |
| Infra Provision  | Terraform          | Creates all AWS resources via modular setup   |

---

##  Secrets & Environment Config

| Secret/Variable            | Source                      | Usage                                   |
|----------------------------|-----------------------------|-----------------------------------------|
| `AWS_ACCESS_KEY_ID`        | GitHub Secrets              | Terraform & AWS CLI auth                |
| `AWS_SECRET_ACCESS_KEY`    | GitHub Secrets              |                                         |
| `AWS_REGION`               | GitHub Secrets / `env`      | AWS region (e.g. ap-south-1)            |
| `ECR_REPOSITORY`           | GitHub Secrets              | Image name & repo                       |
| `TF_ECR_REPO_URL`          | GitHub Secrets              | Full ECR repo URL for Terraform         |
| `SEMGREP_APP_TOKEN`        | GitHub Secrets              | For authenticated Semgrep runs          |
| `MONGODB_URI`              | AWS Secrets Manager         | Injected securely into ECS containers   |

---

##  Getting Started

### Local App Dev (Optional)
```bash
cd app/
npm install
npm run dev
```
You can run the application locally using Docker Compose. This is useful for local testing, debugging, and development without relying on cloud infrastructure.
```bash
docker-compose up --build -d
```
The app will be available at: http://localhost:3000
The backend MongoDB will be accessible on port 27017

#### Stop Containers
```bash
docker-compose down
```
 #### Clean All Data (Optional)
```bash
docker-compose down -v
```