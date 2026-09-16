# keycloak-docker

Keycloak custom build

Bump version:

First, update `Dockerfile` to get the latest from https://quay.io/repository/keycloak/keycloak?tab=tags

```bash
git tag <version>
git push origin <version>
```

This will trigger the github CI and push a container at `ghcr.io/dataresearchcenter/keycloak:<version>`
