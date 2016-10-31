FROM kokspflanze/centos-systemd:latest

MAINTAINER "KoKsPflaNzE" <kokspflanze@protonmail.com>

RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm

# normal updates
RUN yum -y update

# php && httpd
RUN yum -y install php70w php70w-opcache php70w-cli php70w-common php70w-gd php70w-intl php70w-mbstring php70w-mcrypt php70w-mysql php70w-pdo php70w-pear php70w-soap php70w-xml php70w-xmlrpc httpd

# tools
RUN yum -y install epel-release iproute at curl

# pagespeed
RUN curl -O https://dl-ssl.google.com/dl/linux/direct/mod-pagespeed-stable_current_x86_64.rpm
RUN rpm -U mod-pagespeed-*.rpm

# cleanup
RUN yum clean all

# we want some config changes
COPY config/php_settings.ini /etc/php.d/
COPY config/v-host.conf /etc/httpd/conf.d/

# create webserver-default directory
RUN mkdir -p /var/www/page/public

EXPOSE 80

RUN systemctl enable httpd

CMD ["/usr/sbin/init"]