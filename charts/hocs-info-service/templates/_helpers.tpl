{{/*
Expand the name of the chart.
*/}}
{{- define "hocs-app.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Expand the name of the chart.
*/}}
{{- define "hocs-deploymentEnvs.name" -}}
{{- default .Values.nameOverride .Values.deploymentEnvs | trunc 63 | trimSuffix "-" }}
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
{{ .Values.service.targetPort }}
{{- end }}

{{/*
Healthcheck scheme
*/}}
{{- define "hocs-app.healthcheck.scheme" -}}
HTTPS
{{- end }}
