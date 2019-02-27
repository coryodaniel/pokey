FROM alpine

WORKDIR /app
COPY ./entrypoint.sh .

ENTRYPOINT ["/app/entrypoint.sh"]
