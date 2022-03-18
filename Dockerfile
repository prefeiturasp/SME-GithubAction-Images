FROM debian:bullseye

RUN useradd -d /runner --uid=1002 runner \
    && echo 'runner:runner' | chpasswd \
    && groupadd docker --gid=999 \
    && usermod -aG docker runner \
    && apt-get update \
    && apt-get install -y gnupg jq wget default-jre zip unzip git nodejs curl locales locales-all

WORKDIR /runner

RUN wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-4.7.0.2747-linux.zip \
    && unzip sonar-scanner-cli-4.7.0.2747-linux.zip \
    && rm sonar-scanner-cli-4.7.0.2747-linux.zip \
    && chmod +x /runner/sonar-scanner-4.7.0.2747-linux/bin/sonar-scanner \
    && ln -s /runner/sonar-scanner-4.7.0.2747-linux/bin/sonar-scanner /usr/local/bin/sonar-scanner \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/* \
    && apt-get autoremove -y
    
ENV LC_ALL pt_BR.UTF-8
ENV LANG pt_BR.UTF-8
ENV LANGUAGE pr_BR.UTF-8    
ENV PATH="$PATH:/runner"

COPY entrypoint.sh check-quality-gate.sh common.sh /runner/

RUN chmod +x /runner/entrypoint.sh /runner/check-quality-gate.sh /runner/common.sh && chown -Rf runner:runner /runner

USER runner

ENTRYPOINT ["/runner/entrypoint.sh"]
