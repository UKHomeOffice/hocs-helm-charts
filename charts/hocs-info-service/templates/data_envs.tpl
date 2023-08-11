{{- define "hocs-info-service-data.envs" }}
- name: FLYWAY_URL
  valueFrom:
    secretKeyRef:
      name: {{ .Release.Namespace }}-info-rds
      key: jdbc_url
- name: FLYWAY_USER
  valueFrom:
    secretKeyRef:
      name: {{ .Release.Namespace }}-info-rds
      key: user_name
- name: FLYWAY_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ .Release.Namespace }}-info-rds
      key: password
- name: REDGATE_DISABLE_TELEMETRY
  value: "true"
{{- end -}}
