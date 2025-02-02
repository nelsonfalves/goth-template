package server

import (
	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
)

func RegisterRoutes() *echo.Echo {
	e := echo.New()

	e.Use(middleware.Recover())

	e.GET("/frontend/static/*", staticFilesHandler())
	e.GET("/", pageHandler(home))

	return e
}
