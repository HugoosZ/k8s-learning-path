# k8s-learning-path
## Dificultades:
- Aprender sobre helm charts. Gracias a ```helm create "nombre-app"```pude seguir las plantillas.
- Lanzar Kubernetes en una VM. En sí, las configuraciones asociadas a esto como el host.
- Enrutamiento de la api y la creacion de un middleware para recortar las rutas para que las reconozca nginx
- Como trabajar una contraseña de una base de datos como postgre en GCP.
    - Crear un secret de contraseña:
        - Primero hay que crear un namespace. En este caso "db".
        - Luego se asigna la contraseña.
  ```bash
  kubectl create secret generic db-pass-secret \
    --from-literal=password=clavesupersecreta \
    -n db
    ```
    - Como alternativa segura, se puede usar google secret manager para que se descarguen las contraseñas de ahí o un cifrado asimetrico (Sealed Secrets).
- Aprender sobre prometheus y victoria metrics. 
- Configuracion de sidecar para el front. backend no necesita un sidecar porque está montado en python. Se puede configurar python para que hable "Prometheus-ish" nativamente.
### Terraform
1. Instalación:
- brew install --cask google-cloud-sdk
- brew install terraform
2. Autenticacion:
- gcloud auth application-default login
3. Ejecucion:
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
- ```sudo kubectl port-forward svc/argocd-server -n argocd 8080:443 --address 0.0.0.0```
- ```sudo kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo```

### Prometheus
1. Instalacion 

- Primero se instala helm mediante ```curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3```, se le da permisos mediante ```chmod 700 get_helm.sh``` y luego se ejecuta el instalador gracias a: ```sudo ./get_helm.sh```.
- Luego se añade el repo mediante: ```helm repo add prometheus-community https://prometheus-community.github.io/helm-charts```
- Se crea el ns "monitoring"" y se instala el stack mediante ```helm install prometheus prometheus-community/kube-prometheus-stack -n monitoring```
2. Obtencion de contraseña:
- ```sudo   kubectl --namespace monitoring get secrets prometheus-grafana -o jsonpath="{.data.admin-password}" | base64 -d ; echo```
