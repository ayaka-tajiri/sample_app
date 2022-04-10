FROM ruby:2.7.5

RUN apt-get update -y && apt-get install -y sudo

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list && \
    sudo apt -y update && sudo apt -y install yarn

RUN gem install rails -v 6.0.4 && gem install bundler -v 2.2.17

WORKDIR /app

COPY ./Gemfile /app/Gemfile
COPY ./Gemfile.lock /app/Gemfile.lock

RUN bundle _2.2.17_ config set --local without 'production' && bundle _2.2.17_ install