{{/* Construye el nombre completo para Traefik: namespace-app-strip-prefix@kubernetescrd */}}
{{- define "backend.middlewareName" -}}
{{- printf "%s-%s-strip-prefix@kubernetescrd" .Release.Namespace .Values.appName -}}
{{- end -}}