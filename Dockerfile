FROM ruby:2.5
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - \
        && apt-get install -y nodejs
RUN mkdir /personal-homepage
WORKDIR /personal-homepage
COPY Gemfile /personal-homepage/Gemfile
COPY Gemfile.lock /personal-homepage/Gemfile.lock
RUN bundle install
COPY . /personal-homepage
