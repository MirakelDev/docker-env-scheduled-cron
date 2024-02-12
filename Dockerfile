FROM debian:bookworm

RUN apt-get update \
    && apt-get --no-install-recommends -y install cron gettext-base \
    # Remove package lists for smaller image sizes
    && rm -rf /var/lib/apt/lists/* \
    && which cron \
    && rm -rf /etc/cron.*/*

COPY crontab.template /crontab.template
COPY entrypoint.sh /entrypoint.sh

# Adding executable permissions
RUN chmod +x /entrypoint.sh /crontab.template

ENTRYPOINT ["/entrypoint.sh"]

CMD ["cron","-f"]
