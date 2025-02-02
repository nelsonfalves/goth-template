package config

import (
	"log"
	"os"
	"strings"

	"github.com/joho/godotenv"
	"github.com/nelsonfalves/goth-template"
)

func LoadEnvironmentVariables() {
	if err := godotenv.Load(); err != nil {
		envMap, err := godotenv.Parse(strings.NewReader(goth.EmbeddedEnv))
		if err != nil {
			log.Fatalf("failed to parse embedded .env: %v", err)
		}
		for key, value := range envMap {
			os.Setenv(key, value)
		}
	}
}
