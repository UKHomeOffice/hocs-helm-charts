{{- define "hocs-workflow.envs" }}
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
- name: HOCS_CASE_SERVICE
  value: '{{ tpl .Values.app.env.caseworkService . }}'
- name: HOCS_INFO_SERVICE
  value: '{{ tpl .Values.app.env.infoService . }}'
- name: HOCS_DOCUMENT_SERVICE
  value: '{{ tpl .Values.app.env.docsService . }}'
- name: DB_HOST
  valueFrom:
    secretKeyRef:
      name: {{ .Release.Namespace }}-workflow-rds
      key: host
- name: DB_PORT
  valueFrom:
    secretKeyRef:
      name: {{ .Release.Namespace }}-workflow-rds
      key: port
- name: DB_NAME
  valueFrom:
    secretKeyRef:
      name: {{ .Release.Namespace }}-workflow-rds
      key: name
- name: DB_SCHEMA_NAME
  valueFrom:
    secretKeyRef:
      name: {{ .Release.Namespace }}-workflow-rds
      key: schema_name
- name: DB_USERNAME
  valueFrom:
    secretKeyRef:
      name: {{ .Release.Namespace }}-workflow-rds
      key: user_name
- name: DB_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ .Release.Namespace }}-workflow-rds
      key: password
- name: HOCS_SCREENS_ADDITIONALFOLDERS
  value: '{{ tpl .Values.app.env.hocsScreensAdditionalFolders . }}'
- name: AWS_SNS_AUDIT_SEARCH_TOPIC_NAME
  value: {{ .Release.Namespace }}-sns
- name: AWS_SNS_AUDIT_SEARCH_ACCOUNT_ACCESS_KEY
  valueFrom:
    secretKeyRef:
      name: {{ .Release.Namespace }}-audit-sqs
      key: access_key_id
- name: AWS_SNS_AUDIT_SEARCH_ACCOUNT_SECRET_KEY
  valueFrom:
    secretKeyRef:
      name: {{ .Release.Namespace }}-audit-sqs
      key: secret_access_key
- name: AWS_SNS_AUDIT_SEARCH_ACCOUNT_ID
  valueFrom:
    configMapKeyRef:
      name: hocs-queue-config
      key: AWS_ACCOUNT_ID
{{- end -}}
