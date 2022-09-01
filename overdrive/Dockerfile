FROM ubuntu:latest

# Prep
RUN mkdir /Audiobooks \
    && mkdir -p /Audiobooks/history/successes \
    && mkdir -p /Audiobooks/history/failures
RUN mkdir -p /Ebooks/backups \
    && mkdir -p /Ebooks/history/failures \
    && mkdir -p /Ebooks/history/successes

# Update
RUN apt-get update -y
RUN apt-get install -y curl wget uuid-runtime libxml2-utils libc-bin openssl coreutils python3

# Get binaries from github
RUN curl https://chbrown.github.io/overdrive/overdrive.sh -o /bin/overdrive \
    && chmod +x /usr/bin/overdrive
RUN wget https://github.com/BentonEdmondson/knock/releases/download/1.2.0/knock-1.2.0-x86_64-linux -O /usr/bin/knock \
    && chmod +x /usr/bin/knock

# Add scripts
COPY ./scripts /Scripts
RUN chmod +x -R /Scripts

ENTRYPOINT ["/Scripts/monitor2"]