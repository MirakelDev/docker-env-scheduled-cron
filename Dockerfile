FROM debian:bookworm

RUN set -xe && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
    cron \
    gettext-base \
    # Remove package lists for smaller image sizes
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /etc/cron.*/*

COPY crontab.template /crontab.template
COPY entrypoint.sh /entrypoint.sh

# Adding executable permissions
RUN chmod +x /entrypoint.sh

# Default cron schedule
ENV CRON_SCHEDULE="* * * * *"

ENTRYPOINT ["/entrypoint.sh"]

CMD ["cron","-f"]
