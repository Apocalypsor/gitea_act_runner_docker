FROM --platform=${BUILDPLATFORM} golang:alpine AS build

WORKDIR /src
ENV CGO_ENABLED=0
COPY act_runner .
ARG TARGETOS
ARG TARGETARCH
RUN GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -o /out/act_runner .

FROM alpine
LABEL maintainer="sudo@dov.moe"

WORKDIR /runner

ENV GITEA_URL="" \
    TOKEN="" \
    RUNNER_NAME=""

COPY --from=build /out/act_runner /runner/act_runner
COPY start.sh /runner/
RUN chmod +x /runner/act_runner /runner/start.sh

ENTRYPOINT [ "/runner/start.sh" ]
