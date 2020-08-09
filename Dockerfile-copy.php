FROM tobybellwood/php:v20.07-7.3-cli-drupal

RUN apk add --no-cache --update clamav clamav-libunrar --repository http://dl-cdn.alpinelinux.org/alpine/edge/main/ \
    && freshclam

COPY .docker/images/php/00-govcms.ini /usr/local/etc/php/conf.d/
COPY .docker/sanitize.sh /app/sanitize.sh

RUN /app/sanitize.sh \
  && rm -rf /app/sanitize.sh