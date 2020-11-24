FROM node:10-alpine3.11

LABEL maintainer="EdwinBetanc0urt@outlook.com" \
        description="Proxy ADempiere API RESTful"

ARG BASE_VERSION="rt-1.5"

ENV VS_ENV=prod \
        REPO_NAME="proxy-adempiere-api" \
        URL_REPO="https://github.com/adempiere/proxy-adempiere-api/archive" \
        BINARY_NAME="proxy-adempiere-api-$BASE_VERSION" \
        SERVER_HOST="localhost" \
        SERVER_PORT="8085" \
        ES_HOST="localhost" \
        ES_PORT="9200" \
        AD_TOKEN="adempiere_token" \
        AD_ACCESSHOST="localhost" \
        AD_BUSINESSHOST="localhost" \
        AD_DICTIONARYHOST="localhost" \
        AD_ACCESSAPIHOST="localhost" \
        AD_STOREHOST="localhost" \
        AD_STORETOKEN="adempiere_store_token"

RUN mkdir -p /var/www/ && \
        cd /var/www/ && \
        echo "nameserver 8.8.8.8" > /etc/resolv.conf && \
        apk --no-cache --update upgrade musl && \
        apk add --no-cache \
                        --repository http://dl-cdn.alpinelinux.org/alpine/edge/community \
                        --repository http://dl-cdn.alpinelinux.org/alpine/edge/main \
                        --virtual .build-deps \
                curl \
                git \
                python \
                make \
                g++ \
                ca-certificates \
                wget && \
        echo "Downloading ... $URL_REPO/$BASE_VERSION.zip" && \
        curl --output "$BINARY_NAME.zip" \
                -L "$URL_REPO/$BASE_VERSION.zip" && \
        unzip -o $BINARY_NAME.zip && \
        mv $BINARY_NAME $REPO_NAME && \
        rm $BINARY_NAME.zip && \
        cd $REPO_NAME && \
        cp -rf ./packages/default-vsf ./src/modules && \
        cp ./docker/proxy-api/proxy-api.sh /usr/local/bin/ && \
        cp ecosystem.json /var/www/  && \
        cp package.json /var/www/  && \
        cp tsconfig.json /var/www/  && \
        cp nodemon.json /var/www/  && \
        cp graphql-schema-linter.config.js /var/www/  && \
        cp tsconfig.build.json /var/www/  && \
        yarn install --no-cache && \
        apk del .build-deps

COPY default.json /var/www/proxy-adempiere-api/config


WORKDIR /var/www/proxy-adempiere-api/

CMD sed -i "s|SERVER_HOST|$SERVER_HOST|g"  /var/www/proxy-adempiere-api/config/default.json && \
    sed -i "s|SERVER_PORT|$SERVER_PORT|g"  /var/www/proxy-adempiere-api/config/default.json && \
    sed -i "s|ES_HOST|$ES_HOST|g"  /var/www/proxy-adempiere-api/config/default.json && \
    sed -i "s|ES_PORT|$ES_PORT|g"  /var/www/proxy-adempiere-api/config/default.json && \
    sed -i "s|adempiere_token|$AD_TOKEN|g"  /var/www/proxy-adempiere-api/config/default.json && \
    sed -i "s|adempiere_store_token|$AD_STORETOKEN|g"  /var/www/proxy-adempiere-api/config/default.json && \
    sed -i "s|AD_ACCESSHOST|$AD_ACCESSHOST|g"  /var/www/proxy-adempiere-api/config/default.json && \
    sed -i "s|AD_BUSINESSSHOST|$AD_BUSINESSHOST|g"  /var/www/proxy-adempiere-api/config/default.json && \
    sed -i "s|AD_DICTIONARYHOST|$AD_DICTIONARYHOST|g"  /var/www/proxy-adempiere-api/config/default.json && \
    sed -i "s|AD_ACCESSAPIHOST|$AD_ACCESSAPIHOST|g"  /var/www/proxy-adempiere-api/config/default.json && \
    sed -i "s|AD_STOREHOST|$AD_STOREHOST|g"  /var/www/proxy-adempiere-api/config/default.json && \
    sh /usr/local/bin/proxy-api.sh && tail -f /dev/null
