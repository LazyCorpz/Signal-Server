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

ENTRYPOINT [ "./mvnw", "verify" ]

# Compiling and packaging project into a JAR file
FROM eclipse-temurin:21 AS package

COPY --from=dependencies "/root/.m2/" "/root/.m2/"
WORKDIR /usr/app
COPY --from=dependencies "/usr/app/" "./"
COPY "./" "./"

# https://maven.apache.org/surefire/maven-surefire-plugin/examples/skipping-tests.html
RUN [ "./mvnw", "-o", "package", "-Dmaven.test.skip=true" ]

# Running the application
FROM eclipse-temurin:21 AS run

WORKDIR /usr/app
# TODO Is this filename correct?
COPY --from=package "/usr/app/target/TextSecureServer-JGITVER.jar" "./app.jar"

ENTRYPOINT [ "java", "-jar", "./app.jar" ]
