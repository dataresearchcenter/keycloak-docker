# https://www.keycloak.org/server/containers
FROM quay.io/keycloak/keycloak:26.8.1 AS builder

ENV KC_DB=postgres
ENV KC_FEATURES=token-exchange
ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true

RUN /opt/keycloak/bin/kc.sh build

FROM quay.io/keycloak/keycloak:26.8.1
COPY --from=builder /opt/keycloak/lib/quarkus/ /opt/keycloak/lib/quarkus/
WORKDIR /opt/keycloak

ENV KC_HTTP_ENABLED=true
ENV KC_PROXY_HEADERS=xforwarded

HEALTHCHECK --interval=15s --timeout=5s --start-period=120s --retries=5 \
  CMD bash -c 'exec 3<>/dev/tcp/127.0.0.1/9000 && printf "GET /health/ready HTTP/1.1\r\nHost: localhost\r\nConnection: close\r\n\r\n" >&3 && head -n1 <&3 | grep -q " 200 "'

ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "start", "--optimized"]
