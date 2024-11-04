FROM alpine:edge
LABEL maintainer="c012vu5:c012vu5@gmail.com"
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
LABEL description="Image to Create certfile with dns01 challenge on mydns."
COPY --chmod=500 --chown=root:root entrypoint.sh /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
RUN apk add --no-cache certbot
RUN apk add --no-cache php83
RUN apk add --no-cache php83-mbstring
RUN apk add --no-cache php83-openssl
RUN wget 'https://github.com/disco-v8/DirectEdit/archive/master.zip' -O /DirectEdit-master.zip
RUN unzip -d / /DirectEdit-master.zip
RUN rm -rf /*.zip
RUN chmod 700 /DirectEdit-master/*.php
RUN chmod 600 /DirectEdit-master/*.conf
RUN sed -i 's:/usr/bin/php$:/usr/bin/php83:' /DirectEdit-master/txtdelete.php
RUN sed -i 's:/usr/bin/php$:/usr/bin/php83:' /DirectEdit-master/txtregist.php
WORKDIR /tmp
