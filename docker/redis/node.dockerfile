FROM redis:8.2.0-alpine

ENV REDIS_PORT=6379
ENV TIMEOUT_MS=5000

WORKDIR /usr/app/
COPY [ "./node.sh", "./" ]

ENTRYPOINT [ "./node.sh" ]

# Will only succeed once the cluster is formed
HEALTHCHECK --interval=1s --timeout=2s --start-period=5s --retries=3 CMD \
    "redis-cli", "--cluster", "check", "localhost:${REDIS_PORT}"
