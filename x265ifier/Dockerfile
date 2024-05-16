FROM linuxserver/ffmpeg:latest

# Prep
RUN mkdir -p /Files/input \
    && mkdir -p /Files/output \
    && mkdir -p /Files/processed \
    && mkdir -p /Files/errors

# Update
RUN apt-get update -y \
    && apt-get install -y python3 python3-pip
RUN pip3 install humanfriendly

# Add scripts
COPY ./scripts /Scripts
RUN chmod +x -R /Scripts

ENTRYPOINT ["python3", "/Scripts/monitor"]
# ENTRYPOINT ["tail", "-f", "/dev/null"]