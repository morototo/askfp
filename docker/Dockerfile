FROM ruby:2.6.3
ENV LANG C.UTF-8

RUN apt-get update -qq && apt-get install -y \
    build-essential \
    nodejs \
 && rm -rf /var/lib/apt/lists/*

RUN gem install bundler

RUN mkdir /home/git
RUN mkdir /home/git/askfp