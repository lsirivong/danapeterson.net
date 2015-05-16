FROM ruby:2.2

MAINTAINER Lenny Sirivong <lenny@lenny-s.com>

# Install nodejs 0.12
RUN curl -sL https://deb.nodesource.com/setup_0.12 | bash - && \
  apt-get install -y \
    nodejs

##
# Install nginx

RUN apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-keys 573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62
RUN echo "deb http://nginx.org/packages/mainline/debian/ jessie nginx" >> /etc/apt/sources.list

ENV NGINX_VERSION 1.9.0-1~jessie

RUN apt-get update && \
    apt-get install -y ca-certificates nginx=${NGINX_VERSION} && \
    rm -rf /var/lib/apt/lists/*

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log

ADD config/container/nginx.conf /etc/nginx/nginx.conf

VOLUME ["/var/cache/nginx"]

# Install foreman
RUN gem install foreman

# Install Rails App
WORKDIR /app

ENV RAILS_ENV production

ENV WEB_PORT 80

ADD Gemfile /app/
ADD Gemfile.lock /app/

RUN bundle install --without development test --deployment --jobs=4

ADD . /app

EXPOSE 80 443

CMD bundle exec rake assets:precompile && bundle exec rake db:migrate && foreman start -f Procfile
