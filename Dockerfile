FROM ubuntu:16.04
ENV ACCEPT_EULA=Y
RUN apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates curl apt-transport-https locales \
    && rm -rf /var/lib/apt/lists/* \
    && locale-gen "en_US.UTF-8" \
    && curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
    && curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list | tee /etc/apt/sources.list.d/msprod.list \
    && apt-get update \
    && apt-get install -y mssql-tools unixodbc-dev \
    && apt-get remove -y curl apt-transport-https ca-certificates \
    && apt-get autoremove -y \
    && apt-get clean \
    && apt-get autoclean \
    && rm -rf /var/lib/apt/lists/*
ENV PATH /opt/mssql-tools/bin:$PATH
ENV LANG="en_US.UTC-8"


ENTRYPOINT ["sqlcmd"]
