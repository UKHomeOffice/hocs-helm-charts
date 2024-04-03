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
{{- trimPrefix "w" .Release.Namespace }}
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

{{/*
AWS CIDR ranges
*/}}
{{- define "hocs-app.networkpolicy.egress.aws-cidr-blocks" -}}
- ipBlock:
    cidr: 52.93.153.170/32
- ipBlock:
    cidr: 13.34.52.96/27
- ipBlock:
    cidr: 13.34.110.128/27
- ipBlock:
    cidr: 52.95.150.0/24
- ipBlock:
    cidr: 52.93.153.148/32
- ipBlock:
    cidr: 150.222.238.0/24
- ipBlock:
    cidr: 15.230.158.0/23
- ipBlock:
    cidr: 52.93.56.0/24
- ipBlock:
    cidr: 15.248.28.0/22
- ipBlock:
    cidr: 51.24.0.0/13
- ipBlock:
    cidr: 13.34.27.32/27
- ipBlock:
    cidr: 13.34.96.32/27
- ipBlock:
    cidr: 52.144.211.196/31
- ipBlock:
    cidr: 15.230.9.12/31
- ipBlock:
    cidr: 208.78.132.0/23
- ipBlock:
    cidr: 15.230.9.47/32
- ipBlock:
    cidr: 64.252.85.0/24
- ipBlock:
    cidr: 216.39.136.0/21
- ipBlock:
    cidr: 13.34.52.64/27
- ipBlock:
    cidr: 15.230.106.0/24
- ipBlock:
    cidr: 150.222.37.192/26
- ipBlock:
    cidr: 13.34.79.128/27
- ipBlock:
    cidr: 52.93.229.149/32
- ipBlock:
    cidr: 15.230.189.128/25
- ipBlock:
    cidr: 16.12.15.0/24
- ipBlock:
    cidr: 35.176.0.0/15
- ipBlock:
    cidr: 15.193.5.0/24
- ipBlock:
    cidr: 13.34.85.224/27
- ipBlock:
    cidr: 13.34.81.224/27
- ipBlock:
    cidr: 99.77.156.0/24
- ipBlock:
    cidr: 52.56.0.0/16
- ipBlock:
    cidr: 52.93.153.149/32
- ipBlock:
    cidr: 13.34.27.0/27
- ipBlock:
    cidr: 16.12.16.0/23
- ipBlock:
    cidr: 52.93.153.177/32
- ipBlock:
    cidr: 15.230.9.10/31
- ipBlock:
    cidr: 150.222.46.0/25
- ipBlock:
    cidr: 52.94.32.0/20
- ipBlock:
    cidr: 208.78.135.0/24
- ipBlock:
    cidr: 52.144.211.192/31
- ipBlock:
    cidr: 52.94.198.144/28
- ipBlock:
    cidr: 13.34.66.128/27
- ipBlock:
    cidr: 151.148.41.0/24
- ipBlock:
    cidr: 15.230.173.0/24
- ipBlock:
    cidr: 15.230.190.128/25
- ipBlock:
    cidr: 52.95.253.0/24
- ipBlock:
    cidr: 52.93.255.0/24
- ipBlock:
    cidr: 13.248.120.0/24
- ipBlock:
    cidr: 15.230.9.45/32
- ipBlock:
    cidr: 52.93.153.179/32
- ipBlock:
    cidr: 15.230.165.0/24
- ipBlock:
    cidr: 99.77.134.0/24
- ipBlock:
    cidr: 13.34.66.160/27
- ipBlock:
    cidr: 13.34.79.160/27
- ipBlock:
    cidr: 52.93.138.0/24
- ipBlock:
    cidr: 150.222.134.0/24
- ipBlock:
    cidr: 13.34.110.160/27
- ipBlock:
    cidr: 52.144.211.128/26
- ipBlock:
    cidr: 99.82.169.0/24
- ipBlock:
    cidr: 13.34.96.0/27
- ipBlock:
    cidr: 13.34.77.32/27
- ipBlock:
    cidr: 13.34.91.224/27
- ipBlock:
    cidr: 52.93.153.80/32
- ipBlock:
    cidr: 52.95.148.0/23
- ipBlock:
    cidr: 150.222.215.0/24
- ipBlock:
    cidr: 15.230.153.0/24
- ipBlock:
    cidr: 52.144.209.192/26
- ipBlock:
    cidr: 52.93.80.0/24
- ipBlock:
    cidr: 52.144.133.32/27
- ipBlock:
    cidr: 52.219.219.0/24
- ipBlock:
    cidr: 13.34.77.160/27
- ipBlock:
    cidr: 52.144.211.64/26
- ipBlock:
    cidr: 52.93.153.176/32
- ipBlock:
    cidr: 52.93.153.169/32
- ipBlock:
    cidr: 150.222.65.0/24
- ipBlock:
    cidr: 150.222.37.128/26
- ipBlock:
    cidr: 52.93.229.148/32
- ipBlock:
    cidr: 52.94.48.0/20
- ipBlock:
    cidr: 52.93.153.171/32
- ipBlock:
    cidr: 18.168.0.0/14
- ipBlock:
    cidr: 150.222.37.64/26
- ipBlock:
    cidr: 52.93.153.168/32
- ipBlock:
    cidr: 18.175.0.0/16
- ipBlock:
    cidr: 52.95.239.0/24
- ipBlock:
    cidr: 13.34.91.192/27
- ipBlock:
    cidr: 52.94.112.0/22
- ipBlock:
    cidr: 150.222.207.0/24
- ipBlock:
    cidr: 13.34.26.192/27
- ipBlock:
    cidr: 52.144.213.64/26
- ipBlock:
    cidr: 13.34.18.128/27
- ipBlock:
    cidr: 18.132.0.0/14
- ipBlock:
    cidr: 15.230.9.248/32
- ipBlock:
    cidr: 15.230.255.0/24
- ipBlock:
    cidr: 52.93.139.0/24
- ipBlock:
    cidr: 52.144.211.198/31
- ipBlock:
    cidr: 64.252.84.0/24
- ipBlock:
    cidr: 150.222.46.128/25
- ipBlock:
    cidr: 52.93.153.174/32
- ipBlock:
    cidr: 64.252.83.0/24
- ipBlock:
    cidr: 13.34.85.192/27
- ipBlock:
    cidr: 52.93.153.175/32
- ipBlock:
    cidr: 99.77.249.0/24
- ipBlock:
    cidr: 35.178.0.0/15
- ipBlock:
    cidr: 52.94.15.0/24
- ipBlock:
    cidr: 52.95.144.0/24
- ipBlock:
    cidr: 52.95.142.0/23
- ipBlock:
    cidr: 64.252.82.0/24
- ipBlock:
    cidr: 15.230.9.46/32
- ipBlock:
    cidr: 35.71.111.0/24
- ipBlock:
    cidr: 99.150.40.0/21
- ipBlock:
    cidr: 15.230.55.0/24
- ipBlock:
    cidr: 15.230.9.252/31
- ipBlock:
    cidr: 52.95.191.0/24
- ipBlock:
    cidr: 13.34.81.192/27
- ipBlock:
    cidr: 52.94.248.192/28
- ipBlock:
    cidr: 15.177.78.0/24
- ipBlock:
    cidr: 13.34.52.192/27
- ipBlock:
    cidr: 173.83.206.0/23
- ipBlock:
    cidr: 3.2.48.0/24
- ipBlock:
    cidr: 54.239.0.240/28
- ipBlock:
    cidr: 3.8.0.0/14
- ipBlock:
    cidr: 150.222.67.0/24
- ipBlock:
    cidr: 15.221.48.0/24
- ipBlock:
    cidr: 52.144.209.64/26
- ipBlock:
    cidr: 18.130.0.0/16
- ipBlock:
    cidr: 52.144.211.200/31
- ipBlock:
    cidr: 52.93.153.172/32
- ipBlock:
    cidr: 15.230.86.0/24
- ipBlock:
    cidr: 52.94.160.0/20
- ipBlock:
    cidr: 13.34.52.224/27
- ipBlock:
    cidr: 3.5.244.0/22
- ipBlock:
    cidr: 13.34.77.0/27
- ipBlock:
    cidr: 52.93.153.173/32
- ipBlock:
    cidr: 52.144.211.202/31
- ipBlock:
    cidr: 13.34.27.64/27
- ipBlock:
    cidr: 15.230.9.44/32
- ipBlock:
    cidr: 13.34.18.160/27
- ipBlock:
    cidr: 13.34.52.128/27
- ipBlock:
    cidr: 13.40.0.0/14
- ipBlock:
    cidr: 13.34.48.96/27
- ipBlock:
    cidr: 15.230.9.14/31
- ipBlock:
    cidr: 150.222.29.0/24
- ipBlock:
    cidr: 13.248.101.0/24
- ipBlock:
    cidr: 52.144.211.194/31
- ipBlock:
    cidr: 15.230.43.0/24
- ipBlock:
    cidr: 13.34.48.64/27
- ipBlock:
    cidr: 13.34.52.160/27
- ipBlock:
    cidr: 52.93.153.178/32
- ipBlock:
    cidr: 54.239.100.0/23
- ipBlock:
    cidr: 13.34.77.128/27
- ipBlock:
    cidr: 150.222.45.128/25
- ipBlock:
    cidr: 216.39.152.0/21
- ipBlock:
    cidr: 15.230.190.0/25
- ipBlock:
    cidr: 13.40.1.192/26
- ipBlock:
    cidr: 13.41.1.160/27
- ipBlock:
    cidr: 13.43.44.0/22
- ipBlock:
    cidr: 13.43.48.0/23
- ipBlock:
    cidr: 18.132.146.192/26
- ipBlock:
    cidr: 18.133.45.0/26
- ipBlock:
    cidr: 18.133.45.64/26
- ipBlock:
    cidr: 18.171.35.128/26
- ipBlock:
    cidr: 3.10.201.128/27
- ipBlock:
    cidr: 3.10.201.192/26
- ipBlock:
    cidr: 3.8.168.0/23
{{- end }}
