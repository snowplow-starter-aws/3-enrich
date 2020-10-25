#!/usr/bin/dumb-init /bin/sh
set -e

# If the config directory has been mounted through -v, we chown it.
if [ "$(stat -c %u ${SNOWPLOW_CONFIG_PATH})" != "$(id -u snowplow)" ]; then
  chown snowplow:snowplow ${SNOWPLOW_CONFIG_PATH}
fi


export AWS_ACCESS_KEY_ID=$(curl "http://169.254.170.2$AWS_CONTAINER_CREDENTIALS_RELATIVE_URI" | jq '.AccessKeyId' | sed 's/"//g')
export AWS_SECRET_ACCESS_KEY=$(curl "http://169.254.170.2$AWS_CONTAINER_CREDENTIALS_RELATIVE_URI" | jq '.SecretAccessKey' | sed 's/"//g')
export AWS_SESSION_TOKEN=$(curl "http://169.254.170.2$AWS_CONTAINER_CREDENTIALS_RELATIVE_URI" | jq '.Token' | sed 's/"//g')

EMR_AWS_ACCESS_KEY_ID=$(aws ssm get-parameter --name emr_etl_runner.access_key_id --region eu-central-1 --with-decryption  | jq '.Parameter.Value' | sed 's/"//g')
EMR_AWS_SECRET_ACCESS_KEY=$(aws ssm get-parameter --name emr_etl_runner.secret_access_key --region eu-central-1 --with-decryption  | jq '.Parameter.Value' | sed 's/"//g')

export AWS_ACCESS_KEY_ID=$EMR_AWS_ACCESS_KEY_ID
export AWS_SECRET_ACCESS_KEY=$EMR_AWS_SECRET_ACCESS_KEY


## Make sure we run EmrEtlRunner as the snowplow user
exec gosu snowplow:snowplow ${SNOWPLOW_BIN_PATH}/snowplow-emr-etl-runner run \
 --config /snowplow/config/config.yml \
 --targets file:/snowplow/config/targets/ \
 --resolver file:/snowplow/config/resolvers/iglu_resolver.json
