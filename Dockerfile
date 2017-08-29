FROM ubuntu:latest 

RUN apt-get -y update && \
    apt-get -y install python-pip virtualenv 

ARG ENGINE_NAME='sqlite'

ARG ENGINE=''

ARG NAME=''

ARG USER=''

ARG PASSWORD=''

ARG HOST=''

ARG PORT=''

ENV ENGINE_NAME=${ENGINE_NAME}

ENV ENGINE=${ENGINE}

ENV NAME=${NAME}

ENV USER=${USER}

ENV PASSWORD=${PASSWORD}

ENV HOST=${HOST}

ENV PORT=${PORT}

ENV WEBAPPSRC ./webapp

ENV WEBAPPDEST /srv/webapp

ENV WEBAPPHOME /srv

RUN mkdir -p WEBAPPDEST

COPY $WEBAPPSRC $WEBAPPHOME  

RUN  virtualenv  $WEBAPPHOME 

RUN . $WEBAPPHOME/bin/activate 

RUN pip install --upgrade pip

WORKDIR $WEBAPPHOME

RUN pip install -r $WEBAPPHOME/requirements.txt

EXPOSE 8000

COPY ./docker-entrypoint.sh .

RUN chmod ug+x ./docker-entrypoint.sh 

ENTRYPOINT ["./docker-entrypoint.sh"]

