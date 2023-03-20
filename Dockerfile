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
    TOKEN=""

COPY --from=build /out/act_runner /runner/act_runner
COPY start.sh /start.sh
RUN chmod +x /runner/act_runner /start.sh

ENTRYPOINT [ "/start.sh" ]
