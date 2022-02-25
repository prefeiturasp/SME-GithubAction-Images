FROM python:3.6.15-bullseye

RUN useradd -d /runner --uid=1002 runner \
    && echo 'runner:runner' | chpasswd \
    && groupadd docker --gid=999 \
    && usermod -aG docker runner \
    && mkdir /runner \
    && chown -Rf runner:runner /runner \
    && apt update && apt install -y docker docker.io

WORKDIR /runner

#requirements.txt gerado com o comando: pipenv lock --keep-outdated --requirements --dev > requirements.txt
#necessario corrigir os conflitos

COPY entrypoint.sh requirements.txt /runner/

ENV PATH="$PATH:/runner/.local/bin"
ENV PIP_CACHE_DIR /runner/.cache/pip

RUN chmod +x /runner/entrypoint.sh

USER runner

RUN cd /runner && pip install -r /runner/requirements.txt 

ENTRYPOINT ["/runner/entrypoint.sh"]
