{{- define "hocs-toolbox.envs" }}
- name: KUBE_NAMESPACE
  value: {{ $.Release.Namespace }}
{{- range .Values.app.env.databases }}
- name: {{. | title | replace "-" "_" | upper }}_QUEUE
  valueFrom:
    secretKeyRef:
      name: {{ $.Release.Namespace }}-{{. | title | lower }}-sqs
      key: sqs_queue_url
      optional: true
- name: {{. | title | replace "-" "_" | upper }}_DB_HOST
  valueFrom:
    secretKeyRef:
      name: {{ $.Release.Namespace }}-{{. | title | lower }}-rds
      key: host
      optional: true
- name: {{. | title | replace "-" "_" | upper }}_DB_NAME
  valueFrom:
    secretKeyRef:
      name: {{ $.Release.Namespace }}-{{. | title | lower }}-rds
      key: name
      optional: true
- name: {{. | title | replace "-" "_" | upper }}_DB_RO_USERNAME
  valueFrom:
    secretKeyRef:
      name: {{ $.Release.Namespace }}-{{. | title | lower }}-rds
      key: read_only_user_name
      optional: true
- name: {{. | title | replace "-" "_" | upper }}_DB_RO_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ $.Release.Namespace }}-{{. | title | lower }}-rds
      key: read_only_password
      optional: true
- name: {{. | title | replace "-" "_" | upper }}_DB_USERNAME
  valueFrom:
    secretKeyRef:
      name: {{ $.Release.Namespace }}-{{. | title | lower }}-rds
      key: user_name
      optional: true
- name: {{. | title | replace "-" "_" | upper }}_DB_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ $.Release.Namespace }}-{{. | title | lower }}-rds
      key: password
      optional: true
{{- end -}}
{{- end -}}
