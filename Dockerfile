FROM debian:buster

ENV DEBIAN_FRONTEND=noninteractive

COPY db-init.py /usr/local/bin/db-init.py
COPY wait-for.sh /usr/local/bin/wait-for
COPY uwsgi.ini /etc/reviewboard/uwsgi.ini
COPY docker-entrypoint.sh /docker-entrypoint.sh

RUN apt-get update && \
    apt-get install -y \
        netcat \
        build-essential \
        libffi-dev \
        libssl-dev \
        patch \
        python-dev \
        python-pip \
        python-setuptools \
        python-mysqldb \
        python-ldap && \
    pip install --no-cache-dir python-memcached && \
    pip install --no-cache-dir ReviewBoard && \
    pip install --no-cache-dir -U uwsgi && \
    pip install --no-cache-dir p4python && \
    chmod +x /usr/local/bin/db-init.py && \
    chmod +x /usr/local/bin/wait-for

ENV RB_DOMAIN=localhost \
    RB_COMPANY=example \
    RB_ADMIN=admin \
    RB_ADMIN_PASSWORD=admin \
    RB_ADMIN_EMAIL=admin@example.com \
    DB_NAME=reviewboard \
    DB_USER=reviewboard \
    DB_PASSWORD=reviewboard \
    DB_ROOT_PASSWORD=reviewboard \
    UWSGI_PROCESSES=8

VOLUME "/var/www"
EXPOSE 8000

CMD ["/docker-entrypoint.sh"]