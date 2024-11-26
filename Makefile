-include .env

build:
	@go build -o ./bin/main cmd/main.go
	@bin/main

templ:
	@templ generate --watch --proxy=http://localhost:$(APP_PORT) --proxyport=$(TEMPL_PROXY_PORT) --open-browser=true --proxybind="0.0.0.0"

notify-templ-proxy:
	@templ generate --notify-proxy --proxyport=$(TEMPL_PROXY_PORT)

css:
	@tailwindcss -i internal/static/css/style.css -o internal/static/css/tailwind.css --watch

run:
	@concurrently "make templ" "make css" "air"

dev:
	@set -e; \
	docker build --build-arg ENVIRONMENT=development -t goth-image .; \
	docker run -d -p 8080:8080 -p 8081:8081 -v $(shell pwd):/app goth-image; \
	until curl --silent --fail http://localhost:8081; do \
		sleep 1; \
	done; \
	xdg-open http://localhost:8081 > /dev/null 2>&1 &

docker-build:
	@set -e; \
	docker build --build-arg ENVIRONMENT=production -t goth-image .; \
	docker run -d -p 8080:8080 goth-image; \
	until curl --silent --fail http://localhost:8080; do \
		sleep 1; \
	done; \
	xdg-open http://localhost:8080 > /dev/null 2>&1 &
