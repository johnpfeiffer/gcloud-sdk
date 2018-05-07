FROM python:2.7
MAINTAINER John Pfeiffer "https://github.org/johnpfeiffer"

# https://cloud.google.com/sdk/docs/quickstart-linux
ENV VERSION 200.0.0

RUN curl --silent https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
RUN apt-get update && \
  apt-get install -y lsb-release

# https://cloud.google.com/sdk/docs/quickstart-debian-ubuntu
RUN export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)" && \
  echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
RUN apt-get update && \
  apt-get install -y google-cloud-sdk

# https://golang.org/dl/
# https://github.com/docker-library/golang/blob/master/1.10/stretch/Dockerfile
ENV GOVERSION 1.10.0
RUN wget --quiet https://storage.googleapis.com/golang/go${GOVERSION}.linux-amd64.tar.gz && \
  tar -C /usr/local -xzf go${GOVERSION}.linux-amd64.tar.gz && \
  rm go${GOVERSION}.linux-amd64.tar.gz
ENV GOROOT /usr/local/go
ENV PATH=$PATH:$GOROOT/bin
ENV GOPATH /root
RUN gcloud --version && \
  go version

