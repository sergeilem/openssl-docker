FROM ubuntu:latest as build
WORKDIR /usr/src
RUN apt update && apt install -y build-essential gcc wget git cmake unzip perl

RUN git clone https://github.com/openssl/openssl
WORKDIR /usr/src/openssl
RUN ./config shared no-ssl3 no-idea no-srp no-weak-ssl-ciphers no-psk --prefix=/usr/gostssl --openssldir=/usr/gostssl
RUN make build_libs && make build_programs && make install_sw

FROM ubuntu:latest
COPY --from=build /usr/gostssl /usr/gostssl
