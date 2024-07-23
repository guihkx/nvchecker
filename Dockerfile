FROM alpine:3.20

LABEL org.opencontainers.image.source=https://github.com/guihkx/nvchecker
LABEL org.opencontainers.image.description="Slim container made with the sole purpose of running nvchecker"
LABEL org.opencontainers.image.licenses=MIT

WORKDIR /data

ENV PIPX_BIN_DIR=/usr/bin

RUN apk add --no-cache python3 \
    # curl, xmlstarlet: required by IRPF_*_XMLs sources
    # jq: required by the GPU-Z source
    curl jq xmlstarlet

RUN apk add --no-cache --virtual .build-deps build-base curl-dev pipx python3-dev && \
    pipx install nvchecker[jq]~=2.15 && \
    apk del .build-deps && \
    rm -rf ~/.cache ~/.local/share/pipx/shared ~/.local/state

RUN nvchecker --version

ENTRYPOINT ["nvchecker"]
