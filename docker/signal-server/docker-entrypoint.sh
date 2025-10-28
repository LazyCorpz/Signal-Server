#!/bin/sh

# Installation handles mounted secrets
'./mvnw' install -Dmaven.test.skip=true $@
# ./mvnw integration-test -Pverify-server-config -Dmaven.test.skip=true $@
./mvnw integration-test -Dmaven.test.skip=true $@
