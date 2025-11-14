#!/bin/sh

redis-server \
    --port $REDIS_PORT \
    --cluster-enabled yes \
    --cluster-config-file nodes.conf \
    --cluster-node-timeout $TIMEOUT_MS \
    --appendonly yes \
    $@
