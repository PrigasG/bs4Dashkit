# Navbar status badge

Navbar status badge

## Usage

``` r
dash_nav_status_badge(
  label,
  status = c("success", "primary", "secondary", "info", "warning", "danger", "light",
    "dark"),
  icon = NULL,
  class = NULL
)
```

## Arguments

- label:

  Badge label.

- status:

  Bootstrap status color. One of `"primary"`, `"secondary"`,
  `"success"`, `"info"`, `"warning"`, `"danger"`, `"light"`, or
  `"dark"`.

- icon:

  Optional Font Awesome icon name or simple
  [`shiny::icon()`](https://rdrr.io/pkg/shiny/man/icon.html) tag.

- class:

  Additional classes.

## Value

A `shiny.tag` badge suitable for wrapping in
[`dash_nav_item()`](https://PrigasG.github.io/bs4Dashkit/reference/dash_nav_item.md).
