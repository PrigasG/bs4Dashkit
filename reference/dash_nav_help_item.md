# Navbar help item (complete bs4Dash rightUi child)

Navbar help item (complete bs4Dash rightUi child)

## Usage

``` r
dash_nav_help_item(
  id,
  label = "Help",
  icon = "circle-question",
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
