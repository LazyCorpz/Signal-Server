# JDK version matches JRE version in pom.xml
# eclipse-temurin:21.0.6_7-jdk-jammy
ARG JDK_VERSION=eclipse-temurin@sha256:24a8854594eea72c16822953e6cb96c78d10fc3c77b7b8a60ce8e5ac440a2337

# Copying legal notices, for final build stages
FROM scratch AS notices

WORKDIR /usr/app/
COPY [ "./README.md", "TESTING.md", "./LICENSE", "./NOTICE.md", "./" ]

# Used to assert that licensing info is indeed copied
ENTRYPOINT [ "tail", "-f", "/dev/null" ]

# Installing dependencies
FROM ${JDK_VERSION} AS dependencies

WORKDIR /usr/app/
COPY [ "./mvnw", "./mvnw" ]
COPY [ "./.mvn/", "./.mvn/" ]
COPY [ "./pom.xml", "./pom.xml" ]
COPY [ "./websocket-resources/pom.xml", "./websocket-resources/pom.xml" ]
COPY [ "./service/pom.xml", "./service/pom.xml" ]
COPY [ "./api-doc/pom.xml", "./api-doc/pom.xml" ]
COPY [ "./integration-tests/pom.xml", "./integration-tests/pom.xml" ]

RUN [ "./mvnw", "dependency:go-offline", "-U", "-q" ]

# Building and testing websocket-resources module
FROM ${JDK_VERSION} AS websocket-resources

WORKDIR /usr/app/
COPY --from=dependencies [ "/root/.m2/", "/root/.m2/" ]
COPY --from=dependencies [ "/usr/app/", "./" ]
COPY [ "./websocket-resources/", "./websocket-resources/" ]
RUN [ "./mvnw", "install", "-pl", ":websocket-resources", "-am", "-q" ]

# Building and testing service module
FROM ${JDK_VERSION} AS service

WORKDIR /usr/app/
COPY --from=websocket-resources [ "/root/.m2/", "/root/.m2/" ]
COPY --from=websocket-resources [ "/usr/app/", "./" ]
COPY [ "./service/", "./service/" ]
COPY [ "./spam-filter/", "./spam-filter/" ]

RUN [ "./mvnw", "install", "-pl", ":service", "-am", "-q" ]

# Building and testing api-doc module
FROM ${JDK_VERSION} AS api-doc

WORKDIR /usr/app/
COPY --from=service [ "/root/.m2/", "/root/.m2/" ]
COPY --from=service [ "/usr/app/", "./" ]
COPY [ "./api-doc/", "./api-doc/" ]

RUN [ "./mvnw", "install", "-pl", ":api-doc", "-am", "-q" ]

# Building and running integration tests
FROM ${JDK_VERSION} AS integration-tests

WORKDIR /usr/app/
COPY --from=api-doc [ "/root/.m2/", "/root/.m2/" ]
COPY --from=api-doc [ "/usr/app/", "./" ]
COPY [ "./integration-tests", "./integration-tests" ]

RUN [ "./mvnw", "install", "-pl", ":integration-tests", "-am", "-Dmaven.test.skip=true", "-q" ]

# For user readability
ENTRYPOINT [ "echo", "==================== SUCCESS ====================" ]

# For development purposes, we can rebuild the project without compiling
# or running tests, allowing for further ease of testing later modules
FROM ${JDK_VERSION} AS build-without-tests

WORKDIR /usr/app/
COPY --from=dependencies [ "/root/.m2/", "/root/.m2/" ]
COPY --from=dependencies [ "/usr/app/", "./" ]
COPY [ "./websocket-resources/", "./websocket-resources/" ]
COPY [ "./service/", "./service/" ]
COPY [ "./spam-filter/", "./spam-filter/" ]
COPY [ "./api-doc/", "./api-doc/" ]
COPY [ "./integration-tests/", "./integration-tests/" ]

RUN [ "./mvnw", "install", "-am", "-Dmaven.test.skip=true", "-q" ]

# Running test server
FROM ${JDK_VERSION} AS run-test-server

WORKDIR /usr/app/
COPY --from=integration-tests [ "/root/.m2/", "/root/.m2/" ]
COPY --from=integration-tests [ "/usr/app/", "./" ]
COPY --from=notices [ "/usr/app/", "./" ]

# Requires mounted secrets
# ENTRYPOINT [ "./mvnw", "integration-test", "-Pverify-server-config", "-Ptest-server" ]
ENTRYPOINT [ "./mvnw", "integration-test", "-Ptest-server" ]
EXPOSE 8080 8081

# Packaging and running project without running tests
FROM ${JDK_VERSION} AS run

WORKDIR /usr/app/
COPY --from=build-without-tests [ "/root/.m2/", "/root/.m2/" ]
COPY --from=build-without-tests [ "/usr/app/", "./" ]
COPY [ "./docker/signal-server/docker-entrypoint.sh", "./" ]
COPY --from=notices [ "/usr/app/", "./" ]

# CMD args are passed to both Maven and JVM,
# which install and run the server, respectively
ENTRYPOINT [ "./docker-entrypoint.sh" ]
CMD [ "-Dsecrets.bundle.filename=config/test-secrets-bundle.yml" ]
EXPOSE 8080 8081
