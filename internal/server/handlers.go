package server

import (
	"net/http"

	"github.com/labstack/echo/v4"
	"github.com/nelsonfalves/goth-template/internal"
)

func staticFilesHandler() echo.HandlerFunc {
	return echo.WrapHandler(http.FileServer(http.FS(internal.StaticFiles)))
}

func pageHandler(renderFunc func(w http.ResponseWriter, r *http.Request) error) echo.HandlerFunc {
	return func(c echo.Context) error {
		return renderFunc(c.Response().Writer, c.Request())
	}
}
