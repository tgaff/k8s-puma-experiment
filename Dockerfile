FROM ruby:3.2.1-alpine
RUN apk update && apk add build-base

# Only rebuild gem bundle if Gemfile changes
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copy over the rest of the files
COPY . .

# Open up port and start the service
EXPOSE 9292
CMD bundle exec rackup app.ru -o 0.0.0.0
