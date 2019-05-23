FROM phusion/passenger-full:1.0.5
ENV HOME /root

# Configurre Nginx
RUN rm -f /etc/service/nginx/down; rm /etc/nginx/sites-enabled/default
ADD docker/overlay/etc/nginx/sites-enabled/webapp.conf /etc/nginx/sites-enabled/webapp.conf

RUN echo 'Europe/Moscow' > /etc/timezone && \
apt-get update && \
apt-get install -y tzdata \
curl  \
postgresql-10 \
postgresql-contrib && \
rm /etc/localtime && \
ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
dpkg-reconfigure -f noninteractive tzdata && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD ["/sbin/my_init"]


# Copy app and install gems
RUN mkdir -p /home/app/webapp
WORKDIR /home/app/webapp
COPY --chown=app:app Gemfile Gemfile.lock ./
RUN gem install bundler &&  bundle config --global silence_root_warning 1 && bundle install --jobs 20 --retry 5 --deployment --without development test

COPY --chown=app:app . ./

EXPOSE 80

ENV RAILS_ENV=production \
    RAILS_SERVE_STATIC_FILES=true \
    RAILS_LOG_TO_STDOUT=true \
    DB_NAME=getnextid \
    DB_USER=getnextid \
    DB_PASSWORD=getnextid

COPY docker/overlay/ /
RUN chown -R app:app /home/app
RUN chmod +x /etc/my_init.d/*
