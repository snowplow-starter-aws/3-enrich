FROM snowplow/stream-enrich-kinesis:1.1.3

COPY config.hocon /snowplow/config/
COPY enrichments/ /snowplow/config/enrichments/
COPY resolver.json /snowplow/config/

ENTRYPOINT [ "/home/snowplow/bin/snowplow-stream-enrich" ]
CMD [ "--config", "/snowplow/config/config.hocon", "--resolver", "file:/snowplow/config/resolver.json", "--enrichments", "file:/snowplow/config/enrichments/"]