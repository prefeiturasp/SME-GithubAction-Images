FROM debian:buster
COPY config_template /runner/
COPY entrypoint.sh /runner/
    
RUN useradd -d /runner --uid=1000 runner \
    && echo 'runner:runner' | chpasswd \
    && groupadd docker --gid=999 \
    && usermod -aG docker runner 
    
RUN chmod +x /runner/entrypoint.sh \
    && chown -Rf runner:runner /runner

USER runner
WORKDIR /runner

ENTRYPOINT ["/runner/entrypoint.sh"]
