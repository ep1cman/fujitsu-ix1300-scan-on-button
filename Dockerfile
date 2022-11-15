FROM debian:bullseye-slim
RUN apt-get update && apt-get upgrade -y && \
    apt install \
        git \
        sane \
        sane-utils \
        scanbd \
        git \
        imagemagick \
        netpbm \
        ghostscript \
        poppler-utils \
        imagemagick \
        util-linux \
        parallel \
        units \
        bc -y
WORKDIR /app
RUN git clone https://github.com/rocketraman/sane-scan-pdf.git
RUN mkdir /scans

#Add the scanner VID:PID
RUN   echo "usb 0x04c5 0x162c" >> /etc/sane.d/fujitsu.conf
RUN   echo "usb 0x04c5 0x162c" >> /etc/scanbd/fujitsu.conf

COPY scanbd.conf /etc/scanbd/scanbd.conf
COPY scan.sh /etc/scanbd/scripts/scan.sh

VOLUME /scans

CMD scanbd -d1 -f
