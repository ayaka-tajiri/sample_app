FROM ruby:2.7.5

ARG UID=1000
ARG GID=1000

RUN apt-get update -y && apt-get install -y sudo

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list && \
    sudo apt -y update && sudo apt -y install yarn

RUN addgroup --gid ${GID} rails_app \
    && adduser --system --uid ${UID} --gid ${GID} --shell /bin/bash --home /app rails_app

USER ${UID}:${GID}

WORKDIR /app

COPY --chown=rails_app:rails_app . /app/

RUN gem install rails -v 6.0.4 && gem install bundler -v 2.2.17
RUN bundle _2.2.17_ config set --local without 'production' && bundle _2.2.17_ install

RUN yarn install

