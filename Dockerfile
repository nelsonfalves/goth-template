# Use Go 1.23.2 with Alpine as the base image for a minimal footprint
FROM golang:1.23.2-alpine

# Install system dependencies
# npm: Required for frontend tooling
# make: Required for running Makefile commands
RUN apk add --no-cache \
   npm \
   make

# Install development tools globally
# concurrently: Run multiple commands in parallel
# tailwindcss: CSS framework
# templ: Go HTML templating
# air: Live reload for Go
RUN npm install -g concurrently tailwindcss@3.4.17 && \
   go install github.com/a-h/templ/cmd/templ@latest && \
   go install github.com/air-verse/air@latest

# Set working directory for the application
WORKDIR /app

# Copy Go dependency files first to leverage Docker cache
COPY go.mod go.sum ./
RUN go mod download

# Copy and install frontend dependencies
COPY internal/frontend/package*.json internal/frontend/
WORKDIR /app/internal/frontend
RUN npm ci
WORKDIR /app

# Copy the rest of the application code
COPY . .

# Expose ports for the application and development proxy
EXPOSE 8080 8081

# Start the development environment
CMD ["make", "run"]