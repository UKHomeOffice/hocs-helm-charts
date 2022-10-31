{{- define "hocs-queue-tool.envs" }}
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
{{- range .Values.app.env.queues }}
- name: {{. | title | replace "-" "_" | upper }}_QUEUE
  valueFrom:
    secretKeyRef:
      name: {{ $.Release.Namespace }}-{{. | title | lower }}-sqs
      key: sqs_queue_url
      optional: true
- name: {{. | title | replace "-" "_" | upper }}_QUEUE_ACCESS_KEY_ID
  valueFrom:
    secretKeyRef:
      name: {{ $.Release.Namespace }}-{{. | title | lower }}-sqs
      key: access_key_id
      optional: true
- name: {{. | title | replace "-" "_" | upper }}_QUEUE_SECRET_ACCESS_KEY
  valueFrom:
    secretKeyRef:
      name: {{ $.Release.Namespace }}-{{. | title | lower }}-sqs
      key: secret_access_key
      optional: true
- name: {{. | title | replace "-" "_" | upper }}_DLQ_QUEUE
  valueFrom:
    secretKeyRef:
      name: {{ $.Release.Namespace }}-{{. | title | lower }}-sqs
      key: sqs_dlq_url
      optional: true
- name: {{. | title | replace "-" "_" | upper }}_DLQ_ACCESS_KEY_ID
  valueFrom:
    secretKeyRef:
      name: {{ $.Release.Namespace }}-{{. | title | lower }}-sqs
      key: access_key_id
      optional: true
- name: {{. | title | replace "-" "_" | upper }}_DLQ_SECRET_ACCESS_KEY
  valueFrom:
    secretKeyRef:
      name: {{ $.Release.Namespace }}-{{. | title | lower }}-sqs
      key: secret_access_key
      optional: true
{{- end -}}
{{- end -}}
