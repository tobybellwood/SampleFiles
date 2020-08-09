FROM amazeeio/php:7.3-fpm-v1.8.1

RUN apk add --no-cache --update clamav clamav-libunrar --repository http://dl-cdn.alpinelinux.org/alpine/edge/main/ \
    && freshclam

COPY .docker/images/php/00-govcms.ini /usr/local/etc/php/conf.d/
COPY --from=cli /app /app
COPY .docker/sanitize.sh /app/sanitize.sh

RUN /app/sanitize.sh \
  && rm -rf /app/sanitize.sh