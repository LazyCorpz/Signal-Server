#!/bin/sh

# Installation handles mounted secrets
'./mvnw' install -Pverify-server-config -Dmaven.test.skip=true $@
java -jar './target/TextSecureServer-0.0.0-NOT_A_GIT_REPOSITORY.jar' $@
