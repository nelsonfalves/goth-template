package goth

import (
	"embed"
	"io/fs"
)

//go:embed .env
var EmbeddedEnv string

//go:embed internal/frontend/templates/*
var TemplateFiles embed.FS

//go:embed internal/frontend/static/*
var staticFilesEmbed embed.FS

func StaticFiles() (fs.FS, error) {
	return fs.Sub(staticFilesEmbed, "internal/frontend/static")
}
