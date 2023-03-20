FROM --platform=${BUILDPLATFORM} golang:alpine AS build

WORKDIR /src
ENV CGO_ENABLED=0
COPY act_runner .
ARG TARGETOS
ARG TARGETARCH
RUN GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -o /out/act_runner .

FROM alpine
LABEL maintainer="sudo@dov.moe"

ENV GITEA_URL="" \
    TOKEN=""

COPY --from=build /out/act_runner /act_runner
RUN chmod +x /act_runner

CMD /act_runner register --instance ${GITEA_URL} --token ${TOKEN} --no-interactive \
    && /act_runner daemon
