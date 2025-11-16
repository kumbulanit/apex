# Oracle APEX Docker & Kubernetes Deployment Guide

## Table of Contents

1. [Overview](#overview)
2. [Prerequisites for Ubuntu 24.04](#prerequisites-for-ubuntu-2404)
3. [Docker Installation](#docker-installation-ubuntu-2404)
4. [Docker Compose Setup for APEX](#docker-compose-setup-for-apex)
5. [Kubernetes Installation (Minikube)](#kubernetes-installation-minikube)
6. [APEX Deployment on Kubernetes](#apex-deployment-on-kubernetes)
7. [Production Kubernetes Deployment](#production-kubernetes-deployment)
8. [CI/CD Pipeline Integration](#cicd-pipeline-integration)
9. [Monitoring and Maintenance](#monitoring-and-maintenance)
10. [Troubleshooting](#troubleshooting)

---

## Overview

This guide covers deploying Oracle APEX using containerization technologies:

- **Docker**: For local development and testing
- **Kubernetes (Minikube)**: For local Kubernetes development
- **Kubernetes (Production)**: For production-grade deployments

### Architecture Components

```
┌─────────────────┐
│  Load Balancer  │
│   (Ingress)     │
└────────┬────────┘
         │
    ┌────┴────┐
    │         │
┌───▼───┐ ┌──▼────┐
│ ORDS  │ │ ORDS  │ (Replicas)
│ Pod   │ │ Pod   │
└───┬───┘ └──┬────┘
    │        │
    └────┬───┘
         │
    ┌────▼────┐
    │ Oracle  │
    │Database │
    │  Pod    │
    └─────────┘
```

---

## Prerequisites for Ubuntu 24.04

### System Requirements

#### Hardware
- **CPU**: 4+ cores (8+ cores recommended for Kubernetes)
- **RAM**: 8GB minimum (16GB+ recommended for Kubernetes)
- **Disk**: 50GB free space (SSD recommended)
- **Network**: Stable internet connection

#### Software
- Ubuntu 24.04 LTS (fresh installation recommended)
- Sudo/root access
- Internet connectivity

### Initial System Setup

```bash
# Update system packages
sudo apt update && sudo apt upgrade -y

# Install essential tools
sudo apt install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    software-properties-common \
    wget \
    git \
    vim \
    net-tools \
    unzip

# Set up hostname (optional but recommended)
sudo hostnamectl set-hostname apex-k8s-node
```

---

## Docker Installation (Ubuntu 24.04)

### Step 1: Remove Old Docker Versions

```bash
# Remove any existing Docker installations
sudo apt remove -y docker docker-engine docker.io containerd runc

# Clean up old Docker data
sudo rm -rf /var/lib/docker
sudo rm -rf /var/lib/containerd
```

### Step 2: Install Docker Engine

```bash
# Add Docker's official GPG key
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add Docker repository
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update package index
sudo apt update

# Install Docker Engine, containerd, and Docker Compose
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Verify Docker installation
docker --version
docker compose version
```

### Step 3: Configure Docker

```bash
# Start and enable Docker service
sudo systemctl start docker
sudo systemctl enable docker

# Add current user to docker group (to run docker without sudo)
sudo usermod -aG docker $USER

# Apply group changes (logout/login or run this)
newgrp docker

# Verify Docker works without sudo
docker run hello-world

# Configure Docker daemon for production
sudo tee /etc/docker/daemon.json > /dev/null <<EOL
{
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "10m",
    "max-file": "3"
  },
  "storage-driver": "overlay2",
  "default-ulimits": {
    "nofile": {
      "Name": "nofile",
      "Hard": 65536,
      "Soft": 65536
    }
  }
}
EOL

# Restart Docker to apply configuration
sudo systemctl restart docker

# Verify Docker status
sudo systemctl status docker
```

### Step 4: Install Docker Compose (Standalone - Optional)

```bash
# Download latest Docker Compose standalone binary
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

# Make it executable
sudo chmod +x /usr/local/bin/docker-compose

# Verify installation
docker-compose --version
```

---

## Docker Compose Setup for APEX

### Step 1: Create Project Directory

```bash
# Create APEX project directory
mkdir -p ~/apex-docker
cd ~/apex-docker

# Create subdirectories
mkdir -p {database,ords,apex,logs,backups}
```

### Step 2: Download Oracle Container Images

```bash
# Clone Oracle Docker images repository
git clone https://github.com/oracle/docker-images.git
cd docker-images/OracleDatabase/SingleInstance/dockerfiles

# Download Oracle Database installation files
# Go to https://www.oracle.com/database/technologies/oracle-database-software-downloads.html
# Download Oracle Database 19c or 23ai for Linux x86-64
# Place the zip file in the appropriate version folder (19.3.0 or 23ai)

# Build Oracle Database Docker image
cd ~/docker-images/OracleDatabase/SingleInstance/dockerfiles
./buildContainerImage.sh -v 19.3.0 -e

# This will take 15-30 minutes
# Image will be tagged as: oracle/database:19.3.0-ee
```

### Step 3: Create Docker Compose Configuration

Create `docker-compose.yml`:

```yaml
version: '3.8'

services:
  # Oracle Database Service
  oracle-db:
    image: oracle/database:19.3.0-ee
    container_name: apex-oracle-db
    hostname: oracle-db
    ports:
      - "1521:1521"
      - "5500:5500"
    environment:
      - ORACLE_SID=ORCL
      - ORACLE_PDB=ORCLPDB1
      - ORACLE_PWD=YourStrongPassword123
      - ORACLE_CHARACTERSET=AL32UTF8
      - ENABLE_ARCHIVELOG=false
    volumes:
      - oracle-data:/opt/oracle/oradata
      - oracle-setup:/opt/oracle/scripts/setup
      - oracle-startup:/opt/oracle/scripts/startup
      - ./backups:/opt/oracle/backups
    networks:
      - apex-network
    shm_size: 2gb
    ulimits:
      nofile:
        soft: 65536
        hard: 65536
    healthcheck:
      test: ["CMD", "sqlplus", "-L", "sys/YourStrongPassword123@//localhost:1521/ORCL as sysdba", "@healthcheck.sql"]
      interval: 30s
      timeout: 10s
      retries: 5
      start_period: 120s
    restart: unless-stopped

  # APEX Installation Service (runs once)
  apex-installer:
    image: oracle/database:19.3.0-ee
    container_name: apex-installer
    depends_on:
      oracle-db:
        condition: service_healthy
    volumes:
      - ./apex:/apex
      - ./scripts:/scripts
    networks:
      - apex-network
    command: >
      bash -c "
        echo 'Waiting for database to be ready...'
        sleep 60
        echo 'Installing APEX...'
        cd /apex
        sqlplus sys/YourStrongPassword123@//oracle-db:1521/ORCL as sysdba @apexins.sql SYSAUX SYSAUX TEMP /i/
        echo 'APEX installation completed'
      "
    restart: "no"

  # Oracle REST Data Services (ORDS)
  ords:
    image: container-registry.oracle.com/database/ords:latest
    container_name: apex-ords
    hostname: ords
    depends_on:
      apex-installer:
        condition: service_completed_successfully
    ports:
      - "8080:8080"
      - "8443:8443"
    environment:
      - ORACLE_HOST=oracle-db
      - ORACLE_PORT=1521
      - ORACLE_SERVICE=ORCL
      - ORACLE_PWD=YourStrongPassword123
      - ORDS_PWD=YourOrdsPassword123
      - APEX_PUBLIC_USER_PWD=YourApexPassword123
      - APEX_LISTENER_PWD=YourListenerPassword123
      - APEX_REST_PWD=YourRestPassword123
    volumes:
      - ords-config:/etc/ords/config
      - ords-logs:/var/log/ords
      - ./apex/images:/usr/local/tomcat/webapps/i
    networks:
      - apex-network
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:8080/ords"]
      interval: 30s
      timeout: 10s
      retries: 3
      start_period: 60s
    restart: unless-stopped

volumes:
  oracle-data:
    driver: local
  oracle-setup:
    driver: local
  oracle-startup:
    driver: local
  ords-config:
    driver: local
  ords-logs:
    driver: local

networks:
  apex-network:
    driver: bridge
    ipam:
      config:
        - subnet: 172.20.0.0/16
```

### Step 4: Download and Prepare APEX

```bash
# Download APEX from oracle.com
cd ~/apex-docker
wget https://download.oracle.com/otn_software/apex/apex_24.2.zip

# Extract APEX
unzip apex_24.2.zip

# Download ORDS
wget https://download.oracle.com/otn_software/java/ords/ords-latest.zip
unzip ords-latest.zip -d ords
```

### Step 5: Create Helper Scripts

Create `scripts/healthcheck.sql`:

```sql
-- healthcheck.sql
SET HEADING OFF
SET PAGESIZE 0
SELECT 'OK' FROM dual;
EXIT;
```

Create `scripts/install-apex.sh`:

```bash
#!/bin/bash
# install-apex.sh

# Wait for database
sleep 60

# Connect and install APEX
cd /apex
sqlplus sys/${ORACLE_PWD}@//oracle-db:1521/ORCL as sysdba <<EOF
@apexins.sql SYSAUX SYSAUX TEMP /i/
@apex_rest_config.sql YourApexPassword123 YourApexPassword123
@apxchpwd.sql
-- When prompted, enter ADMIN password
exit;
EOF

echo "APEX installation completed"
```

Make it executable:

```bash
chmod +x scripts/install-apex.sh
```

### Step 6: Start the Stack

```bash
# Start all services
docker compose up -d

# Watch logs
docker compose logs -f

# Check service status
docker compose ps

# Access APEX
# Wait 5-10 minutes for initial setup
# Open browser: http://localhost:8080/ords
```

### Step 7: Verify Installation

```bash
# Check database
docker exec -it apex-oracle-db sqlplus sys/YourStrongPassword123@ORCL as sysdba

SQL> SELECT instance_name, status FROM v$instance;
SQL> SELECT comp_name, version, status FROM dba_registry WHERE comp_name LIKE '%APEX%';

# Check ORDS
curl http://localhost:8080/ords

# Should return ORDS homepage
```

---

## Kubernetes Installation (Minikube)

### Step 1: Install kubectl

```bash
# Download latest kubectl binary
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

# Validate binary (optional)
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check

# Install kubectl
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Verify installation
kubectl version --client

# Enable bash completion
echo 'source <(kubectl completion bash)' >> ~/.bashrc
echo 'alias k=kubectl' >> ~/.bashrc
echo 'complete -o default -F __start_kubectl k' >> ~/.bashrc
source ~/.bashrc
```

### Step 2: Install Minikube

```bash
# Download Minikube binary
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64

# Install Minikube
sudo install minikube-linux-amd64 /usr/local/bin/minikube

# Verify installation
minikube version

# Clean up download
rm minikube-linux-amd64
```

### Step 3: Install crictl (Container Runtime CLI)

```bash
# Download crictl
VERSION="v1.28.0"
wget https://github.com/kubernetes-sigs/cri-tools/releases/download/$VERSION/crictl-$VERSION-linux-amd64.tar.gz

# Extract and install
sudo tar zxvf crictl-$VERSION-linux-amd64.tar.gz -C /usr/local/bin
rm -f crictl-$VERSION-linux-amd64.tar.gz

# Verify installation
crictl --version
```

### Step 4: Start Minikube

```bash
# Start Minikube with Docker driver
minikube start \
  --driver=docker \
  --cpus=4 \
  --memory=8192 \
  --disk-size=50g \
  --kubernetes-version=v1.28.0 \
  --container-runtime=containerd \
  --addons=ingress,dashboard,metrics-server,storage-provisioner

# This will:
# - Download Kubernetes components (first time only)
# - Create a Kubernetes cluster
# - Configure kubectl context
# Takes 5-10 minutes

# Verify Minikube is running
minikube status

# Check cluster info
kubectl cluster-info

# View nodes
kubectl get nodes

# Enable addons
minikube addons enable ingress
minikube addons enable dashboard
minikube addons enable metrics-server
```

### Step 5: Configure Minikube

```bash
# Set default resource limits
kubectl config set-context --current --namespace=default

# View Minikube dashboard (optional)
minikube dashboard

# Get Minikube IP (for accessing services)
minikube ip

# Add Minikube IP to /etc/hosts for friendly DNS
echo "$(minikube ip) apex.local ords.local" | sudo tee -a /etc/hosts
```

### Step 6: Install Helm (Kubernetes Package Manager)

```bash
# Download and install Helm
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# Verify Helm installation
helm version

# Add common Helm repositories
helm repo add stable https://charts.helm.sh/stable
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
```

---

## APEX Deployment on Kubernetes

### Step 1: Create Namespace

```bash
# Create dedicated namespace for APEX
kubectl create namespace apex-prod

# Set as default namespace
kubectl config set-context --current --namespace=apex-prod
```

### Step 2: Create Kubernetes Manifests

Create `k8s/namespace.yaml`:

```yaml
apiVersion: v1
kind: Namespace
metadata:
  name: apex-prod
  labels:
    name: apex-prod
    environment: production
```

Create `k8s/persistent-volumes.yaml`:

```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: oracle-db-pv
  namespace: apex-prod
spec:
  capacity:
    storage: 50Gi
  accessModes:
    - ReadWriteOnce
  persistentVolumeReclaimPolicy: Retain
  storageClassName: standard
  hostPath:
    path: /mnt/data/oracle-db
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: oracle-db-pvc
  namespace: apex-prod
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 50Gi
  storageClassName: standard
---
apiVersion: v1
kind: PersistentVolume
metadata:
  name: ords-config-pv
  namespace: apex-prod
spec:
  capacity:
    storage: 5Gi
  accessModes:
    - ReadWriteOnce
  persistentVolumeReclaimPolicy: Retain
  storageClassName: standard
  hostPath:
    path: /mnt/data/ords-config
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: ords-config-pvc
  namespace: apex-prod
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 5Gi
  storageClassName: standard
```

Create `k8s/secrets.yaml`:

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: apex-db-secret
  namespace: apex-prod
type: Opaque
stringData:
  ORACLE_SID: ORCL
  ORACLE_PWD: YourStrongPassword123
  ORACLE_CHARACTERSET: AL32UTF8
---
apiVersion: v1
kind: Secret
metadata:
  name: ords-secret
  namespace: apex-prod
type: Opaque
stringData:
  ORACLE_HOST: oracle-db-service
  ORACLE_PORT: "1521"
  ORACLE_SERVICE: ORCL
  ORACLE_PWD: YourStrongPassword123
  ORDS_PWD: YourOrdsPassword123
  APEX_PUBLIC_USER_PWD: YourApexPassword123
```

Create `k8s/oracle-db-deployment.yaml`:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: oracle-db
  namespace: apex-prod
  labels:
    app: oracle-db
    tier: database
spec:
  replicas: 1
  selector:
    matchLabels:
      app: oracle-db
  template:
    metadata:
      labels:
        app: oracle-db
        tier: database
    spec:
      containers:
      - name: oracle-db
        image: oracle/database:19.3.0-ee
        ports:
        - containerPort: 1521
          name: db-port
        - containerPort: 5500
          name: em-port
        envFrom:
        - secretRef:
            name: apex-db-secret
        volumeMounts:
        - name: oracle-data
          mountPath: /opt/oracle/oradata
        resources:
          requests:
            memory: "4Gi"
            cpu: "2"
          limits:
            memory: "8Gi"
            cpu: "4"
        livenessProbe:
          exec:
            command:
            - /bin/sh
            - -c
            - echo "SELECT 1 FROM DUAL;" | sqlplus -S / as sysdba
          initialDelaySeconds: 120
          periodSeconds: 30
          timeoutSeconds: 10
        readinessProbe:
          exec:
            command:
            - /bin/sh
            - -c
            - echo "SELECT 1 FROM DUAL;" | sqlplus -S / as sysdba
          initialDelaySeconds: 60
          periodSeconds: 20
          timeoutSeconds: 10
      volumes:
      - name: oracle-data
        persistentVolumeClaim:
          claimName: oracle-db-pvc
---
apiVersion: v1
kind: Service
metadata:
  name: oracle-db-service
  namespace: apex-prod
  labels:
    app: oracle-db
spec:
  type: ClusterIP
  ports:
  - port: 1521
    targetPort: 1521
    protocol: TCP
    name: db-port
  - port: 5500
    targetPort: 5500
    protocol: TCP
    name: em-port
  selector:
    app: oracle-db
```

Create `k8s/ords-deployment.yaml`:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: ords
  namespace: apex-prod
  labels:
    app: ords
    tier: application
spec:
  replicas: 2
  selector:
    matchLabels:
      app: ords
  template:
    metadata:
      labels:
        app: ords
        tier: application
    spec:
      initContainers:
      - name: wait-for-db
        image: busybox:latest
        command: ['sh', '-c', 'until nc -z oracle-db-service 1521; do echo waiting for db; sleep 2; done;']
      containers:
      - name: ords
        image: container-registry.oracle.com/database/ords:latest
        ports:
        - containerPort: 8080
          name: http
        - containerPort: 8443
          name: https
        envFrom:
        - secretRef:
            name: ords-secret
        volumeMounts:
        - name: ords-config
          mountPath: /etc/ords/config
        resources:
          requests:
            memory: "2Gi"
            cpu: "1"
          limits:
            memory: "4Gi"
            cpu: "2"
        livenessProbe:
          httpGet:
            path: /ords
            port: 8080
          initialDelaySeconds: 60
          periodSeconds: 30
          timeoutSeconds: 10
        readinessProbe:
          httpGet:
            path: /ords
            port: 8080
          initialDelaySeconds: 30
          periodSeconds: 20
          timeoutSeconds: 10
      volumes:
      - name: ords-config
        persistentVolumeClaim:
          claimName: ords-config-pvc
---
apiVersion: v1
kind: Service
metadata:
  name: ords-service
  namespace: apex-prod
  labels:
    app: ords
spec:
  type: LoadBalancer
  ports:
  - port: 80
    targetPort: 8080
    protocol: TCP
    name: http
  - port: 443
    targetPort: 8443
    protocol: TCP
    name: https
  selector:
    app: ords
```

Create `k8s/ingress.yaml`:

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: apex-ingress
  namespace: apex-prod
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
    nginx.ingress.kubernetes.io/ssl-redirect: "false"
spec:
  ingressClassName: nginx
  rules:
  - host: apex.local
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: ords-service
            port:
              number: 80
  - host: ords.local
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: ords-service
            port:
              number: 80
```

### Step 3: Deploy to Kubernetes

```bash
# Create k8s directory
mkdir -p ~/apex-k8s/k8s
cd ~/apex-k8s

# Apply manifests in order
kubectl apply -f k8s/namespace.yaml
kubectl apply -f k8s/persistent-volumes.yaml
kubectl apply -f k8s/secrets.yaml
kubectl apply -f k8s/oracle-db-deployment.yaml

# Wait for database to be ready (5-10 minutes)
kubectl wait --for=condition=ready pod -l app=oracle-db --timeout=600s -n apex-prod

# Deploy ORDS
kubectl apply -f k8s/ords-deployment.yaml

# Wait for ORDS to be ready
kubectl wait --for=condition=ready pod -l app=ords --timeout=300s -n apex-prod

# Deploy Ingress
kubectl apply -f k8s/ingress.yaml

# Check deployment status
kubectl get all -n apex-prod

# View logs
kubectl logs -f deployment/oracle-db -n apex-prod
kubectl logs -f deployment/ords -n apex-prod
```

### Step 4: Access APEX

```bash
# Get Minikube service URL
minikube service ords-service -n apex-prod --url

# Or use port forwarding
kubectl port-forward service/ords-service 8080:80 -n apex-prod

# Access APEX in browser
# http://localhost:8080/ords
# or http://apex.local (if configured in /etc/hosts)

# Default credentials:
# Workspace: INTERNAL
# Username: ADMIN
# Password: <set during installation>
```

---

## Production Kubernetes Deployment

### Prerequisites

- Production Kubernetes cluster (EKS, AKS, GKE, or on-premises)
- kubectl configured with cluster access
- Helm 3 installed
- Persistent storage class available
- Load balancer configured
- SSL/TLS certificates

### Production Considerations

1. **High Availability**
   - Multiple ORDS replicas (3+ recommended)
   - Database replication (Oracle RAC or Data Guard)
   - Multi-zone deployment

2. **Security**
   - Network policies
   - Pod security policies
   - Encrypted secrets (Sealed Secrets, Vault)
   - HTTPS/TLS termination
   - Image scanning

3. **Monitoring**
   - Prometheus + Grafana
   - ELK Stack (Elasticsearch, Logstash, Kibana)
   - Application Performance Monitoring (APM)

4. **Backup & DR**
   - Automated database backups
   - APEX export automation
   - Disaster recovery plan

### Production Deployment Files

Will be similar to development but with:
- Resource limits adjusted for production
- Horizontal Pod Autoscaling (HPA)
- Network policies
- TLS certificates
- Production-grade storage
- Monitoring and logging

---

## CI/CD Pipeline Integration

### GitHub Actions Example

Create `.github/workflows/deploy-apex.yml`:

```yaml
name: Deploy APEX to Kubernetes

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  build-and-deploy:
    runs-on: ubuntu-latest
    
    steps:
    - name: Checkout code
      uses: actions/checkout@v3
    
    - name: Set up kubectl
      uses: azure/setup-kubectl@v3
      with:
        version: 'v1.28.0'
    
    - name: Configure kubectl
      run: |
        mkdir -p ~/.kube
        echo "${{ secrets.KUBE_CONFIG }}" | base64 -d > ~/.kube/config
    
    - name: Deploy to Kubernetes
      run: |
        kubectl apply -f k8s/ -n apex-prod
        kubectl rollout status deployment/ords -n apex-prod
    
    - name: Export APEX application
      run: |
        kubectl exec deployment/ords -n apex-prod -- \
          /apex-export-script.sh
    
    - name: Run tests
      run: |
        kubectl run apex-test --image=apex-test:latest \
          --restart=Never -n apex-prod
        kubectl wait --for=condition=complete job/apex-test -n apex-prod
```

---

## Monitoring and Maintenance

### Install Prometheus & Grafana

```bash
# Add Helm repositories
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

# Install Prometheus
helm install prometheus prometheus-community/kube-prometheus-stack \
  --namespace monitoring --create-namespace

# Access Grafana
kubectl port-forward svc/prometheus-grafana 3000:80 -n monitoring

# Default credentials: admin/prom-operator
```

### Maintenance Commands

```bash
# Scale ORDS replicas
kubectl scale deployment ords --replicas=5 -n apex-prod

# Rolling update
kubectl set image deployment/ords ords=container-registry.oracle.com/database/ords:24.2 -n apex-prod

# Backup database
kubectl exec -it pod/oracle-db-xxxx -n apex-prod -- /backup-script.sh

# View resource usage
kubectl top nodes
kubectl top pods -n apex-prod

# Check logs
kubectl logs -f deployment/ords -n apex-prod --tail=100
```

---

## Troubleshooting

### Common Issues

**1. Pods not starting**
```bash
kubectl describe pod <pod-name> -n apex-prod
kubectl logs <pod-name> -n apex-prod
```

**2. Database connection issues**
```bash
kubectl exec -it deployment/ords -n apex-prod -- bash
telnet oracle-db-service 1521
```

**3. Storage issues**
```bash
kubectl get pv,pvc -n apex-prod
kubectl describe pvc oracle-db-pvc -n apex-prod
```

**4. Networking issues**
```bash
kubectl get svc,endpoints -n apex-prod
kubectl exec -it deployment/ords -n apex-prod -- nslookup oracle-db-service
```

**5. Resource constraints**
```bash
kubectl top nodes
kubectl describe node <node-name>
```

### Useful Commands

```bash
# Get all resources
kubectl get all -n apex-prod

# Restart deployment
kubectl rollout restart deployment/ords -n apex-prod

# Clean up resources
kubectl delete namespace apex-prod

# Stop Minikube
minikube stop

# Delete Minikube cluster
minikube delete

# View Minikube logs
minikube logs
```

---

## Summary

You now have:

✅ Complete Docker installation on Ubuntu 24.04
✅ Docker Compose setup for APEX development
✅ Minikube installation for local Kubernetes
✅ Full Kubernetes deployment manifests for APEX
✅ Production deployment guidelines
✅ CI/CD pipeline examples
✅ Monitoring setup
✅ Troubleshooting guide

Next steps:
1. Test local Docker setup
2. Deploy to Minikube
3. Set up monitoring
4. Configure CI/CD
5. Plan production deployment

For production deployments, consult with your DevOps team and consider Oracle's official container images and Kubernetes operators.
