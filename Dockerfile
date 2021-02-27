FROM ruby:2.7.2

RUN bundle config --global frozen 1

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

EXPOSE 4000

CMD ["bundle" , "exec", "jekyll", "server", "-w", "--drafts", "-H", "0.0.0.0", "-P", "4000"]
