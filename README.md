# How to create github actions self-hosted runners

- run following commands in terminal

```bash
docker build --build-arg="RUNNER_VERSION=2.314.1" -t runner-image .
docker run \
-d \
--env ORGANIZATION="<your org>" \
--env ACCESS_TOKEN="<your token>" \
--name runner \
runner-image
```
