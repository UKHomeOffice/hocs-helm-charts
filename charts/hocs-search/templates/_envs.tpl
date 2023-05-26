{{- define "hocs-search.envs" }}
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
- name: ELASTICSEARCH_INDEX_PREFIX
  value: '{{ tpl .Values.app.env.elasticPrefix . }}'
- name: ELASTICSEARCH_HOST
  valueFrom:
    secretKeyRef:
      name: {{ .Release.Namespace }}-opensearch
      key: endpoint
- name: ELASTICSEARCH_ACCESS_KEY
  valueFrom:
    secretKeyRef:
      name: {{ .Release.Namespace }}-opensearch
      key: access_key_id
- name: ELASTICSEARCH_SECRET_KEY
  valueFrom:
    secretKeyRef:
      name: {{ .Release.Namespace }}-opensearch
      key: secret_access_key
{{- end -}}
