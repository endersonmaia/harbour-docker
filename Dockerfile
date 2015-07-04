FROM debian

MAINTAINER Enderson Maia <endersonmaia@gmail.com>

RUN apt-get -y update \
    && apt-get install -y  \
        bash \
        binutils \
        curl \
        debhelper \
        fakeroot \
        gcc \
        git \
        libbz2-dev \
        libcurl3-dev \
        libexpat1-dev \
        libncurses-dev \
        libpcre3-dev \
        libslang2-dev \
        libsqlite3-dev \
        libssl-dev \
        upx \
        valgrind \
        zlib1g-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN curl -L http://sourceforge.net/projects/harbour-project/files/source/3.0.0/harbour-3.0.0.tar.gz/download -o harbour-3.0.0.tar.gz \
   && tar -xzf harbour-3.0.0.tar.gz \
   && cd harbour-3.0.0 \
   &&  HB_BUILD_3RDEXT=no \
    HB_BUILD_CONTRIBS=xhb \
    HB_INSTALL_PREFIX=/usr/local \
    HB_WITH_CURL=/usr/include \
    HB_WITH_CURSES=/usr/include \
    HB_WITH_OPENSSL=/usr/include \
    HB_WITH_PCRE=/usr/include \
    HB_WITH_SLANG=/usr/include \
    HB_WITH_ZLIB=/usr/include \
    make \
    && make install \
    && ldconfig -f /usr/local/etc/ld.so.conf.d/harbour.conf \
    && cd - \
    && rm -rf harbour-3.0.0.tar.gz harbour-3.0.0

RUN apt-get -y remove \
    libbz2-dev \
    libcurl3-dev \
    libexpat1-dev \
    libncurses-dev \
    libpcre3-dev \
    libslang2-dev \
    libsqlite3-dev \
    libssl-dev \
    zlib1g-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY docker-entrypoint.sh /

ENTRYPOINT [ "/docker-entrypoint.sh" ]

CMD [ "harbour", "--help" ]