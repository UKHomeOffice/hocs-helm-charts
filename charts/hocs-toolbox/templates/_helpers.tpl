{{/*
Expand the name of the chart.
*/}}
{{- define "hocs-app.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Network policy role to use.
*/}}
{{- define "hocs-role.name" -}}
{{- default .Values.nameOverride .Values.role | trunc 63 | trimSuffix "-" }}
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
