{{- define "keycloak.args" }}
- --config=/etc/secrets/data.yml
- --discovery-url={{ .Values.keycloak.realm }}
- --openid-provider-proxy=http://hocs-outbound-proxy.{{ .Release.Namespace }}.svc.cluster.local:31290
- --enable-logging=true
- --enable-json-logging=true
- --upstream-url=http://127.0.0.1:{{ include "hocs-app.port" . }}
- --upstream-response-header-timeout={{ .Values.keycloak.timeout }}s
- --upstream-expect-continue-timeout={{ .Values.keycloak.timeout }}s
- --upstream-keepalive-timeout={{ .Values.keycloak.timeout }}s
- --server-read-timeout={{ .Values.keycloak.timeout }}s
- --server-write-timeout={{ .Values.keycloak.timeout }}s
- --resources=uri=/health|white-listed=true
- --resources=uri=/public/*|white-listed=true
- --resources=uri=/*
- --secure-cookie=true
- --http-only-cookie=true
- --enable-refresh-tokens=true
- --encryption-key=$(ENCRYPTION_KEY)
{{- if not .Values.ingress.internal.enabled }}
{{/* in production there's only one ingress which means
 we can hardcode things for security: */}}
- --redirection-url=https://{{ .Values.keycloak.domain }}
- --cookie-domain={{ .Values.keycloak.domain }}
{{- end }}
{{- end -}}
