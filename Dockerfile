FROM vikraman/gentoo

MAINTAINER HackCave

# Initial configuration
ADD config/make.conf /etc/portage/
ADD config/gentoo.conf /etc/portage/repos.conf/

RUN \
  echo 'Asia/Kolkata' > /etc/timezone && \
  eselect locale set en_US.utf8 && \
  emerge --sync && \
  emerge -uDN @world
