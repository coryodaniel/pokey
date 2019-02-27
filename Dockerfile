FROM curl

WORKDIR /app
COPY ./entrypoint.sh .

ENTRYPOINT ["/app/entrypoint.sh"]
