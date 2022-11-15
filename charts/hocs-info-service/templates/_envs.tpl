{{- define "hocs-info-service.envs" }}
- name: JAVA_OPTS
  value: '{{ tpl .Values.app.env.javaOpts . }}'
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
- name: SERVER_PORT
  value: '{{ include "hocs-app.port" . }}'
- name: SPRING_PROFILES_ACTIVE
  value: '{{ tpl .Values.app.env.springProfiles . }}'
- name: HOCS_CASE_SERVICE
  value: '{{ tpl .Values.app.env.caseService . }}'
- name: HOCS_DOCUMENT_SERVICE
  value: '{{ tpl .Values.app.env.docsService . }}'
- name: HOCS_BASICAUTH
  valueFrom:
    secretKeyRef:
      name: ui-casework-creds
      key: plaintext
- name: DB_HOST
  valueFrom:
    secretKeyRef:
      name: {{ .Release.Namespace }}-info-rds
      key: host
- name: DB_PORT
  valueFrom:
    secretKeyRef:
      name: {{ .Release.Namespace }}-info-rds
      key: port
- name: DB_NAME
  valueFrom:
    secretKeyRef:
      name: {{ .Release.Namespace }}-info-rds
      key: name
- name: DB_SCHEMA_NAME
  valueFrom:
    secretKeyRef:
      name: {{ .Release.Namespace }}-info-rds
      key: schema_name
- name: DB_USERNAME
  valueFrom:
    secretKeyRef:
      name: {{ .Release.Namespace }}-info-rds
      key: user_name
- name: DB_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ .Release.Namespace }}-info-rds
      key: password
- name: KEYCLOAK_SERVER_ROOT
  valueFrom:
    secretKeyRef:
      name: {{ .Release.Namespace }}-keycloak
      key: keycloak_server_root
- name: KEYCLOAK_REALM
  valueFrom:
    secretKeyRef:
      name: {{ .Release.Namespace }}-keycloak
      key: keycloak_realm
- name: KEYCLOAK_USERNAME
  valueFrom:
    secretKeyRef:
      name: {{ .Release.Namespace }}-keycloak
      key: keycloak_username
- name: KEYCLOAK_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ .Release.Namespace }}-keycloak
      key: keycloak_password
- name: KEYCLOAK_CLIENT_ID
  valueFrom:
    secretKeyRef:
      name: {{ .Release.Namespace }}-keycloak
      key: keycloak_client_id
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
- name: AUDITING_DEPLOYMENT_NAME
  valueFrom:
    fieldRef:
      fieldPath: metadata.name
- name: AUDITING_DEPLOYMENT_NAMESPACE
  valueFrom:
    fieldRef:
      fieldPath: metadata.namespace
- name: AWS_SQS_NOTIFY_URL
  valueFrom:
    secretKeyRef:
      name: {{ .Release.Namespace }}-notify-sqs
      key: sqs_queue_url
- name: AWS_SQS_NOTIFY_ACCOUNT_ACCESS_KEY
  valueFrom:
    secretKeyRef:
      name: {{ .Release.Namespace }}-notify-sqs
      key: access_key_id
- name: AWS_SQS_NOTIFY_ACCOUNT_SECRET_KEY
  valueFrom:
    secretKeyRef:
      name: {{ .Release.Namespace }}-notify-sqs
      key: secret_access_key
- name: ALLOWED_EMAIL_DOMAINS_FOR_USER_CREATION
  value: '{{ tpl .Values.app.env.allowedDomains . }}'
{{- end -}}
