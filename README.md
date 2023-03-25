# gitea_act_runner_docker

```yaml
version: "3"

services:
  runner:
    container_name: gitea-runner
    image: ghcr.io/apocalypsor/act_runner:latest
    network_mode: "host"
    restart: always
    environment:
      - GITEA_URL=
      - TOKEN=
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - ./runner:/runner/.runner

```

