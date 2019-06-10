FROM ruby:2.6.3
ENV LANG C.UTF-8

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - && apt-get update && apt-get install -y nodejs --no-install-recommends && rm -rf /var/lib/apt/lists/*

RUN gem install bundler

RUN mkdir /home/git
RUN mkdir /home/git/askfp