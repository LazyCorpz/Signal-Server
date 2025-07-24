# Installing dependencies
FROM node:lts-alpine3.22 AS build
WORKDIR /docker-entrypoint-initdb.d
COPY ["package.json", "package-lock.json*", "npm-shrinkwrap.json*", "./"]
RUN npm i

# Running MongoDB
FROM mongo:8.0.11 AS run
WORKDIR /docker-entrypoint-initdb.d
COPY --from=build [ "/docker-entrypoint-initdb.d/node_modules/", "." ]
COPY [ "./", "./" ]

HEALTHCHECK \
    --interval=5s \
    --timeout=5s \
    --start-period=10s \
    --retries=3 \
    CMD [ "mongosh", "--eval", "db.adminCommand('ping')"]
