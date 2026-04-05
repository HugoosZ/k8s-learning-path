output "vm_public_ip" {
    description = "La IP pública de tu servidor para entrar por el navegador"
    value       = google_compute_address.static_ip.address
}

output "ssh_command" {
    description = "Copia y pega esto para entrar a tu VM"
    value       = "gcloud compute ssh ${google_compute_instance.k8s_node.name} --zone ${google_compute_instance.k8s_node.zone}"
}

output "argocd_url" {
    description = "URL local para el túnel de ArgoCD"
    value       = "https://localhost:8080"
}

output "instrucciones_acceso" {
  value = <<EOF

    1. CONEXIÓN SSH Y CREACION DE ARGOCD:
        Ejecuta: gcloud compute ssh ${google_compute_instance.k8s_node.name} --zone ${google_compute_instance.k8s_node.zone}
        En la consola de gcp: sudo kubectl create namespace argocd
        sudo kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml


    2. TÚNEL ARGOCD PARA ACCESO LOCAL EN OTRA TERMINAL:
        Ejecuta: gcloud compute ssh ${google_compute_instance.k8s_node.name} --zone ${google_compute_instance.k8s_node.zone} -- -L 8080:localhost:8080
        En la consola de gcp: sudo kubectl port-forward svc/argocd-server -n argocd 8080:443 --address 0.0.0.0

    4. ABRIR EN NAVEGADOR:
        URL: https://localhost:8080
        User: admin
        Pass: sudo sudo kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
    EOF
}