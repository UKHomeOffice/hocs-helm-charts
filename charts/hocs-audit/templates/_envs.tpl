{{- define "hocs-audit.envs" }}
- name: JAVA_OPTS
  value: '{{ tpl .Values.app.env.javaOpts . }}'
{{- if not .Values.proxy.enabled }}
- name: SERVER_SSL_KEY_STORE_TYPE
  value: 'PKCS12'
- name: SERVER_SSL_KEY_STORE_PASSWORD
  value: 'changeit'
- name: SERVER_SSL_KEY_STORE
  value: 'file:/etc/keystore/keystore.jks'
- name: SERVER_COMPRESSION_ENABLED
  value: 'true'
- name: SERVER_SSL_ENABLED
  value: 'true'
{{- end }}
- name: SERVER_PORT
  value: '{{ include "hocs-app.port" . }}'
- name: SPRING_PROFILES_ACTIVE
  value: '{{ tpl .Values.app.env.springProfiles . }}'
- name: DB_HOST
  valueFrom:
    secretKeyRef:
      name: {{ .Release.Namespace }}-audit-rds
      key: host
- name: DB_PORT
  valueFrom:
    secretKeyRef:
      name: {{ .Release.Namespace }}-audit-rds
      key: port
- name: DB_NAME
  valueFrom:
    secretKeyRef:
      name: {{ .Release.Namespace }}-audit-rds
      key: name
- name: DB_SCHEMA_NAME
  valueFrom:
    secretKeyRef:
      name: {{ .Release.Namespace }}-audit-rds
      key: schema_name
- name: DB_USERNAME
  valueFrom:
    secretKeyRef:
      name: {{ .Release.Namespace }}-audit-rds
      key: user_name
- name: DB_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ .Release.Namespace }}-audit-rds
      key: password
- name: DB_QUERY_TIMEOUT
  value: '0'
- name: AUDIT_QUEUE_NAME
  value: {{ .Release.Namespace }}-audit-sqs
- name: AWS_SQS_AUDIT_URL
  valueFrom:
    secretKeyRef:
      name: {{ .Release.Namespace }}-audit-sqs
      key: sqs_queue_url
- name: AWS_SQS_ACCESS_KEY
  valueFrom:
    secretKeyRef:
      name: {{ .Release.Namespace }}-audit-sqs
      key: access_key_id
- name: AWS_SQS_SECRET_KEY
  valueFrom:
    secretKeyRef:
      name: {{ .Release.Namespace }}-audit-sqs
      key: secret_access_key
{{- end -}}
