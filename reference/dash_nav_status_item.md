# Navbar status item (complete bs4Dash rightUi child)

Navbar status item (complete bs4Dash rightUi child)

## Usage

``` r
dash_nav_status_item(
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

A complete `<li class="nav-item dropdown">` navbar child for use in
`bs4DashNavbar(rightUi = ...)`.
