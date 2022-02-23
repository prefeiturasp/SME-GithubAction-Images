FROM python:3.6.15-bullseye

RUN useradd -d /runner --uid=1002 runner \
    && echo 'runner:runner' | chpasswd \
    && groupadd docker --gid=999 \
    && usermod -aG docker runner \
    && mkdir /runner && cd /runner \
    && chown -Rf runner:runner /runner \
    && apt update && apt install -y docker docker.io

WORKDIR /runner

COPY entrypoint.sh requirements.txt /runner/

ENV PATH="$PATH:/runner/.local/bin"
ENV PIP_CACHE_DIR /runner/.cache/pip
ENV PYTHONPATH /runner

RUN chmod +x /runner/entrypoint.sh && chown -Rf runner:runner /runner

USER runner

RUN pip install -r /runner/requirements.txt 

ENTRYPOINT ["/runner/entrypoint.sh"]
