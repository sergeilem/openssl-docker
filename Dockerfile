FROM ubuntu:rolling as build

ENV TZ=Europe/Moscow
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt update && apt install -y build-essential gcc wget git cmake unzip perl

WORKDIR /usr/src
RUN git clone https://github.com/openssl/openssl
WORKDIR /usr/src/openssl
RUN ./config shared no-ssl3 no-idea no-srp no-weak-ssl-ciphers no-psk --prefix=/usr/gostssl --openssldir=/usr/gostssl
RUN make build_libs && make build_programs && make install_sw

FROM ubuntu:rolling
COPY --from=build /usr/gostssl /usr/gostssl
