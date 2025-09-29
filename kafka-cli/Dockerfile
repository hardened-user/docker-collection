FROM alpine:3.20

ARG JAVA_VERSION=0
ARG KAFKA_VERSION=0.0.0
ARG SCALA_VERSION=0.0

ENV TZ="Europe/Moscow"

### APK packages
RUN apk add --no-cache \
      bash busybox-extras ca-certificates nano wget openssl \
      openjdk${JAVA_VERSION}-jre kcat && \
    rm -rf /var/cache/apk/*

### Apache Kafka
# https://dlcdn.apache.org/kafka/${KAFKA_VERSION}/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz
RUN wget -nv "https://archive.apache.org/dist/kafka/${KAFKA_VERSION}/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz" -O /tmp/kafka.tgz && \
    tar -xzf /tmp/kafka.tgz -C /opt && \
    mv /opt/kafka_${SCALA_VERSION}-${KAFKA_VERSION} /opt/kafka && \
    rm -rfv /opt/kafka/site-docs && \
    rm -rfv /opt/kafka/bin/windows && \
    rm -rfv /opt/kafka/libs/rocksdbjni-* && \
    rm /tmp/kafka.tgz

ENV PATH="/opt/kafka/bin:${PATH}"

### Entrypoint
COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
WORKDIR /opt/kafka
