FROM golang:1.23.2-alpine

# Variáveis de ambiente para controlar o comportamento
ARG ENVIRONMENT=development
ENV ENVIRONMENT=${ENVIRONMENT}

RUN apk update && apk add --no-cache \
    npm \
    make

WORKDIR /app

RUN npm install -g concurrently
RUN npm install -g tailwindcss

RUN go install github.com/a-h/templ/cmd/templ@latest
RUN go install github.com/air-verse/air@latest

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN npm ci

EXPOSE 8080
EXPOSE 8081

CMD ["sh", "-c", "if [ \"$ENVIRONMENT\" = \"development\" ]; then make run; else make build; fi"]

