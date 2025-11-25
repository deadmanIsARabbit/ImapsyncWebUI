## Dockerfile ofr building a docker imapsync image with WebUI

# docker build -t mrickl/imapsyncwithwebui

#Documentation cooming Soon

FROM debian:stable

LABEL   maintainer="deadmanIsARabbit" \
        description="Imapsync with WebUI"

RUN set -xe                 && \
  apt-get update            && \
  apt-get install -y           \
  libauthen-ntlm-perl          \
  libcgi-pm-perl               \
  libcrypt-openssl-rsa-perl    \
  libdata-uniqid-perl          \
  libencode-imaputf7-perl      \
  libfile-copy-recursive-perl  \
  libfile-tail-perl            \
  libio-socket-inet6-perl      \
  libio-socket-ssl-perl        \
  libio-tee-perl               \
  libhtml-parser-perl          \
  libjson-webtoken-perl        \
  libmail-imapclient-perl      \
  libparse-recdescent-perl     \
  libmodule-scandeps-perl      \
  libreadonly-perl             \
  libregexp-common-perl        \
  libsys-meminfo-perl          \
  libterm-readkey-perl         \
  libtest-mockobject-perl      \
  libtest-pod-perl             \
  libunicode-string-perl       \
  liburi-perl                  \
  libwww-perl                  \
  libtest-nowarnings-perl      \
  libtest-deep-perl            \
  libtest-warn-perl            \
  make                         \
  cpanminus                    \
  wget                         \
  curl                         \
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

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

#ENTRYPOINT [ "entrypoint.sh"]
EXPOSE 80
CMD ["lighttpd", "-D", "-f", "etc/lighttpd/lighttpd.conf"]