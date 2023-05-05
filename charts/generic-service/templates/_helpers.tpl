{{/*
Name of the chart.
*/}}
{{- define "hocs-app.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Deployment file to use.
*/}}
{{- define "hocs-deploymentEnvs.name" -}}
{{- default .Values.nameOverride .Values.deploymentEnvs | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Network policy role to use.
*/}}
{{- define "hocs-role.name" -}}
{{- default .Values.nameOverride .Values.role | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
CS namespace equivalent e.g. wcs-dev -> cs-dev.
*/}}
{{- define "cs-namespace" -}}
{{- trimPrefix "w" .Release.namespace }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "hocs-app.selectorLabels" -}}
name: {{ include "hocs-app.name" . }}
role: {{ include "hocs-role.name" . }}
{{- if .Values.selector.ingress.required }}
ingress: required
{{- end }}
{{- if .Values.selector.outbound.required }}
outbound: required
{{- end }}
{{- if .Values.selector.database.required }}
database: required
{{- end }}
version: {{ .Values.version }}
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
