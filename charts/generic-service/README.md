# generic-service helm chart

## How to use this chart

Each project should define an umbrella chart, in most cases this will be essentially an empty helm chart, which specifies this chart as a dependency.

File/folder structure as follows, with more details below on file contents:

```bash
helm
helm/values-[environment].yaml (1 per environment)
helm_deploy/[project name]
helm_deploy/[project name]/Chart.yaml
helm_deploy/[project name]/values.yaml
helm_deploy/[project name]/templates/_envs.tpl
helm_deploy/[project name]/templates/*.yaml (* optional)
```

(_* optionally include project specific resources not installed by generic-service chart in the `templates/` folder e.g. cronjobs _)

Example `Chart.yaml`

```yaml
apiVersion: v2
name: hocs-templates
version: 1.0.0
dependencies:
  - name: hocs-generic-service
    version: ^3.0.0
    repository: https://ukhomeoffice.github.io/hocs-helm-charts
```

### Setting project wide values

`helm_deploy/[project name]/values.yaml`

The values here override the default values set in the `hocs-generic-service` chart - see the _values.yaml_ in this repo/folder.

This file will contain values that are the same across all namespaces or are sensible defaults across all namespaces.

Example project `values.yaml` file:

```yaml
---
hocs-generic-service:
  nameOverride: hocs-templates

  app:
    image:
      repository: quay.io/ukhomeofficedigital/hocs-templates
    javaOpts: >-
      -XX:InitialRAMPercentage=50 -XX:MaxRAMPercentage=70
      -Djava.security.egd=file:/dev/./urandom
      -Djavax.net.ssl.trustStore=/etc/keystore/truststore.jks
      -Dhttps.proxyHost=hocs-outbound-proxy.{{ .Release.Namespace }}.svc.cluster.local
      -Dhttps.proxyPort=31290
      -Dhttp.nonProxyHosts=*.{{ .Release.Namespace }}.svc.cluster.local
    caseworkService: https://hocs-casework.{{ .Release.Namespace }}.svc.cluster.local
    infoService: https://hocs-info-service.{{ .Release.Namespace }}.svc.cluster.local
    docsService: https://hocs-docs.{{ .Release.Namespace }}.svc.cluster.local
```

### overwriting main deployment environment variables with _envs.tpl

You need to set the environment variables used by the main container by creating a file `_envs.tpl`

so for a service with `nameOverride: hocs-templates` you need to do

```yaml
{{- define "hocs-templates.envs" }}
- name: JAVA_OPTS
  value: '{{ tpl .Values.app.env.javaOpts . }}'
...
```

This reference in the `define` line is based on the nameOverride field via a helper definition in deployment.yaml.

```yaml
          env:
            {{- include (printf "%s.%s" (include "hocs-deploymentEnvs.name" .) "envs") . | nindent 12 }}
```

It is possible to override `_envs.tpl` `define` name here without renaming the deployment name by using `deploymentEnvs` 

```yaml
---
hocs-generic-service:
  nameOverride: hocs-templates
  deploymentEnvs: other-hocs-templates-name
```

then include a file defined as `other-hocs-templates-name` 
```yaml
{{- define "other-hocs-templates-name.envs" }}
- name: JAVA_OPTS
  value: '{{ tpl .Values.app.env.javaOpts . }}'
```

### Setting namespace specific values 

These are best placed in the [hocs-helmfile](https://github.com/UKHomeOffice/hocs-helmfile) project.
Dev values are best placed in the repo they relate to .e.g. hocs-templates.yaml in the hocs-templates/helm folder

But for projects that want to exist outside of hocs-helmfile:

These file should only contain values that differ between namespaces.

Example namespace specific file `values-dev.yaml`:

```yaml
---
hocs-generic-service:
  minReplicas: 1
  maxReplicas: 1

  deploymentAnnotations:
    downscaler/downtime: "Mon-Sun 00:00-07:55 Europe/London,Mon-Sun 18:05-24:00 Europe/London"

  app:
    resources:
      limits:
        memory: 512Mi
      requests:
        memory: 512Mi
```

#### Notable options

```yaml
---
hocs-generic-service:
  
  autoscale:
    enabled: false/true
    
  service:
    enabled: false/true

  truststore:
    enabled: false/true

  proxy:
    enabled: false/true
    
  keycloak:
    enabled: false/true

  keycloakApi:
    enabled: false/true

  ingress:
    internal:
      enabled: false/true  
    external:
      enabled: false/true

```

**autoscale enabled**

This toggles the presence of a HorizontalPodAutoscaler. If disabled will set spec.replicas=1.
Typically `false` in notprod for all services, and in prod for SQS consumers and utilities

**service enabled**

this toggles the presence of a Service.
Typically `false` for services without REST APIs

**truststore enabled**

This toggles the presence of a CFSSL proxy as an initcontainer, this will then put certs in a volume which is mounted by the other containers.

**proxy enabled**

This toggles the presence of an nginx proxy used for SSL termination. 
If disabled the 'main' container will be configured to listen on port 10443 and provision should be made for SSL termination in the service.

**keycloak enabled**

This toggles the presence of a keycloak gateway 

**keycloakApi enabled**

This toggles the presence of a second keycloak gateway that for example can be configured without a redirect for API calls

**ingress internal enabled**

This toggles the presence of an ingress configured to use the ACP internal proxy

**ingress external enabled**

This toggles the presence of an ingress configured to use the ACP external proxy
