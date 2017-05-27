FROM python:2.7
MAINTAINER John Pfeiffer "https://github.org/johnpfeiffer"

# https://cloud.google.com/sdk/docs/quickstart-linux
env VERSION 156.0.0
run echo ${VERSION}

RUN curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
RUN apt-get update
RUN apt-get install -y lsb-release

# https://cloud.google.com/sdk/docs/quickstart-debian-ubuntu
RUN export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)" && \
  echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
RUN apt-get update && apt-get install -y google-cloud-sdk
RUN gcloud --version

