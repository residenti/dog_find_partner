FROM ruby:2.6

RUN mkdir /dog_find_partner
ENV APP_ROOT /dog_find_partner
WORKDIR $APP_ROOT

RUN apt-get update -qq && \
  apt-get install -y nodejs --no-install-recommends && \
  apt-get install -y default-mysql-client --no-install-recommends && \
  apt-get install -y locales && locale-gen ja_JP.UTF-8 && \
  curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update && \
  apt-get install -y yarn && \
  gem install bundler

ADD ./Gemfile $APP_ROOT/Gemfile
ADD ./Gemfile.lock $APP_ROOT/Gemfile.lock

RUN bundle install
