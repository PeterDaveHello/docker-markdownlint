FROM node:16-alpine3.11

ARG MARKDOWNLINT_CLI_VER
ENV npm_config_loglevel=silent

LABEL name="docker-markdownlint"
LABEL maintainer="Peter Dave Hello <hsu@peterdavehello.org>"

LABEL version="$MARKDOWNLINT_CLI_VER"

WORKDIR /md

RUN npm install -g markdownlint-cli@"$MARKDOWNLINT_CLI_VER" && \
	rm -rf ~/.npm && \
	markdownlint --help

CMD [ "markdownlint", "--help" ]
