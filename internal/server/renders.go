package server

import (
	"net/http"

	"github.com/a-h/templ"
	"github.com/nelsonfalves/goth-template/internal/frontend/templates"
)

func Render(w http.ResponseWriter, r *http.Request, component templ.Component) error {
	return component.Render(r.Context(), w)
}

func home(w http.ResponseWriter, r *http.Request) error {
	return Render(w, r, templates.BaseLayout(templates.Home(), "Home"))
}
