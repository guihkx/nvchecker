FROM alpine:edge

LABEL org.opencontainers.image.source=https://github.com/guihkx/nvchecker
LABEL org.opencontainers.image.description="Slim container made with the sole purpose of running nvchecker"
LABEL org.opencontainers.image.licenses=MIT

WORKDIR /data

RUN apk add --no-cache \
    -X https://dl-cdn.alpinelinux.org/alpine/edge/testing \
    nvchecker~=2.14.1 \
    # curl, xmlstarlet: required by IRPF_*_XMLs sources
    curl xmlstarlet

RUN nvchecker --version

ENTRYPOINT ["nvchecker"]
