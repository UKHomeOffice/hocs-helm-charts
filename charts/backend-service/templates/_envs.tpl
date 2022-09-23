{{- define "deployment.envs" }}
{{/* a list of Deployment environment values
- name: SERVER_PORT
  value: {{ include "hocs-app.port" . }}
- name: SPRING_PROFILES_ACTIVE
  value: 'sns, sqs'
- name: DB_HOST
  valueFrom:
    secretKeyRef:
      name: {{ .Release.Namespace }}-casework-rds
      key: host
*/}}
{{- end -}}
