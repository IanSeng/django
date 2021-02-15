FROM python:3.7-alpine
MAINTAINER Ian

ENV PYTHONUNBUFFERED 1 

COPY ./requirements.txt /requirements.txt
RUN apk add --update --no-cache postgresql-client
RUN apk add --update --no-cache --virtual .tmp-build-deps \
        gcc libc-dev linux-headers postgresql-dev
RUN pip install -r /requirements.txt
RUN apk del .tmp-build-deps

# Create app file in docker image and switch file to app dic 
# Then it copy project code into docker image
RUN mkdir /app 
WORKDIR /app
COPY ./app /app

# Create user and switch to user
# -D is to run the processor for the project
# This is for security purposes so that the image will not
# run in the root account.
RUN adduser -D user
USER user