{{- define "hocs-toolbox.envs" }}
- name: KUBE_NAMESPACE
  value: {{ $.Release.Namespace }}
- name: S3_BUCKET_NAME
  valueFrom:
    secretKeyRef:
      name: {{ $.Release.Namespace }}-trusted-s3
      key: bucket_name
- name: S3_ACCESS_KEY
  valueFrom:
    secretKeyRef:
      name: {{ $.Release.Namespace }}-trusted-s3
      key: access_key_id
- name: S3_SECRET_ACCESS_KEY
  valueFrom:
    secretKeyRef:
      name: {{ $.Release.Namespace }}-trusted-s3
      key: secret_access_key
- name: S3_HTTPS_PROXY
  value: hocs-outbound-proxy.{{ $.Release.Namespace }}.svc.cluster.local:31290
{{- range .Values.app.env.databases }}
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
