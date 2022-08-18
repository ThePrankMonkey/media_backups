FROM ubuntu:latest

RUN apt-get update -y
RUN apt-get install -y ffmpeg libavcodec-dev mediainfo x264 x265 bc
RUN apt-get install -y git wget

# mp4v2-utils was removed from newer Ubuntu, but Bionic should still work
# Requires libmp4v2-2 as a dependency
#  https://packages.ubuntu.com/bionic/amd64/libmp4v2-2/download
#  https://packages.ubuntu.com/bionic/amd64/mp4v2-utils/download
RUN wget http://mirrors.kernel.org/ubuntu/pool/universe/m/mp4v2/libmp4v2-2_2.0.0~dfsg0-6_amd64.deb \
    && wget http://mirrors.kernel.org/ubuntu/pool/universe/m/mp4v2/mp4v2-utils_2.0.0~dfsg0-6_amd64.deb \
    && dpkg -i libmp4v2-2_2.0.0~dfsg0-6_amd64.deb \
    && dpkg -i mp4v2-utils_2.0.0~dfsg0-6_amd64.deb \
    && rm -rf libmp4v2*.deb mp4v2-utils*.deb

RUN mkdir -p /usr/app/inaudible-tables
RUN git clone https://github.com/inAudible-NG/tables.git /usr/app/inaudible-tables

# RUN mkdir -p /usr/app/audible-cli
# RUN git clone https://github.com/mkb79/audible-cli.git /usr/app/audible-cli

RUN mkdir -p /usr/app/aaxtomp3
RUN git clone https://github.com/KrumpetPirate/AAXtoMP3.git /usr/app/aaxtomp3
ENV PATH "/usr/app/aaxtomp3:$PATH"

RUN mkdir /Audiobooks
WORKDIR /Audiobooks

ENTRYPOINT ["tail", "-f", "/dev/null"]