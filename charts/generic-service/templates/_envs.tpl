{{- define "deployment.envs" }}
{{/* a list of Deployment environment values
- name: PORT
  value: {{ include "hocs-app.port" . }}
- name: DB_HOST
  valueFrom:
    secretKeyRef:
      name: {{ .Release.Namespace }}-casework-rds
      key: host
*/}}
{{- end -}}
