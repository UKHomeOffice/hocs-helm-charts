{{- define "hocs-extracts.envs" }}
- name: JAVA_OPTS
  value: '{{ tpl .Values.app.env.javaOpts . }}'
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
- name: HOCS_INFO_SERVICE
  value: '{{ tpl .Values.app.env.infoService . }}'
- name: HOCS_CASE_SERVICE
  value: '{{ tpl .Values.app.env.caseService . }}'
- name: HOCS_BASICAUTH
  valueFrom:
    secretKeyRef:
      name: ui-casework-creds
      key: plaintext
{{- end -}}