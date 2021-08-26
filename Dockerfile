FROM alpine

ADD v2 /v2
RUN apk add --no-cache curl libc6-compat python3  && chmod +x /v2/start.sh

CMD sh /v2/start.sh

