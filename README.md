# Hocs Helm Charts

Here you will find a common place for helm charts used by Hocs service.

The charts are built and published via github actions and github pages, see <https://github.com/helm/chart-releaser>

## Quick start

Add new charts to `/charts` directory, create PR, once merged to `main` branch github actions will publish the chart.

Repo URL = https://ukhomeoffice.github.io/hocs-helm-charts

You can add this repo to your local helm config like this:

```
helm repo add hocs-helm-charts https://ukhomeoffice.github.io/hocs-helm-charts
```

Search for published charts:

```
helm search repo hocs-helm-charts
```

## Testing changes locally

To locally test how a change to this repository affects a project, instead of referencing the GitHub repo as a dependency in that project such as:

```yaml
dependencies:
  - name: hocs-backend-service
    version: <some-version>
    repository: https://ukhomeoffice.github.io/hocs-helm-charts
```

you can reference this repository in your local file system as:

```yaml
dependencies:
  - name: hocs-backend-service
    version: <some-version>
    repository: file://<path-to-hocs-helm-charts>/charts/hocs-backend-service
```

Then run:

```bash
helm dependency update <directory-containing-project-chart>
```

Then can run a dry-run upgrade to see the effect:

```bash
helm upgrade --dry-run <release-name> <directory-containing-project-chart> --values <values-file>
```

You can also compare the template yaml by running the following both before and after your changes, saving the output to files:

```bash
helm -n my-namespace template <release-name> <directory-containing-project-chart> --values <values-file>
```
