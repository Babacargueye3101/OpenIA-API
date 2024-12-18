FROM ruby:3.2.1-slim

RUN apt-get update && apt-get install -qq -y --no-install-recommends \
    build-essential git libpq-dev libvips pkg-config

RUN useradd boawebuser
# bundle install
COPY Gemfile Gemfile.lock /tmp/
WORKDIR /tmp
RUN bundle install --binstubs --without test \
    bundle update rotp

ENV INSTALL_PATH /boa_ai_engine
ENV ENVIRONMENT production
ENV RAILS_ENV production
ENV RAILS_LOG_TO_STDOUT true
ENV PORT 3000

RUN mkdir -p $INSTALL_PATH
WORKDIR $INSTALL_PATH

COPY . ./
