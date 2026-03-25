FROM alpine:3.14

RUN mkdir /dot

COPY ./hashjack.png /dot

RUN chmod 666 /dot/hashjack.png

RUN apk add --update --no-cache graphviz ttf-dejavu \
  && addgroup -g 1000 dot \
  && adduser -u 1000 -G dot -s /bin/sh -D dot

USER 1000

WORKDIR /dot

CMD ["dot", "-Tpng"]