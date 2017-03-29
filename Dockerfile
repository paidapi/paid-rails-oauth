FROM heroku/cedar

RUN cd /tmp && git clone https://github.com/heroku/heroku-buildpack-ruby
ENV HOME=/app
WORKDIR /app

ENV CURL_CONNECT_TIMEOUT=0 CURL_TIMEOUT=0 GEM_PATH="$HOME/vendor/bundle/ruby/2.2.0:$GEM_PATH" LANG=${LANG:-en_US.UTF-8} PATH="$HOME/bin:$HOME/vendor/bundle/bin:$HOME/vendor/bundle/ruby/2.2.0/bin:$PATH" RACK_ENV=${RACK_ENV:-production} RAILS_ENV=${RAILS_ENV:-production} RAILS_LOG_TO_STDOUT=${RAILS_LOG_TO_STDOUT:-enabled} RAILS_SERVE_STATIC_FILES=${RAILS_SERVE_STATIC_FILES:-enabled} SECRET_KEY_BASE=${SECRET_KEY_BASE:-bb51f4c214fc56dd24509502d85fc5fcac2f3fd800e80de95b49076e3eac976c26216cbf4a2a9c6f05536dc2d3ae7ca7ec8fc0d4b201dc4e9f23138d43963432} STACK=cedar-14 

ARG BUNDLE_WITHOUT=development:test

# This is to install sqlite for any ruby apps that need it
# This line can be removed if your app doesn't use sqlite3
RUN apt-get update && apt-get install sqlite3 libsqlite3-dev && apt-get clean

COPY . /app

RUN output=$(/tmp/heroku-buildpack-ruby/bin/compile /app /tmp/cache) || echo $output
