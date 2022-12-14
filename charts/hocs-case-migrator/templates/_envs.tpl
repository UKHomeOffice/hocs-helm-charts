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
- name: MESSAGE_IGNORED_TYPES
  value: '{{ tpl .Values.app.env.ignoredTypes . }}'
- name: CASE_CREATOR_MODE
  value: 'migration'
- name: AWS_SQS_CASE_CREATOR_ACCOUNT_ACCESS_KEY
  valueFrom:
    secretKeyRef:
      name: {{ .Release.Namespace }}-case-migrator-sqs
      key: access_key_id
- name: AWS_SQS_CASE_CREATOR_ACCOUNT_SECRET_KEY
  valueFrom:
    secretKeyRef:
      name: {{ .Release.Namespace }}-case-migrator-sqs
      key: secret_access_key
- name: AWS_SQS_CASE_MIGRATOR_URL
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
- name: CASE_CREATOR_IDENTITIES_COMPLAINTS_UKVI_GROUP
  valueFrom:
    secretKeyRef:
      name: hocs-case-creator-identities
      key: complaint_ukvi_group
- name: CASE_CREATOR_IDENTITIES_COMPLAINTS_UKVI_USER
  valueFrom:
    secretKeyRef:
      name: hocs-case-creator-identities
      key: complaint_ukvi_user
- name: CASE_CREATOR_IDENTITIES_COMPLAINTS_UKVI_TEAM
  valueFrom:
    secretKeyRef:
      name: hocs-case-creator-identities
      key: complaint_ukvi_team
- name: CASE_CREATOR_IDENTITIES_MIGRATION_USER
  valueFrom:
    secretKeyRef:
      name: hocs-case-migrator-identities
      key: migration_user
{{- end -}}
