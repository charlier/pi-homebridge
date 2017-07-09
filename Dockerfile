FROM armhf/alpine

RUN apk --update upgrade && \
  apk add --no-cache --virtual .build-deps make git gcc g++ python && \
  apk add --no-cache nodejs openssl avahi-compat-libdns_sd avahi-dev dbus && \
  npm install -g --unsafe-perm homebridge && \
  npm install -g homebridge-sky-plus && \
  apk del .build-deps

COPY config.json /root/.homebridge/config.json

EXPOSE 5353 51826

COPY entrypoint.sh /root/

RUN chmod +x /root/entrypoint.sh

ENTRYPOINT ["/root/entrypoint.sh"]
CMD ["/usr/bin/homebridge"]
