FROM registry.gitlab.com/gitlab-org/build/cng/gitlab-toolbox-ee:v19.2.0

# switch to root user
USER root

# Install PostgreSQL 18 client tools
RUN apt-get update && \
    apt-get install -y wget gnupg2 lsb-release && \
    echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list && \
    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - && \
    apt-get update && \
    apt-get remove -y postgresql-client-17 && \
    apt-get install -y postgresql-client-18 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Revert to the original user
USER git

ENTRYPOINT ["/scripts/entrypoint.sh", "/usr/local/bin/process-wrapper.sh"]
