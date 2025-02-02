package main

import (
	_ "embed"
	"log"
	"os"

	"github.com/nelsonfalves/goth-template/internal/config"
	"github.com/nelsonfalves/goth-template/internal/server"
)

func init() {
	config.LoadEnvironmentVariables()
}

func main() {
	port := os.Getenv("APP_PORT")
	if port == "" {
		log.Fatal("APP_PORT environment variable not set")
	}

	e := server.RegisterRoutes()

	if err := e.Start(":" + port); err != nil {
		log.Fatal(err)
	}
}
