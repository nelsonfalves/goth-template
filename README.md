# GOTH Template Project

This project is designed to be a minimalist, barebones, and ready-to-go template for the GOTH stack, which has been gaining popularity for its efficiency in full stack development. The GOTH stack combines Golang, HTMX, Templ, Tailwind, and Air to create a seamless development experience.

## Technologies Used

-    **Golang** programming language, chosen for its simplicity and speed.
-    **Echo**, a high-performance web framework for Golang.
-    **HTMX**, a library that enables modern web interactivity without the need for a front-end framework.
-    **Templ** templating engine used to generate HTML views.
-    **Tailwind** for styling.
-    **Air** for live-reloading Go applications, speeding up development iterations.
-    **Docker** for containerizing the development environment and ensuring consistency across machines.

## Requirements

The only requirement needed to run everything is **Docker**.

## How to Use

First, clone the repository:

```sh
git clone https://github.com/nelsonfalves/goth-template.git
cd goth-template
```

To start the development container, use:

```sh
make dev
```

### Environment Variables

These are the default environment variables configured in the `.env` file, change them to suit your needs:

```
APP_PORT=8080
TEMPL_PROXY_PORT=8081
```

The project can then be accessed at:

-    **http://localhost:8080**: The default port for the application.
-    **http://localhost:8081**: The port for the Templ proxy (recommended during development, for all the hot reload benefits).
