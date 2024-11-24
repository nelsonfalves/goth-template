-include .env

build:
	@go build -o ./bin/main cmd/main/main.go

templ:
	@templ generate --watch --proxy=http://localhost:$(APP_PORT) --proxyport=$(TEMPL_PROXY_PORT) --open-browser=true --proxybind="0.0.0.0"

notify-templ-proxy:
	@templ generate --notify-proxy --proxyport=$(TEMPL_PROXY_PORT)

css:
	@tailwindcss -i internal/static/css/style.css -o internal/static/css/tailwind.css --watch

run:
	@concurrently "make templ" "make css" "air"

dev:
	@docker build -t goth-image .
	@docker run -d -p 8080:8080 -p 8081:8081 -v $(shell pwd):/app goth-image
	@sleep 1
	@xdg-open http://localhost:$(TEMPL_PROXY_PORT) > /dev/null 2>&1 &
