FROM ubuntu:groovy

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y python3 python3-pip r-base

ADD requirements.txt /install/
ADD r-requirements.txt /install/
ADD install-requirements.R /install/
ADD squishimi /usr/local/bin/
ADD squishimi-r /usr/local/bin/

RUN cd /install && \
    Rscript install-requirements.R && \
    python3 -m pip install -r requirements.txt && \
    cd / && \
    rm -rf install

