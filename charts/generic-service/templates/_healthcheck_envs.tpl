{{- define "healthcheck.envs" }}
startupProbe:
  httpGet:
    path: /actuator/health/liveness
    port: http
{{- if not .Values.proxy.enabled }}
    scheme: HTTPS
{{- end }}
    httpHeaders:
      - name: X-probe
        value: kubelet
  initialDelaySeconds: 10
  periodSeconds: 2
  failureThreshold: 20
livenessProbe:
  httpGet:
    path: /actuator/health/liveness
    port: http
{{- if not .Values.proxy.enabled }}
    scheme: HTTPS
{{- end }}
    httpHeaders:
      - name: X-probe
        value: kubelet
  periodSeconds: 2
readinessProbe:
  httpGet:
    path: /actuator/health/readiness
    port: http
{{- if not .Values.proxy.enabled }}
    scheme: HTTPS
{{- end }}
    httpHeaders:
      - name: X-probe
        value: kubelet
  periodSeconds: 2
{{- end -}}
