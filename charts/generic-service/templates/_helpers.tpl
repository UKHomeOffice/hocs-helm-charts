{{/*
Expand the name of the chart.
*/}}
{{- define "hocs-app.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "hocs-app.selectorLabels" -}}
name: {{ include "hocs-app.name" . }}
role: {{ tpl .Values.deployment.selectorRole . }}
version: {{.Values.version}}
{{- end }}

{{/*
Application port
*/}}
{{- define "hocs-app.port" -}}
{{- if .Values.proxy.enabled }}{{ .Values.app.port }}{{- else }}{{ .Values.service.targetPort }}{{- end }}
{{- end }}

{{/*
Healthcheck scheme
*/}}
{{- define "hocs-app.healthcheck.scheme" -}}
{{- if .Values.proxy.enabled }}HTTP{{- else }}HTTPS{{- end }}
{{- end }}

{{/*
Internal domain Name
*/}}
{{- define "hocs-app.internal.domainName" -}}
{{ tpl .Values.ingress.internal.host .}}
{{- end }}

{{/*
External domain Name
*/}}
{{- define "hocs-app.external.domainName" -}}
{{tpl .Values.ingress.external.host . }}
{{- end }}
