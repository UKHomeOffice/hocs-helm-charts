{{- define "hocs-case-migrator.envs" }}
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
- name: CASE_CREATOR_CASE_SERVICE
  value: '{{ tpl .Values.app.env.caseworkService . }}'
- name: CASE_CREATOR_WORKFLOW_SERVICE
  value: '{{ tpl .Values.app.env.workflowService . }}'
- name: CASE_CREATOR_DOCUMENT_SERVICE
  value: '{{ tpl .Values.app.env.docsService . }}'
- name: CASE_CREATOR_INFO_SERVICE
  value: '{{ tpl .Values.app.env.infoService . }}'
- name: CASE_CREATOR_MIGRATION_PARENT_TOPIC_UUID
  valueFrom:
    secretKeyRef:
      name: {{ .Release.Namespace }}-case-migrator-config
      key: parent_topic_uuid
- name: AWS_SQS_IGNORE_MESSAGES
  value: '{{ tpl .Values.app.env.ignoreMessages . }}'
- name: AWS_SQS_QUEUE_ACCOUNT_ACCESS_KEY
  valueFrom:
    secretKeyRef:
      name: {{ .Release.Namespace }}-case-migrator-sqs
      key: access_key_id
- name: AWS_SQS_QUEUE_ACCOUNT_SECRET_KEY
  valueFrom:
    secretKeyRef:
      name: {{ .Release.Namespace }}-case-migrator-sqs
      key: secret_access_key
- name: AWS_SQS_QUEUE_URL
  valueFrom:
    secretKeyRef:
      name: {{ .Release.Namespace }}-case-migrator-sqs
      key: sqs_url
- name: AWS_S3_UNTRUSTED_ACCOUNT_ACCESS_KEY
  valueFrom:
    secretKeyRef:
      name: {{ .Release.Namespace }}-untrusted-s3
      key: access_key_id
- name: AWS_S3_UNTRUSTED_ACCOUNT_SECRET_KEY
  valueFrom:
    secretKeyRef:
      name: {{ .Release.Namespace }}-untrusted-s3
      key: secret_access_key
- name: AWS_S3_UNTRUSTED_BUCKET_NAME
  valueFrom:
    secretKeyRef:
      name: {{ .Release.Namespace }}-untrusted-s3
      key: bucket_name
- name: AWS_S3_UNTRUSTED_ACCOUNT_BUCKET_KMS_KEY
  valueFrom:
    secretKeyRef:
      name: {{ .Release.Namespace }}-untrusted-s3
      key: kms_key_id
- name: CASE_CREATOR_IDENTITY_GROUP
  valueFrom:
    secretKeyRef:
      name: hocs-case-migrator-identity
      key: group
- name: CASE_CREATOR_IDENTITY_USER
  valueFrom:
    secretKeyRef:
      name: hocs-case-migrator-identity
      key: user
- name: CASE_CREATOR_IDENTITY_TEAM
  valueFrom:
    secretKeyRef:
      name: hocs-case-migrator-identity
      key: team
- name: DB_HOST
  valueFrom:
    secretKeyRef:
      name: {{ .Release.Namespace }}-case-migrator-rds
      key: host
- name: DB_PORT
  valueFrom:
    secretKeyRef:
      name: {{ .Release.Namespace }}-case-migrator-rds
      key: port
- name: DB_NAME
  valueFrom:
    secretKeyRef:
      name: {{ .Release.Namespace }}-case-migrator-rds
      key: name
- name: DB_SCHEMA_NAME
  valueFrom:
    secretKeyRef:
      name: {{ .Release.Namespace }}-case-migrator-rds
      key: schema_name
- name: DB_USERNAME
  valueFrom:
    secretKeyRef:
      name: {{ .Release.Namespace }}-case-migrator-rds
      key: user_name
- name: DB_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ .Release.Namespace }}-case-migrator-rds
      key: password
{{- end -}}
