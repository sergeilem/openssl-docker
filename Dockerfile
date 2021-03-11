FROM debian:buster-slim as build
WORKDIR /usr/src
RUN apt update && apt install -y build-essential gcc wget git cmake unzip perl

RUN git clone https://github.com/openssl/openssl
WORKDIR /usr/src/openssl
RUN ./config shared no-ssl3 no-idea no-srp no-weak-ssl-ciphers no-psk --prefix=/usr/gostssl --openssldir=/usr/gostssl
RUN make all && make install

FROM debian:buster-slim
COPY --from=build /usr/gostssl /usr/gostssl
