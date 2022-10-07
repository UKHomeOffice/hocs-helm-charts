# backend-service helm chart

## Prerequisites

### Helm v3 client

This is installed and used within our pipelines but it is also useful to have installed locally for troubleshooting. See <https://helm.sh/docs/intro/install/>

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
helm_deploy/[project name]/templates/ (* optional)
```

(_* optionally include the `templates/` folder containing project specific resources not installed by generic-service chart e.g. cronjobs _)

Example `Chart.yaml`

```yaml
apiVersion: v2
name: hocs-templates
version: 1.0.0

dependencies:
  - name: hocs-backend-service
    version: 1.2.1
    repository: https://ukhomeoffice.github.io/hocs-helm-charts
```

### Setting project wide values

`helm_deploy/[project name]/values.yaml`

The values here override the default values set in the `hocs-backend-service` chart - see the _values.yaml_ in this repo/folder.

This file will contain values that are the same across all environments.

Example project `values.yaml` file:

```yaml
---
hocs-backend-service:
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
    caseService: https://hocs-casework.{{ .Release.Namespace }}.svc.cluster.local
    infoService: https://hocs-info-service.{{ .Release.Namespace }}.svc.cluster.local
    docsService: https://hocs-docs.{{ .Release.Namespace }}.svc.cluster.local
```

### Injecting env into batch yamls

You can inject the set of environment variables defined for the pods into other application yamls such as batch jobs:

```yaml
          env:
            {{ include "deployment.envs" . | nindent 12 }}
```

### Setting environment specific values

`helm/values-[environment].yaml`

This file should only contain values that differ between environments.

Example of `helm_deploy/values-[environment].yaml` file:

```yaml
---
hocs-backend-service:
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
hocs-backend-service:

  truststore:
    enabled: false

  proxy:
    enabled: false

```


**truststore enabled**

This toggles the presence of a CFSSL proxy as an initcontainer, this will then put certs in a volume which is mounted by the other containers.

**proxy enabled**

This toggles the presence of an nginx proxy used for SSL termination. 
If disabled the 'main' container will be configured to listen on port 10443 and provision should be made for SSL termination.
