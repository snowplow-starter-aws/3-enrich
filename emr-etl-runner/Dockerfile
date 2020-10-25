FROM snowplow-docker-registry.bintray.io/snowplow/base-debian:0.2.0
LABEL maintainer="Snowplow Analytics Ltd. <support@snowplowanalytics.com>"

RUN apt-get update && \
    apt-get install -y curl zip jq && \
    rm -rf /var/lib/apt/lists && \
    apt-get purge -y --auto-remove gnupg

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && unzip awscliv2.zip && ./aws/install

# The version of EmrEtlRunner to download.
ENV EMR_ETL_RUNNER_VERSION="0.38.1"

# The name of the archive to download.
ENV ARCHIVE="snowplow_emr_${EMR_ETL_RUNNER_VERSION}.zip"

# Install EmrEtlRunner.
RUN mkdir -p /tmp/build && \
    cd /tmp/build && \
    wget -q http://dl.bintray.com/snowplow/snowplow-generic/${ARCHIVE} && \
    unzip -d ${SNOWPLOW_BIN_PATH} ${ARCHIVE} && \
    cd /tmp && \
    rm -rf /tmp/build


ENV AWS_ACCESS_KEY_ID null
ENV AWS_SECRET_ACCESS_KEY null

ENV SNOWPLOW_BUCKET null
ENV EC2_KEY_NAME null
ENV VPC_SUBNET_ID null

ENV SNOWPLOW_PATH="/snowplow"
ENV SNOWPLOW_CONFIG_PATH="${SNOWPLOW_PATH}/config" \
    SNOWPLOW_BIN_PATH="${SNOWPLOW_PATH}/bin"

COPY config.yml $SNOWPLOW_CONFIG_PATH/config.yml
COPY targets/redshift.json $SNOWPLOW_CONFIG_PATH/targets/redshift.json
COPY resolvers/ $SNOWPLOW_CONFIG_PATH/resolvers/


COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh


RUN echo 'export $(strings /proc/1/environ | grep AWS_CONTAINER_CREDENTIALS_RELATIVE_URI)' >> /root/.profile

ENTRYPOINT [ "docker-entrypoint.sh" ]

CMD [ "" ]
