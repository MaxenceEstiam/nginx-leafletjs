FROM nginx:latest

ENV LEAFLET_URL="https://leafletjs-cdn.s3.amazonaws.com/content/leaflet/v1.7.1/leaflet.zip"
ENV LEAFLET_VERSION="1.7.1"

# Set variables
ENV \
    APPDIR="/usr/share/nginx/html"
    
# Basic build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE

LABEL io.continity.nginx-leafletjs=$BUILD_DATE

# Install packages
RUN apt-get update && \
    apt-get install --no-install-recommends -y \
    wget  \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Remove index.html
RUN rm ${APPDIR}/index.html

# add empty index.html
RUN touch ${APPDIR}/index.html

# Extract leaflet
RUN wget -nv -O /tmp/leaflet.zip ${LEAFLET_URL} &&\
    unzip -q /tmp/leaflet.zip -d ${APPDIR} &&\
    rm /tmp/leaflet.zip

RUN apt-get remove wget unzip -y \
  && rm -rf /var/lib/apt/lists/*
