#!/bin/sh
cd /

set -e
RB_ROOT=${RB_ROOT:-/var/www/reviewboard}

wait-for db:3306 -t 60

if [ ! -e $RB_ROOT/conf/settings_local.py ]; then
    db-init.py

    rb-site install \
            --noinput \
            --domain-name="${RB_DOMAIN:-localhost}" \
            --company="$RB_COMPANY" \
            --site-root=/ \
            --static-url=static/ \
            --media-url=media/ \
            --db-type="mysql" \
            --db-name="$DB_NAME" \
            --db-host="db" \
            --db-user="$DB_USER" \
            --db-pass="$DB_PASSWORD" \
            --cache-type=memcached \
            --cache-info="memcached" \
            --web-server-type=lighttpd \
            --web-server-port=8000 \
            --admin-user="$RB_ADMIN" \
            --admin-password="$RB_ADMIN_PASSWORD" \
            --admin-email="$RB_ADMIN_EMAIL" \
            $RB_ROOT

    cat << EOF >> $RB_ROOT/conf/settings_local.py

LOGGING = {
    'version': 1,
    'disable_existing_loggers': False,
    'handlers': {
        'console': {
            'class': 'logging.StreamHandler',
        },
    },
    'loggers': {
        'djblets': {
            'handlers': ['console'],
            'level': 'INFO',
        },
    },
}
EOF

fi

exec uwsgi --ini /etc/reviewboard/uwsgi.ini #TODO: run uwsgi as restricted user