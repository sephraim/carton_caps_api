FROM ruby:3.1.2
WORKDIR /app

# Install missing package(s)
RUN apt-get update -qq && apt-get install -yq --no-install-recommends \
    wait-for-it \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install gems
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copy main app files
COPY Rakefile config.ru  ./
COPY app app
COPY bin bin
COPY config config
COPY db db
COPY lib lib
COPY public public

# Set entrypoint (pre-server) script
COPY entrypoint.sh ./
RUN chmod +x entrypoint.sh
ENTRYPOINT ["./entrypoint.sh"]
EXPOSE 3000

# Run the server
COPY run.sh ./
RUN chmod +x run.sh
CMD ["./run.sh"]