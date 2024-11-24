package main

import (
	"log"
	"os"

	_ "github.com/joho/godotenv/autoload"
	"github.com/nelsonfalves/goth-template/internal/server"
)

func main() {
	port := os.Getenv("APP_PORT")
	if port == "" {
		log.Fatal("APP_PORT environment variable not set")
	}

	e := server.RegisterRoutes()

	log.Printf("Running server on port %s...", port)
	if err := e.Start(":" + port); err != nil {
		log.Fatal(err)
	}
}
