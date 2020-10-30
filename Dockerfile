FROM node:10-alpine3.11

LABEL maintainer="EdwinBetanc0urt@outlook.com" \
	description="Proxy ADempiere API RESTful"

ARG BASE_VERSION="rt-1.0"

ENV VS_ENV=prod \
	REPO_NAME="proxy-adempiere-api" \
	URL_REPO="https://github.com/adempiere/proxy-adempiere-api/archive" \
	BINARY_NAME="proxy-adempiere-api-$BASE_VERSION"

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
	yarn install --no-cache && \	
	apk del .build-deps

WORKDIR /var/www/proxy-adempiere-api/

CMD ["/usr/local/bin/proxy-api.sh"]