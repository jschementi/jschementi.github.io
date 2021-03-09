setup:
	brew install wkhtmltopdf

resume.pdf:
	wkhtmltopdf --no-background --print-media-type http://0.0.0.0:4000/resume resume.pdf

dev:
	docker build -t jschementi.github.io .
	docker run -p 4000:4000 -it --rm jschementi.github.io

jekyll:
	bundle exec jekyll server -w --drafts -H 0.0.0.0 -P 4000

open:
	open http://localhost:4000

Gemfile.lock:
	docker run --rm -v "$(PWD)":/usr/src/app -w /usr/src/app ruby:2.7.2 bundle install

clean:
	rm -f resume.pdf
