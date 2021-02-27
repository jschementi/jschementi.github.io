dev:
	docker build -t jschementi.github.io .
	docker run -p 4000:4000 -it --rm jschementi.github.io
open:
	open http://localhost:4000

Gemfile.lock:
	docker run --rm -v "$(PWD)":/usr/src/app -w /usr/src/app ruby:2.7.2 bundle install
