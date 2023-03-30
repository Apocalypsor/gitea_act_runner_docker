# gitea_act_runner_docker

Step 1: Create file `runner`
```bash
touch runner && chmod 777 runner
```

Step 2:
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

