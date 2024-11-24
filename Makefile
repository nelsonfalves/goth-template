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
	@docker build --build-arg ENVIRONMENT=development -t goth-image .
	@docker run -d -p 8080:8080 -p 8081:8081 -v $(shell pwd):/app goth-image
	@sleep 2
	@xdg-open http://localhost:$(TEMPL_PROXY_PORT) > /dev/null 2>&1 &

docker-build:
	@docker build --build-arg ENVIRONMENT=build -t goth-image .
	@docker run -d -p 8080:8080 goth-image
	@sleep 2
	@xdg-open http://localhost:8080 > /dev/null 2>&1 &
