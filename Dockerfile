FROM debian:buster
COPY config_template /runner/
COPY entrypoint.sh /runner/

RUN apt-get update \
    && apt-get install -y -q curl
    
RUN useradd -d /runner --uid=1000 runner \
    && echo 'runner:runner' | chpasswd \
    && groupadd docker --gid=999 \
    && usermod -aG docker runner \
    && curl -LO https://dl.k8s.io/release/v1.21.0/bin/linux/amd64/kubectl \
    && mv ./kubectl /usr/local/bin/ \
    && mkdir /runner/.kube \
    && chmod +x /usr/local/bin/kubectl

RUN chmod +x /runner/entrypoint.sh \
    && chown -Rf runner:runner /runner

USER runner
WORKDIR /runner

ENTRYPOINT ["/runner/entrypoint.sh"]
