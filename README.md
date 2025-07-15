# DevSecOps Secure Microservice

A Node.js/Express microservice with mongodb implementation demonstrating DevSecOps best practices for containerized deployments.

## Security Features

- **Container Security**: Multi-stage Docker builds with Alpine base images
- **Non-root execution**: Application runs as non-privileged user
- **Secrets Management**: No hardcoded secrets, uses environment variables and secrets managers
- **Security Scanning**: Integrated Trivy, Semgrep, and Dockle scanning
- **Runtime Protection**: Security contexts and capability restrictions

## Quick Start

### Prerequisites

- Docker and Docker Compose
- Node.js 18+ (for local development)
- Terraform (for infrastructure deployment)

### Local Development

1. **Clone and setup**:
   ```bash
   git clone <repository-url>
   cd DevSecOps_Project
   npm install
   ```

2. **Create secrets directory**:
   ```bash
   mkdir secrets
   echo "admin" > secrets/mongo_root_username.txt
   echo "securepassword123" > secrets/mongo_root_password.txt
   ```

3. **Run with Docker Compose**:
   ```bash
   docker-compose up --build
   ```

4. **Test the application**:
   ```bash
   curl http://localhost:3000/
   curl http://localhost:3000/health
   curl http://localhost:3000/api/users
   ```

### Security Scanning

1. **Scan Dockerfile**:
   ```bash
   # Install Trivy
   docker run --rm -v $PWD:/app aquasec/trivy:latest fs /app

   # Install Dockle
   docker run --rm -v /var/run/docker.sock:/var/run/docker.sock \
     -v $PWD:/root/.cache/ goodwithtech/dockle:latest <image-name>
   ```

2. **Static Code Analysis**:
   ```bash
   # Install Semgrep
   pip install semgrep
   semgrep --config=auto .
   ```

3. **Dependency Audit**:
   ```bash
   npm audit
   npm audit fix
   ```

##  Infrastructure Deployment

### AWS Deployment with Terraform

1. **Configure AWS credentials**:
   ```bash
   aws configure
   ```

2. **Deploy infrastructure**:
   ```bash
   terraform init
   terraform plan
   terraform apply
   ```

3. **Verify deployment**:
   ```bash
   terraform output
   ```

##  CI/CD Pipeline

The GitHub Actions pipeline (`devsecops.yml`) includes:

1. **Security Scanning**:
   - Semgrep SAST analysis
   - npm audit for dependencies
   - Secrets detection

2. **Container Security**:
   - Trivy vulnerability scanning
   - Dockle best practices check
   - Build fails on critical issues

3. **Deployment**:
   - Secure image registry push
   - Container signing (optional)

### Required Secrets

Configure these in your GitHub repository:

- `SEMGREP_APP_TOKEN`: Semgrep API token
- `GITHUB_TOKEN`: Automatically provided by GitHub

## Security Checklist

-  Multi-stage Docker build with minimal base image
-  Non-root user execution
-  No hardcoded secrets
-  Container vulnerability scanning
-  Static code analysis
-  Dependency vulnerability checking
-  Infrastructure as Code with security scanning
-  Least-privilege IAM policies
-  Security contexts and capability restrictions
-  Health checks and monitoring

##  Runtime Security

### Docker Security Context

```yaml
security_opt:
  - no-new-privileges:true
cap_drop:
  - ALL
cap_add:
  - CHOWN
  - SETGID
  - SETUID
read_only: true
```

### Kubernetes Security Context (Optional)

```yaml
securityContext:
  runAsNonRoot: true
  runAsUser: 1001
  readOnlyRootFilesystem: true
  allowPrivilegeEscalation: false
  capabilities:
    drop:
      - ALL
```

##  Monitoring and Logging

- Health check endpoint: `/health`
- Application logs via CloudWatch
- Container metrics monitoring
- Security event logging

##  Troubleshooting

### Common Issues

1. **Container fails to start**:
   - Check user permissions
   - Verify secrets are properly mounted
   - Review security context settings

2. **Security scan failures**:
   - Update base images
   - Fix dependency vulnerabilities
   - Review Trivy ignore file

3. **Database connection issues**:
   - Verify MongoDB credentials
   - Check network connectivity
   - Review secrets configuration

##  Additional Resources

- [Docker Security Best Practices](https://docs.docker.com/develop/security-best-practices/)
- [OWASP Container Security](https://owasp.org/www-project-container-security/)
- [CIS Docker Benchmark](https://www.cisecurity.org/benchmark/docker)
- [Kubernetes Security Best Practices](https://kubernetes.io/docs/concepts/security/)
