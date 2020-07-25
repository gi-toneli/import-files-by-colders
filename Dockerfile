FROM ruby:2.6.5

RUN apt-get install -y apt-transport-https ca-certificates
RUN apt-get install -y apt-transport-https ca-certificates

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get install -y yarn

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client yarn
RUN mkdir /import-files-by-colders
WORKDIR /import-files-by-colders
COPY Gemfile /import-files-by-colders/Gemfile
COPY Gemfile.lock /import-files-by-colders/Gemfile.lock

COPY . /import-files-by-colders

RUN gem install bundle
RUN bundle install
RUN yarn
RUN yarn install --check-files

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
