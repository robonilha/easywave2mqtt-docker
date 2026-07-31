# easywave2mqtt-docker

Docker image for [Easywave2MQTT](https://github.com/marcselis/Easywave2MQTT), which bridges Eldat RX09 Easywave transceivers to MQTT for use with Home Assistant.

## How it works

The image is built from the upstream source at the tagged release version — no source is vendored here. A GitHub Actions workflow polls for new upstream releases daily and automatically builds and pushes a new image to Docker Hub when one is found. Image tags match the upstream release tags.

## Usage

```yaml
services:
  easywave2mqtt:
    image: <dockerhub-username>/easywave2mqtt:<version>
    devices:
      - /dev/ttyUSB0:/dev/ttyUSB0
    volumes:
      - ./appsettings.json:/app/appsettings.json
    restart: unless-stopped
```

Override the default configuration by mounting your own `appsettings.json` at `/app/appsettings.json`. See the [upstream repo](https://github.com/marcselis/Easywave2MQTT) for configuration options.

## Automated builds

Builds are triggered daily via a scheduled GitHub Actions workflow. A `VERSION` file in the repo tracks the last successfully built upstream release. You can also trigger a build manually via `workflow_dispatch`.

Required repository secrets: `DOCKER_USERNAME`, `DOCKER_PAT`.
