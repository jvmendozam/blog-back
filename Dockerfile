FROM ruby:2.5.7

# throw errors if Gemfile has been modified since Gemfile.lock
RUN apt-get update && apt-get install -y \
  build-essential

RUN bundle config --global frozen 1

RUN mkdir -p /traveling_girls_api

WORKDIR /traveling_girls_api
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN gem install bundler
RUN bundle install

COPY . ./

EXPOSE 3000

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
