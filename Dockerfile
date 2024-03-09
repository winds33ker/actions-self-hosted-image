FROM ubuntu:22.04

ARG RUNNER_VERSION="2.314.1"
ARG DEBIAN_FRONTEND=noninteractive

RUN apt update -y && apt upgrade -y && useradd -m docker
RUN apt install -y --no-install-recommends \
    curl \
    jq \
    build-essential \
    libssl-dev \
    libffi-dev \
    python3 \
    python3-venv \
    python3-dev \
    python3-pip

# For ARM64
#RUN cd /home/docker && mkdir actions-runner && cd actions-runner \
#    && curl -O -L https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-arm64-${RUNNER_VERSION}.tar.gz \
#    && tar xzf ./actions-runner-linux-arm64-${RUNNER_VERSION}.tar.gz

RUN cd /home/docker && mkdir actions-runner && cd actions-runner \
    && curl -O -L https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz \
    && tar xzf ./actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz

RUN chown -R docker ~docker && chown -R docker /home/docker/actions-runner/bin/installdependencies.sh

COPY bin/start.sh start.sh
RUN chmod +x start.sh

USER docker
ENTRYPOINT ["./start.sh"]
