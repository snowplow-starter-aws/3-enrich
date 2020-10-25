FROM snowplow-docker-registry.bintray.io/snowplow/base-alpine:0.2.0

# The version of stream enrich to download.
ENV ENRICH_VERSION="1.1.3"

# The targeted platform
ENV PLATFORM="kinesis"

# The name of the archive to download.
ENV ARCHIVE="snowplow_stream_enrich_${PLATFORM}_${ENRICH_VERSION}.zip"

# Install the Scala Stream Collector.
RUN mkdir -p /tmp/build && \
    cd /tmp/build && \
    wget -q http://dl.bintray.com/snowplow/snowplow-generic/${ARCHIVE} && \
    unzip -d ${SNOWPLOW_BIN_PATH} ${ARCHIVE} && \
    cd /tmp && \
    rm -rf /tmp/build


### Changes from peter siemen
### IMPORTANT
COPY config.hocon /snowplow/config/config.hocon
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
COPY enrichments/ $SNOWPLOW_CONFIG_PATH/enrichments/
COPY iglu_resolver.json $SNOWPLOW_CONFIG_PATH/
###

# Defines an entrypoint script delegating the lauching of stream enrich to the snowplow user.
# The script uses dumb-init as the top-level process.
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT [ "docker-entrypoint.sh" ]
