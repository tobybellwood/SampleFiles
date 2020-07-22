ARG NODE_VERSION
ARG ALPINE_VERSION
ARG IMAGE_REPO
FROM node:12.16.1-alpine3.11

LABEL maintainer="amazee.io"
ENV LAGOON=node

ARG LAGOON_VERSION
ENV LAGOON_VERSION=$LAGOON_VERSION

RUN chmod g+w /etc/passwd \
    && mkdir -p /home \
    && mkdir -p /app

ENV TMPDIR=/tmp \
    TMP=/tmp \
    HOME=/home \
    # When Bash is invoked via `sh` it behaves like the old Bourne Shell and sources a file that is given in `ENV`
    ENV=/home/.bashrc \
    # When Bash is invoked as non-interactive (like `bash -c command`) it sources a file that is given in `BASH_ENV`
    BASH_ENV=/home/.bashrc

RUN apk update \
    && apk upgrade \
    && rm -rf /var/cache/apk/*

# Make sure Bower and NPM are allowed to be running as root
RUN echo '{ "allow_root": true }' > /home/.bowerrc \
    && echo 'unsafe-perm=true' > /home/.npmrc

WORKDIR /app

EXPOSE 3000

# tells the local development environment on which port we are running
ENV LAGOON_LOCALDEV_HTTP_PORT=3000

CMD ["yarn", "run", "start"]
