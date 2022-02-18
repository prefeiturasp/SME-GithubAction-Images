FROM python:3.6.15-bullseye

RUN useradd -d /runner --uid=1002 runner \
    && echo 'runner:runner' | chpasswd \
    && groupadd docker --gid=999 \
    && usermod -aG docker runner \
    && mkdir /runner \
    && chown -Rf runner:runner /runner

WORKDIR /runner

COPY entrypoint.sh /runner/

RUN chmod +x /runner/entrypoint.sh && chown -Rf runner:runner /runner
    
ENV PATH="$PATH:/github/home/.local/bin"

USER runner

ENTRYPOINT ["/runner/entrypoint.sh"]
