FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y \
    apache2 \
    php \
    libapache2-mod-php \
    php-mysql \
    python3 \
    python3-pip \
    ffmpeg \
    curl \
    mysql-client \
    && apt clean

COPY seguridad-ssl.conf /etc/apache2/sites-available/seguridad-ssl.conf
RUN a2ensite seguridad-ssl.conf
COPY seguridad-http.conf /etc/apache2/sites-available/seguridad-http.conf
RUN a2dissite 000-default.conf
RUN a2ensite seguridad-http.conf

RUN pip3 install pyserial requests

RUN a2enmod rewrite ssl

WORKDIR /app

COPY . /app

RUN rm -rf /var/www/html/* && \
    cp -r /app/config/web/* /var/www/html/

RUN mkdir -p /var/www/html/videos

EXPOSE 80 443

RUN chmod +x /app/entrypoint.sh

CMD ["/app/entrypoint.sh"]
