Proxy ADempiere-API
==============

<div align="center">
	<img src="https://camo.githubusercontent.com/911c5d54ded447403e56de3f96f332c06bceb8bd/68747470733a2f2f75706c6f61642e77696b696d656469612e6f72672f77696b6970656469612f636f6d6d6f6e732f622f62312f4164656d70696572652d6c6f676f2e706e67" style="text-align:center;" width="400" />
</div>

![version](https://img.shields.io/badge/node-v10.x-blue.svg)
![Branch Develop](https://img.shields.io/badge/dev%20branch-develop-blue.svg)
<a href="http://slack.vuestorefront.io">![Join Slack](https://img.shields.io/badge/community%20chat-slack-FF1493.svg)</a>

### What is?
A simple proxy for synchronize ADempiere Backend based on [ADempiere-gRPC-Server](https://github.com/adempiere/adempiere-gRPC-Server) with any frontend using api REST ans GraphQL.


### For all enviroment you should run the follow images:
- ADempiere gRPC: https://hub.docker.com/r/erpya/adempiere-grpc-all-in-one
```shell
docker pull erpya/adempiere-grpc-all-in-one
```
- Proxy ADempiere API: https://hub.docker.com/r/erpya/proxy-adempiere-api
```shell
docker pull erpya/proxy-adempiere-api
```
- ADempiere Vue: https://hub.docker.com/r/erpya/adempiere-vue
```shell
docker pull erpya/adempiere-vue
```

## Run Docker Container

Build docker image (for development only):
```shell
    docker build -t erpya/proxy-adempiere-api:dev -f ./Dockerfile .
```

Download latest docker image:
```shell
    docker pull erpya/proxy-adempiere-api
```

Run with default connection:
```shell
docker run -it -d \
	--name Proxy-ADempiere-API \
	-p 8085:8085 \
	-e AD_DEFAULT_HOST="localhost" \
	-e AD_DEFAULT_PORT="50059" \
	-e VS_ENV="dev" \
	erpya/proxy-adempiere-api
```


## Environment variables for the configuration

* **`VS_ENV`**: Indicates the startup mode in which the RESTful proxy service will start, by default its value is `prod`, the other value is `dev`.
* **`SERVER_HOST`**: Indicates the port in which the RESTful proxy service will be initiated, by default its value is `localhost`. Make sure that it is set to the same value as the TCP port of the container.
* **`SERVER_PORT`**: Indicates the listening port of the RESTful proxy service, by default its value is `8085`. Make sure that it is set to the same value as the TCP port of the container.
* **`AD_DEFAULT_HOST`**: Specifies the host to point to the gRPC service, by default its value is `localhost`. All hosts pointing to gRPC services will take the value you set for this environment variable unless you set a value to overwrite the specific service.
* **`AD_DEFAULT_PORT`**: Specifies the listening port to point to the gRPC service, by default its value is `50059`. All ports to be pointed to from gRPC services will take the value you set for this environment variable unless you set a value to overwrite the specific service.
* **`AD_ACCESS_HOST`**: If not set it takes the value of `AD_DEFAULT_HOST`, it is used to indicate the host for the adempiere access grpc service.
* **`AD_ACCESS_PORT`**: If not set it takes the value of `AD_DEFAULT_PORT`, it is used to indicate the port for the adempiere access grpc service.
* **`AD_BUSINESS_HOST`**: If not set it takes the value of `AD_DEFAULT_HOST`, it is used to indicate the host for the adempiere business data grpc service.
* **`AD_BUSINESS_PORT`**: If not set it takes the value of `AD_DEFAULT_PORT`, it is used to indicate the port for the adempiere business data grpc service.
* **`AD_DICTIONARY_HOST`**: If not set it takes the value of `AD_DEFAULT_HOST`, it is used to indicate the host for the adempiere dictionary grpc service.
* **`AD_DICTIONARY_PORT`**: If not set it takes the value of `AD_DEFAULT_PORT`, it is used to indicate the port for the adempiere dictionary grpc service.
* **`AD_STORE_ACCESS_HOST`**: If not set it takes the value of `AD_DEFAULT_HOST`, it is used to indicate the host for the adempiere access store grpc service.
* **`AD_STORE_ACCESS_PORT`**: If not set it takes the value of `AD_DEFAULT_PORT`, it is used to indicate the port for the adempiere access store grpc service.
* **`AD_STORE_HOST`**: If not set it takes the value of `AD_DEFAULT_HOST`, it is used to indicate the host for the adempiere store data grpc service.
* **`AD_STORE_PORT`**: If not set it takes the value of `AD_DEFAULT_PORT`, it is used to indicate the port for the adempiere store data grpc service.
* **`ES_HOST`**: Indicates the host to point to where the elastic search service is, by default its value is `localhost`.
* **`ES_PORT`**: Indicates the listening port of the elastic search service to be pointed to, by default its value is `9200`.
* **`API_URL_IMAGES`**: By default its value is `localhost`.
* **`API_HTTP_BASED`**: By default its value is `false`.
* **`STORE_URL_IMAGES`**: By default its value is `localhost`.
* **`STORE_HTTP_BASED`**: By default its value is `false`.
* **`AD_TOKEN`**: ADempiere access token.
* **`AD_STORE_TOKEN`**: Store access token.
