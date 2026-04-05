# k8s-learning-path
## Dificultades:
- Aprender sobre helm charts. Gracias a ```helm create "nombre-app"```pude seguir las plantillas.
### Terraform
1. Ejecucion:
- terraform init
- terraform plan
- terraform validate (opcional)
- terraform apply

### ArgoCD
1. Creacion argoCD
- kubectl create namespace argocd
- sudo kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
2. Port-forward
- gcloud compute ssh devops-lab-vm --zone southamerica-west1-a -- -L 8080:localhost:8080
- sudo kubectl port-forward svc/argocd-server -n argocd 8080:443 --address 0.0.0.0
- sudo sudo kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo

