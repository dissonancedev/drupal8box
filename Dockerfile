FROM phusion/baseimage:0.9.19

###########################
### Basic configuration ###
###########################

RUN locale-gen  en_US.UTF-8
ENV LANG        en_US.UTF-8
ENV LC_ALL      en_US.UTF-8
ENV PHP_OPCACHE enabled
ENV TERM        xterm
ENV TZ          Europe/Copenhagen

########################
### Install software ###
########################

# Update system and add MariaDB
RUN \
    DEBIAN_FRONTEND=noninteractive apt-get update && apt-get -y -q install software-properties-common && \
    add-apt-repository ppa:ondrej/php && \
    apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8 && \
    add-apt-repository 'deb [arch=amd64,i386,ppc64el] http://ftp.utexas.edu/mariadb/repo/10.1/ubuntu xenial main'

# Add nginx repos
RUN \
    curl http://nginx.org/keys/nginx_signing.key | apt-key add - && \
    echo "deb http://nginx.org/packages/mainline/ubuntu/ xenial nginx" | tee -a /etc/apt/sources.list && \
    echo "deb-src http://nginx.org/packages/mainline/ubuntu/ xenial nginx" | tee -a /etc/apt/sources.list && \
    apt-get update

# PHP-FPM and other basic packages
RUN \
    DEBIAN_FRONTEND=noninteractive apt-get install --allow-unauthenticated -y -q git nano postfix \
    nginx mariadb-client mariadb-server \
    php7.0 php7.0-fpm php7.0-cli php7.0-curl php7.0-mysql php7.0-mbstring php7.0-xml php7.0-zip php7.0-gd php7.0-imap php7.0-dev \
    libpcre3-dev imagemagick build-essential memcached && \
    apt-get clean -y -q && rm -rf /var/lib/apt/lists/*

#####################
### Configure box ###
#####################

# Manage all configuration
COPY root /

WORKDIR /app

# Port forwarding
EXPOSE 80 443

###############
### Launch! ###
###############

# Start the services
RUN chmod +x /entrypoint/run.sh
ENTRYPOINT ["/entrypoint/run.sh"]
