FROM pythonL3.7-alpine
MAINTAINER Ian

ENV PYTHONUNBUFFERED 1 

COPY ./requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

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