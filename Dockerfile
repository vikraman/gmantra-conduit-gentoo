FROM vikraman/gentoo

MAINTAINER HackCave

# Initial configuration
ADD config/make.conf /etc/portage/
ADD config/gentoo.conf /etc/portage/repos.conf/
ADD config/package.use /etc/portage/package.use/default
ADD config/package.license /etc/portage/package.license/default
ADD config/package.accept_keywords /etc/portage/package.accept_keywords/default

RUN \
  echo 'Asia/Kolkata' > /etc/timezone && \
  eselect locale set en_US.utf8 && \
  eselect python set python3.3 && \
  emerge --sync && \
  emerge -uDN @world

# docker, fleet
RUN \
 emerge gentoo-sources && \
 make -C /usr/src/linux defconfig && \
 emerge app-emulation/docker app-admin/fleet

# jdk
RUN wget --no-check-certificate --header \
  "Cookie: oraclelicense=accept-securebackup-cookie" \
  https://download.oracle.com/otn-pub/java/jdk/8u40-b26/jdk-8u40-linux-x64.tar.gz \
  -O /usr/portage/distfiles/jdk-8u40-linux-x64.tar.gz && \
  chown portage:portage /usr/portage/distfiles/jdk-8u40-linux-x64.tar.gz && \
  emerge dev-java/oracle-jdk-bin

# sbt
ADD https://raw.githubusercontent.com/paulp/sbt-extras/master/sbt \
  /usr/local/bin/
RUN chmod a+rx /usr/local/bin/sbt

# sass
RUN emerge dev-ruby/sass

# httpie
RUN emerge net-misc/httpie
