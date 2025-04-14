FROM openjdk:17-slim

RUN apt-get update && apt-get install -y \
    maven \
    docker.io \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
