FROM ubuntu:14.04

MAINTAINER Lukas Fülling <lerk@lerk.io>

ARG VCS_REF

LABEL org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/lfuelling/rr-docker"

VOLUME ["/root/source", "/root/cache"]

# Install packages
RUN apt-get update && apt-get -y upgrade && apt-get -y install git-core python gnupg flex bison gperf libsdl1.2-dev libesd0-dev libwxgtk2.8-dev squashfs-tools build-essential zip curl libncurses5-dev zlib1g-dev openjdk-7-jre openjdk-7-jdk pngcrush schedtool libxml2 libxml2-utils xsltproc lzop libc6-dev schedtool g++-multilib lib32z1-dev lib32ncurses5-dev lib32readline-gplv2-dev gcc-multilib liblz4-* pngquant ncurses-dev texinfo gcc gperf patch libtool automake g++ gawk subversion expat libexpat1-dev python-all-dev binutils-static libgcc1 bc libcloog-isl-dev libcap-dev autoconf libgmp-dev build-essential gcc-multilib g++-multilib pkg-config libmpc-dev libmpfr-dev lzma* liblzma* w3m phablet-tools android-tools-adb screen maven tmux

# Set up ccache
RUN cd /root && git clone https://git.samba.org/ccache.git && cd ccache && ./autogen.sh && ./configure && make && cp -v ./ccache /usr/bin/ccache

# Set up repo
RUN mkdir -p /root/bin
RUN curl https://storage.googleapis.com/git-repo-downloads/repo > /root/bin/repo
RUN chmod a+x /root/bin/repo

# Set locale to utf-8
RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && locale-gen en_US.utf8 && /usr/sbin/update-locale LANG=en_US.UTF-8

# Set envs
ENV PATH="/root/bin:${PATH}"
ENV USE_CCACHE="1"
ENV CCACHE_DIR="/root/cache"
ENV LANG="en_US.UTF-8"

# Add build script
ADD build.sh /root/build.sh
RUN chmod +x /root/build.sh

CMD /root/build.sh


