# keycloak-docker

Keycloak custom build, published as `ghcr.io/dataresearchcenter/keycloak:<keycloak version>`.

## Bump version

The upstream version lives in the `Dockerfile`'s two `FROM` tags. Dependabot
watches them and opens a PR for every upstream release; **merging that PR is
the release** — the push to `main` builds the image and pushes it as
`ghcr.io/dataresearchcenter/keycloak:<keycloak version>`.

To bump by hand, change both `FROM` tags to the same version and push to
`main`. The build fails if the two disagree. Pushing a semver git tag also
still produces an image with that tag, if you want a release marker.

## Themes

The theme jars in `themes/` are copied into `/opt/keycloak/providers` at build
time and baked in by `kc.sh build`; the image starts with `kc.sh start
--optimized`. To change a theme, replace its jar here and release a new image.
