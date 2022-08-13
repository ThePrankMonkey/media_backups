FROM ubuntu:latest

RUN apt-get update -y
RUN apt-get install -y curl uuid-runtime libxml2-utils libc-bin openssl coreutils
RUN curl https://chbrown.github.io/overdrive/overdrive.sh -o /bin/overdrive
RUN chmod +x /bin/overdrive

RUN mkdir /Audiobooks
WORKDIR /Audiobooks

ENTRYPOINT ["tail", "-f", "/dev/null"]