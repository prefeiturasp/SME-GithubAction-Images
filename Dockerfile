FROM mcr.microsoft.com/dotnet/sdk:5.0

RUN useradd -d /runner --uid=1000 runner \
    && echo 'runner:runner' | chpasswd \
    && groupadd docker --gid=999 \
    && usermod -aG docker runner
    
COPY entrypoint.sh /runner/

RUN chmod +x /runner/entrypoint.sh \
    && chown -Rf runner:runner /runner && apt-get update && \
    apt-get install -y gnupg jq


RUN wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.asc.gpg && \
    mv microsoft.asc.gpg /etc/apt/trusted.gpg.d/ && \
    wget -q https://packages.microsoft.com/config/debian/10/prod.list && \
    mv prod.list /etc/apt/sources.list.d/microsoft-prod.list && \
    chown root:root /etc/apt/trusted.gpg.d/microsoft.asc.gpg && \
    chown root:root /etc/apt/sources.list.d/microsoft-prod.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends default-jre apt-transport-https aspnetcore-runtime-2.1 mono-complete && \
    apt-get install -y --no-install-recommends python3 python3-distutils python3-pip python3-setuptools && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/* && \
    apt-get autoremove -y

USER runner

RUN dotnet tool install dotnet-sonarscanner --tool-path /runner

ENV PATH="$PATH:/runner"

WORKDIR /runner
