FROM python:3.6.15-bullseye

RUN useradd -d /github/home --uid=1002 runner \
    && echo 'runner:runner' | chpasswd \
    && groupadd docker --gid=999 \
    && usermod -aG docker runner \
    && mkdir /runner \
    && mkdir -p /github/home \
    && chown -Rf runner:runner /runner /github \
    && apt update && apt install -y docker docker.io

WORKDIR /github/home

COPY entrypoint.sh requirements.txt /runner/

ENV PATH="$PATH:/github/home/.local/bin"

RUN chmod +x /runner/entrypoint.sh

USER runner

RUN cd /github/home && pip install -r /runner/requirements.txt 

ENTRYPOINT ["/runner/entrypoint.sh"]
