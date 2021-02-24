#
# Mount the following drives as volumes:
#   - /root/Dropbox
#   - /root/.dropbox
#

FROM ubuntu:latest AS build

ADD http://www.dropbox.com/download?plat=lnx.x86_64 /tmp/dropbox.tar.gz
RUN tar -C /tmp -xzf /tmp/dropbox.tar.gz

FROM ubuntu:latest

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

RUN apt-get update -y
RUN apt-get install -y libc6 \
    libglapi-mesa \
    libxdamage1 \
    libxfixes3 \
    libxcb-glx0 \
    libxcb-dri2-0 \
    libxcb-dri3-0 \
    libxcb-present0 \
    libxcb-sync1 \
    libxshmfence1 \
    libxxf86vm1 \
    libglib2.0-0 \
    libsm6 \
    libxrender1 \
    libxext6

COPY --from=build /tmp/.dropbox-dist /opt/dropbox

CMD ["/opt/dropbox/dropboxd"]
