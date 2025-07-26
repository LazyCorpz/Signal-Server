#!/bin/sh

# Installation requires mounted secrets
'./mvnw' install -Dmaven.test.skip=true $@
java -jar './target/TextSecureServer-0.0.0-NOT_A_GIT_REPOSITORY.jar' $@
