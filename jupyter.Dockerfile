# customer docker image for lighterweight python/jupyter environment
FROM python:3.13-alpine

# -y answers yes to any installation prompts
RUN apk update && apk add --no-cache build-base python3-dev postgresql-dev linux-headers
RUN pip install pandas sqlalchemy psycopg2 jupyter

WORKDIR /app

# run jupyter on 8888
ENTRYPOINT [ "jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]