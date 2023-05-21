FROM --platform=linux/amd64 scottyhardy/docker-wine

LABEL org.opencontainers.image.source = "https://github.com/Tandashi/knockoutcity-server-docker"
LABEL org.opencontainers.image.description = "A Docker Container Image that runs a Knockout City Private Server"

COPY entrypoint.sh entrypoint.sh

ENTRYPOINT ["bash", "entrypoint.sh"]
