# seto-project

This project implements a CI/CD pipeline using Jenkins, Docker, AWS ECR,AWS EKS.

Flow:
1. Code pushed to GitHub
2. Jenkins pulls code
3. Docker image is built
4. Image pushed to Amazon ECR
5. Deployment to EKS prepared
