FROM alpine

WORKDIR /app
COPY ./entrypoint.sh .

ENTRYPOINT ["entrypoint.sh"]
