## Dockerfile ofr building a docker imapsync image with WebUI

# docker build -t mrickl/imapsyncwithwebui

#Documentation cooming Soon

FROM debian:stable

LABEL   maintainer="deadmanIsARabbit" \
        description="Imapsync with WebUI"


RUN sed -i 's/Components: main/Components: main contrib non-free-firmware non-free/g' /etc/apt/sources.list.d/debian.sources 

RUN set -xe &&                  \
  apt-get update &&             \
  apt-get install -y            \
  libauthen-ntlm-perl           \
  libcgi-pm-perl                \
  libcrypt-openssl-rsa-perl     \
  libdata-uniqid-perl           \
  libencode-imaputf7-perl       \
  libfile-copy-recursive-perl   \
  libfile-tail-perl             \
  libhttp-daemon-perl           \
  libhttp-daemon-ssl-perl       \
  libhttp-message-perl          \
  libio-socket-inet6-perl       \
  libio-socket-ssl-perl         \
  libio-tee-perl                \
  libhtml-parser-perl           \
  libjson-webtoken-perl         \
  libmail-imapclient-perl       \
  libmodule-scandeps-perl       \
  libnet-server-perl            \
  libnet-dns-perl               \
  libparse-recdescent-perl      \
  libproc-processtable-perl     \
  libreadonly-perl              \
  libregexp-common-perl         \
  libsys-meminfo-perl           \
  libterm-readkey-perl          \
  libtest-mockobject-perl       \
  libunicode-string-perl        \
  liburi-perl                   \
  libwww-perl                   \
  make                          \
  time                          \
  cpanminus                     \
  wget                          \
  curl                          \
  procps                        \
  lighttpd

ENV LIGHTHTTPD_RUN_USER www-data
ENV LIGHTHTTPD_RUN_GROUP www-data

RUN lighty-enable-mod cgi
RUN service lighttpd force-reload

RUN mkdir -p /usr/lib/cgi-bin
RUN rm -f /var/www/html/index.html

#always pull the latest version of imapsync
RUN curl https://raw.githubusercontent.com/imapsync/imapsync/master/imapsync > /usr/lib/cgi-bin/imapsync
RUN chmod +x /usr/lib/cgi-bin/imapsync

#copy the webui files
COPY html /var/www/html
RUN ln -s /var/www/html/imapsync_form_extra.html /var/www/html/index.html

EXPOSE 80
CMD ["lighttpd", "-D", "-f", "etc/lighttpd/lighttpd.conf"]