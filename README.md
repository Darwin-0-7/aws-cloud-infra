# 🔥 Automated AWS EKS Infrastructure & CI/CD Pipeline with Observability

## 📌 Project Overview
This project demonstrates a fully automated, production-ready Cloud & DevOps workflow. It provisions scalable cloud infrastructure on AWS, automates the application deployment lifecycle via a CI/CD pipeline, and implements comprehensive monitoring and observability. 

## 🛠️ Tech Stack Used
* **Cloud Provider:** AWS (Elastic Kubernetes Service - EKS, ALB, EC2)
* **Infrastructure as Code (IaC):** Terraform
* **Containerization:** Docker
* **CI/CD Automation:** GitHub Actions
* **Container Orchestration:** Kubernetes (kubectl)
* **Package Management:** Helm
* **Monitoring & Observability:** Prometheus & Grafana

## 🏗️ Architecture & Workflow
1. **Infrastructure Provisioning:** 
   * Used **Terraform** to dynamically provision a highly available AWS EKS Cluster, Node Groups, and necessary IAM/Security Group configurations.
2. **Continuous Integration (CI):** 
   * Configured **GitHub Actions** to automatically build the application into a Docker Image and securely push it to DockerHub upon new code commits.
3. **Continuous Deployment (CD):** 
   * The pipeline automatically authenticates with AWS, updates the kubeconfig, and deploys the containerized application to the EKS cluster using Kubernetes manifests (`deployment.yaml`).
4. **Observability Setup:** 
   * Utilized **Helm** to deploy the `kube-prometheus-stack` into a dedicated monitoring namespace.
   * Configured a LoadBalancer service to expose the **Grafana Dashboard** for real-time tracking of Cluster CPU, Memory, and Pod health metrics.

## 📸 Proof of Work (Screenshots)

* **CI/CD Pipeline Success:** 
  <img width="959" height="506" alt="Screenshot 2026-10-10 122058" src="https://github.com/user-attachments/assets/ccc2cf8d-c502-4339-a455-a4dfd311f1e1" />
  
* **Grafana Live Monitoring Dashboard:** 
  <img width="959" height="509" alt="Screenshot 2026-10-10 120404" src="https://github.com/user-attachments/assets/d14950f9-9a1f-42c5-a818-c5079d926af7" />

## 💡 Business Value Delivered
* Eliminated manual provisioning errors by adopting a 100% Infrastructure-as-Code approach.
* Achieved zero-touch deployments from code commit to live production.
* Enhanced system reliability through real-time resource monitoring and visualization.

---
*Built with ❤️ to demonstrate modern SRE and Cloud Operations practices.*
