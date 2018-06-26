FROM ruby:2.4-alpine

LABEL maintainer="roustem@1password.com"

ENV HUGO_VERSION=0.42.1
ENV HUGO_DOWNLOAD_URL=https://github.com/spf13/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz

RUN apk add --update --no-cache --virtual build-dependencies

RUN apk add --update --no-cache \
		bash \
		build-base \
		ca-certificates \
		curl \
		git \
		libcurl \
		libxml2-dev \
		libxslt-dev \
		openssh \
		rsync \
		nodejs \
		wget && \
	gem install \
		html-proofer \
		nokogiri \
		sass \
	--no-document && \
	npm i -g websync \
	apk del build-dependencies && \
	rm /var/cache/apk/*

RUN wget "$HUGO_DOWNLOAD_URL" && \
	tar xzf hugo_${HUGO_VERSION}_Linux-64bit.tar.gz && \
	mv hugo /usr/bin/hugo && \
	rm hugo_${HUGO_VERSION}_Linux-64bit.tar.gz LICENSE README.md

CMD ["htmlproofer","--help"]

EXPOSE 1313
