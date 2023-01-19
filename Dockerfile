FROM python:3.8.10-buster

RUN useradd -d /runner --uid=1002 runner \
    && echo 'runner:runner' | chpasswd \
    && groupadd docker --gid=999 \
    && usermod -aG docker runner \
    && mkdir /runner \
    && chown -Rf runner:runner /runner \
    && apt update && apt install -y docker docker.io

WORKDIR /runner

COPY entrypoint.sh /runner/

RUN chmod +x /runner/entrypoint.sh && chown -Rf runner:runner /runner
    
ENV PATH="$PATH:/github/home/.local/bin"

USER runner

ENTRYPOINT ["/runner/entrypoint.sh"]
