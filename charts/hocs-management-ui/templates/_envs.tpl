{{- define "hocs-management-ui.envs" }}
- name: PORT
  value: '{{ include "hocs-app.port" . }}'
- name: REACT_APP_HOCS_INFO_SERVICE
  value: '{{ tpl .Values.app.env.infoService . }}'
- name: NODE_ENV
  value: 'production'
- name: USE_CLIENTSIDE
  value: '{{ .Values.app.env.clientside}}'
- name: MAX_UPLOAD_SIZE
  value: '{{ .Values.app.env.maxFilesize }}'
- name: ALLOWED_FILE_EXTENSIONS
  value: '{{ .Values.app.env.supportedTypes }}'
- name: S3_ACCESS_KEY
  valueFrom:
    secretKeyRef:
      name: {{ .Release.Namespace }}-untrusted-s3
      key: access_key_id
- name: S3_SECRET_ACCESS_KEY
  valueFrom:
    secretKeyRef:
      name: {{ .Release.Namespace }}-untrusted-s3
      key: secret_access_key
- name: S3_REGION
  value: 'eu-west-2'
- name: S3_BUCKET
  valueFrom:
    secretKeyRef:
      name: {{ .Release.Namespace }}-untrusted-s3
      key: bucket_name
- name: S3_SSE_KEY
  valueFrom:
    secretKeyRef:
      name: {{ .Release.Namespace }}-untrusted-s3
      key: kms_key_id
- name: TRUSTED_S3_ACCESS_KEY
  valueFrom:
    secretKeyRef:
      name: {{ .Release.Namespace }}-trusted-s3
      key: access_key_id
- name: TRUSTED_S3_SECRET_ACCESS_KEY
  valueFrom:
    secretKeyRef:
      name: {{ .Release.Namespace }}-trusted-s3
      key: secret_access_key
- name: TRUSTESD_S3_REGION
  value: 'eu-west-2'
- name: TRUSTED_S3_BUCKET
  valueFrom:
    secretKeyRef:
      name: {{ .Release.Namespace }}-trusted-s3
      key: bucket_name
- name: WORKFLOW_SERVICE
  value: '{{ tpl .Values.app.env.workflowService . }}'
- name: CASEWORK_SERVICE
  value: '{{ tpl .Values.app.env.caseworkService . }}'
- name: DOCUMENT_SERVICE
  value: '{{ tpl .Values.app.env.docsService . }}'
- name: INFO_SERVICE
  value: '{{ tpl .Values.app.env.infoService . }}'
- name: OUTBOUND_PROXY
  value: '{{ tpl .Values.app.env.outboundProxy . }}'
- name: ENCRYPTION_KEY
  valueFrom:
    secretKeyRef:
      name: hocs-frontend
      key: encryption_key
- name: DEFAULT_TIMEOUT_SECONDS
  value: '300'
- name: COUNTDOWN_FOR_SECONDS
  value: '60'
{{- end -}}
