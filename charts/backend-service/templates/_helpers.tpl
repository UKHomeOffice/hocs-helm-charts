{{/*
Expand the name of the chart.
*/}}
{{- define "hocs-app.name" -}}
{{- default .Chart.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "hocs-app.selectorLabels" -}}
name: {{ include "hocs-app.name" . }}
role: hocs-backend
version: {{.Values.version}}
{{- end }}

{{/*
Security context
*/}}
{{- define "hocs-app.securityContext" -}}
runAsNonRoot: true
capabilities:
  drop:
    - SETUID
    - SETGID
{{- end }}
