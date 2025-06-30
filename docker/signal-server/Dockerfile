# Installing Maven dependencies
FROM eclipse-temurin:21 AS dependencies

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
FROM eclipse-temurin:21 AS test

COPY --from=dependencies "/root/.m2/" "/root/.m2/"
WORKDIR /usr/app
COPY --from=dependencies "/usr/app/" "./"
COPY "./" "./"

ENTRYPOINT [ "./mvnw", "integration-test", "-Ptest-server" ]

# Building and running project JAR file
FROM eclipse-temurin:21 AS run

COPY --from=dependencies "/root/.m2/" "/root/.m2/"
WORKDIR /usr/app
COPY --from=dependencies "/usr/app/" "./"
COPY "./docker/signal-server/docker-entrypoint.sh" "./docker-entrypoint.sh"
COPY "./" "./"

# CMD args passed to Maven and JVM
ENTRYPOINT [ "./docker-entrypoint.sh" ]
