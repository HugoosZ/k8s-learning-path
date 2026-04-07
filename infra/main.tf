provider "google" {
    project = var.project_id
    region  = var.region
}

# 1. Crear la Red
resource "google_compute_network" "vpc_network" {
    name = "k8s-network"
}

# 2. Abrir los puertos (Firewall)
resource "google_compute_firewall" "allow-k8s" {
    name    = "allow-k8s-and-apps"
    network = google_compute_network.vpc_network.name

    allow {
        protocol = "tcp"
        ports    = ["22", "80", "443", "6443", "8080", "3000"] 
        # 22:SSH, 80/443:App, 6443:K8s API, 8080:ArgoCD, 3000:Grafana
    }
    source_ranges = ["0.0.0.0/0"]
}
# 3. IP estática para la VM
resource "google_compute_address" "static_ip" { 
    name = "ipv4-estatica-k8s"
}

# 4. Crear la VM
resource "google_compute_instance" "k8s_node" {
    name         = "devops-lab-vm"
    machine_type = var.machine_type # 2 vCPU y 8GB RAM
    zone         = var.zone

    boot_disk {
        initialize_params {
            image = "ubuntu-os-cloud/ubuntu-2204-lts"
            size  = var.disk_size # 100GB
        }
    }
    metadata_startup_script = <<-EOT
        #!/bin/bash
        curl -sfL https://get.k3s.io | sh -

        # 2. Instalar Docker
        apt-get update
        apt-get install -y docker.io
        systemctl start docker
        systemctl enable docker
        
        # Darle permisos a Hugo para Docker y K3s
        usermod -aG docker hugo

        # Esperar a que el archivo de configuración exista antes de continuar
        until [ -f /etc/rancher/k3s/k3s.yaml ]; do
          echo "Esperando a K3s..."
          sleep 5
        done
        
        # Ajuste de permisos para que el comando kubectl funcione sin sudo
        mkdir -p /home/hugo/.kube
        cp /etc/rancher/k3s/k3s.yaml /home/hugo/.kube/config
        chown -R hugo:hugo /home/hugo/.kube
    EOT

    network_interface {
        network = google_compute_network.vpc_network.name
        access_config {
            nat_ip = google_compute_address.static_ip.address # Asignar la IP estática a la VM
        }
    }
}