FROM --platform=linux/amd64 alpine:3.18

LABEL org.opencontainers.image.source = "https://github.com/Tandashi/knockoutcity-server-docker"
LABEL org.opencontainers.image.description = "A Docker Container Image that runs a Knockout City Private Server"

COPY --chmod=0755 entrypoint.sh entrypoint.sh

RUN apk add wine

ENTRYPOINT ["sh", "entrypoint.sh"]
