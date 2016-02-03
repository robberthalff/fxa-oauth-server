FROM mhart/alpine-node:4

RUN apk add --update --virtual build-dependencies \
    git make gcc g++ python

VOLUME ["/app/config" ]

COPY bin /app/bin
COPY config /app/config
COPY coverage /app/coverage
COPY grunttasks /app/grunttasks
COPY lib /app/lib
COPY scripts /app/scripts
ADD CHANGELOG.md /app/CHANGELOG.md
ADD LICENSE /app/LICENSE
ADD README.md /app/README.md
ADD package.json /app/package.json
ADD npm-shrinkwrap.json /app/npm-shrinkwrap.json

ENV NODE_ENV=prod

ENV ISSUER=api.accounts.test.com
ENV VERIFICATION_URL=https://verifier.accounts.test.com/v2
ENV CONTENT_URL=https://accounts.test.com/oauth/
ENV DB=memory
ENV DB_AUTO_UPDATE_CLIENTS=false
ENV LOG_LEVEL=info
ENV CREATE_MYSQL_SCHEMA=
ENV MYSQL_USERNAME=
ENV MYSQL_PASSWORD+
ENV MYSQL_DATABASE=
ENV MYSQL_HOST=
ENV MYSQL_PORT=
ENV PUBLIC_URL=http://127.0.0.1:9010
ENV HOST=127.0.0.1
ENV PORT=9010
ENV HOST_INTERNAL=127.0.0.1
ENV PORT_INTERNAL=9011

EXPOSE 3030

WORKDIR /app

RUN npm i

RUN apk del build-dependencies && \
    rm -rf /tmp/* /var/cache/apk/* /root/.npm /root/.node-gyp

ENTRYPOINT exec npm start