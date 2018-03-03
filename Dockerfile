FROM debian:stretch-slim

RUN apt-get update \
	&& DEBIAN_FRONTEND=noninteractive apt-get install -qq --no-install-recommends wget ca-certificates \
	&& rm -rf /var/lib/apt/lists/*

ARG MAINNET_VERSION=0.14.15
ARG QTUM_VERSION=0.14.15
ARG QTUM_URL=https://github.com/qtumproject/qtum/releases/download/mainnet-ignition-v${MAINNET_VERSION}/qtum-${QTUM_VERSION}-x86_64-linux-gnu.tar.gz

RUN QTUM_DIST=$(basename $QTUM_URL) \
	&& wget -qO $QTUM_DIST $QTUM_URL \
	&& tar -xzvf $QTUM_DIST -C /usr/local --strip-components=1 --exclude=*-qt \
	&& rm qtum*

COPY entrypoint.sh /entrypoint.sh

RUN groupadd -r qtum && useradd -r -m -g qtum qtum
USER qtum

VOLUME /home/qtum

ENTRYPOINT ["/entrypoint.sh"]
CMD ["qtumd", "-upgradewallet"]
