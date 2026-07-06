# Navbar refresh item (complete bs4Dash rightUi child)

Navbar refresh item (complete bs4Dash rightUi child)

## Usage

``` r
dash_nav_refresh_item(
  id,
  label = "Refresh",
  icon = "rotate-right",
  class = NULL,
  ...
)
```

## Arguments

- id:

  inputId for actionButton

- label:

  Button label

- icon:

  Font Awesome icon name

- class:

  Additional classes

- ...:

  Passed to shiny::actionButton

## Value

A complete `<li class="nav-item dropdown">` navbar child for use in
`bs4DashNavbar(rightUi = ...)`.
