# Load environment variables from .env file
-include .env

# Suppress "Entering directory" messages
MAKEFLAGS += --no-print-directory

# Basic application configuration
APP_NAME := app
BIN_DIR := bin
CMD_DIR := cmd/app

# Build commands for different platforms
# Standard build command for current platform
GO_BUILD := go build -o $(BIN_DIR)/$(APP_NAME)
# Windows-specific build command with proper extension
GO_BUILD_WIN := GOOS=windows GOARCH=amd64 go build -o $(BIN_DIR)/$(APP_NAME).exe

# Frontend directory structure
FRONTEND_DIR := internal/frontend
STATIC_DIR := $(FRONTEND_DIR)/static
CSS_DIR := $(STATIC_DIR)/css

# Tailwind CSS configuration
TAILWIND_CONFIG := $(FRONTEND_DIR)/tailwind.config.js
TAILWIND_INPUT := $(CSS_DIR)/style.css
TAILWIND_OUTPUT := $(CSS_DIR)/tailwind.css
TAILWIND_CMD := tailwindcss -c $(TAILWIND_CONFIG) -i $(TAILWIND_INPUT) -o $(TAILWIND_OUTPUT)

# Templ development proxy configuration
PROXY_FLAGS := --proxy=http://localhost:$(APP_PORT) --proxyport=$(TEMPL_PROXY_PORT) --proxybind="0.0.0.0" --open-browser=false

# Build and run the application for current platform
build:
	@$(GO_BUILD) $(CMD_DIR)/main.go

# Start templ in watch mode for development
templ:
	@templ generate --watch $(PROXY_FLAGS)

# Utility to notify templ proxy of changes
notify-templ-proxy:
	@templ generate --notify-proxy --proxyport=$(TEMPL_PROXY_PORT) 2>/dev/null || true

# Start Tailwind CSS in watch mode for development
css:
	@$(TAILWIND_CMD) --watch

# Development command that runs all necessary services concurrently
run:
	@templ generate > /dev/null 2>&1
	@concurrently \
		--names "templ,css,air" \
		--prefix-colors "blue,red,yellow" \
		--kill-signal SIGINT \
		--kill-others-on-fail \
		--handle-input \
		"make templ" \
		"make css" \
		"air"

# Docker-based development environment
dev:
	@set -e; \
	docker build --build-arg ENVIRONMENT=development -t goth-image .; \
	docker run -it \
		-p $(APP_PORT):$(APP_PORT) \
		-p $(TEMPL_PROXY_PORT):$(TEMPL_PROXY_PORT) \
		-v $(shell pwd):/app \
		goth-image; \
	until curl --silent --fail http://localhost:$(TEMPL_PROXY_PORT) 2>/dev/null; do \
		sleep 1; \
	done

# Declare which targets are not files
.PHONY: build build-win build-gui templ notify-templ-proxy css run dev