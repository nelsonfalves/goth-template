package server

import (
	"net/http"

	"github.com/labstack/echo/v4"
	"github.com/nelsonfalves/goth-template"
)

func staticFilesHandler() echo.HandlerFunc {
	fsys, err := goth.StaticFiles()
	if err != nil {
		panic(err)
	}
	return echo.WrapHandler(http.StripPrefix("/frontend/static", http.FileServer(http.FS(fsys))))
}

func pageHandler(renderFunc func(w http.ResponseWriter, r *http.Request) error) echo.HandlerFunc {
	return func(c echo.Context) error {
		return renderFunc(c.Response().Writer, c.Request())
	}
}
