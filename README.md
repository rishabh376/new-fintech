# Fintech DevOps App on OpenStack

This project provisions infrastructure on OpenStack using Terraform, deploys a Linux VM, and runs a containerized fintech application on Kubernetes.

---

## Prerequisites

- OpenStack account and API credentials (`os_username`, `os_password`, `os_auth_url`, `os_tenant_name`, `os_region`)
- [Terraform](https://developer.hashicorp.com/terraform/downloads)
- [kubectl](https://kubernetes.io/docs/tasks/tools/)
- SSH key pair for VM access
- Docker (for building/pushing images)
- Access to a container registry (e.g., Docker Hub)

---

## 1. Clone the Repository

```sh
git clone https://github.com/your-org/fintech-devops-app.git
cd fintech-devops-app
```

---

## 2. Configure Terraform Variables

Edit `cloud/terraform/terraform.tfvars` and set your OpenStack credentials and SSH public key:

```hcl
os_username          = "your-openstack-username"
os_password          = "your-openstack-password"
os_auth_url          = "https://your-openstack-auth-url"
os_tenant_name       = "your-tenant-name"
os_region            = "your-region"
admin_ssh_public_key = "ssh-rsa AAAA...your-public-key..."
image_name           = "Ubuntu 18.04"
flavor_name          = "m1.small"
subnet_cidr          = "10.0.1.0/24"
gateway_ip           = "10.0.1.1"
```

---

## 3. Provision Infrastructure with Terraform

```sh
cd cloud/terraform
terraform init
terraform apply
```

- This will create a network, subnet, security group, and a Linux VM.
- Outputs will show the VM name and admin username.

---

## 4. SSH into the VM

Get the VM's floating/public IP from your OpenStack dashboard or via CLI, then:

```sh
ssh <admin_username>@<vm_public_ip>
```

---

## 5. Install Kubernetes on the VM

On the VM, install Docker and Kubernetes (kubeadm):

```sh
# On Ubuntu 18.04+
sudo apt-get update
sudo apt-get install -y docker.io
sudo systemctl enable docker
sudo systemctl start docker

# Install kubeadm, kubelet, kubectl
sudo apt-get install -y apt-transport-https ca-certificates curl
sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

# Initialize Kubernetes (single node)
sudo kubeadm init --pod-network-cidr=10.244.0.0/16

# Set up kubectl for your user
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Install a pod network (e.g., Flannel)
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
```

---

## 6. Build and Push Docker Image

Build your application Docker image and push it to a registry:

```sh
docker build -t your-docker-repo/fintech-app:latest .
docker push your-docker-repo/fintech-app:latest
```

Update `k8s/deployment.yaml` with your image name.

---

## 7. Deploy the Application to Kubernetes

```sh
kubectl apply -f k8s/deployment.yaml
kubectl expose deployment fintech-app --type=NodePort --port=5000
kubectl get services
```

---

## 8. Access the Application

Find the NodePort from `kubectl get services` and access your app at:

```
http://<vm_public_ip>:<node_port>
```

---

## 9. Clean Up

To destroy all resources created by Terraform:

```sh
cd cloud/terraform
terraform destroy
```

---

## Troubleshooting

- Ensure your OpenStack security group allows inbound SSH (22), HTTP (80), and HTTPS (443).
- If you encounter issues with Kubernetes, check pod logs:
  ```sh
  kubectl get pods
  kubectl logs <pod-name>
  ```

---

## License

MIT