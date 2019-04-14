FROM ubuntu:latest
MAINTAINER ikubaku <hide4d51@gmail.com>

ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /opt/build

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y build-essential cmake bison flex libffi-dev libxml2-dev libgdk-pixbuf2.0-dev libcairo2-dev libpango1.0-dev fonts-lyx ruby bundler

COPY Gemfile .
RUN bundler install --path vendor/bundle && \
    bundler exec asciidoctor-pdf-cjk-kai_gen_gothic-install

CMD ["bundler", "exec", "asciidoctor-pdf", "-r", "asciidoctor-pdf-linewrap-ja", "-r", "asciidoctor-bibliography", "-r", "asciidoctor-mathematical", "-r", "asciidoctor-pdf-cjk-kai_gen_gothic", "-a", "pdf-style=KaiGenGothicJP", "/opt/build/src/main.adoc"]
