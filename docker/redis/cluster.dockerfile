FROM redis:8.2.0-alpine

ENTRYPOINT [ "redis-cli", "--cluster-yes", "--cluster", "create" ]
