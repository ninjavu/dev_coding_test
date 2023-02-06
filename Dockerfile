FROM ruby:3.2.0

RUN bash -c "set -o pipefail && apt update \
  && apt install -y --no-install-recommends build-essential curl git libpq-dev \
  && curl -sSL https://deb.nodesource.com/setup_18.x | bash - \
  && curl -sSL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo 'deb https://dl.yarnpkg.com/debian/ stable main' | tee /etc/apt/sources.list.d/yarn.list \
  && apt update && apt install -y --no-install-recommends nodejs yarn \
  && rm -rf /var/lib/apt/lists/* /usr/share/doc /usr/share/man \
  && apt clean"

RUN mkdir /app
WORKDIR /app

ENV RAILS_ENV="production"
ENV NODE_ENV="production"

COPY Gemfile Gemfile.lock ./
RUN bundle install
RUN yarn install
COPY . .

RUN NODE_OPTIONS=--openssl-legacy-provider ./bin/webpack

EXPOSE 3000
CMD ["rails", "s", "-b", "0.0.0.0"]
