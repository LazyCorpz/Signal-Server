# Same version as in pom.xml: eclipse-temurin:21.0.6_7-jre-jammy
ARG JAVA_VERSION=eclipse-temurin@sha256:02fc89fa8766a9ba221e69225f8d1c10bb91885ddbd3c112448e23488ba40ab6

# Installing Maven dependencies
FROM ${JAVA_VERSION} AS dependencies

WORKDIR /usr/app
COPY "./mvnw" "./mvnw"
COPY "./.mvn/" "./.mvn/"
COPY "./pom.xml" "./pom.xml"
COPY "./websocket-resources/pom.xml" "./websocket-resources/pom.xml"
COPY [ "./service/pom.xml", "./service/assembly.xml", "./service/" ]
COPY "./integration-tests/pom.xml" "./integration-tests/pom.xml"
COPY "./api-doc/pom.xml" "./api-doc/pom.xml"

# RUN [ "./mvnw", "verify", "--fail-never", "-q" ]
RUN [ "./mvnw", "dependency:go-offline", "-U", "-q" ]

# Compiling and testing the application
FROM ${JAVA_VERSION} AS test

COPY --from=dependencies "/root/.m2/" "/root/.m2/"
WORKDIR /usr/app
COPY --from=dependencies "/usr/app/" "./"
COPY "./" "./"

ENTRYPOINT [ "./mvnw", "integration-test", "-Ptest-server" ]

# Building and running project JAR file
FROM ${JAVA_VERSION} AS run

COPY --from=dependencies "/root/.m2/" "/root/.m2/"
WORKDIR /usr/app
COPY --from=dependencies "/usr/app/" "./"
COPY "./docker/signal-server/docker-entrypoint.sh" "./docker-entrypoint.sh"
COPY "./" "./"

# CMD args passed to Maven and JVM
ENTRYPOINT [ "./docker-entrypoint.sh" ]
