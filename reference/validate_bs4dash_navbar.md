# Validate bs4Dash navbar rightUi structure

Checks that each direct child supplied to `bs4DashNavbar(rightUi = ...)`
is a complete navbar list item with the `dropdown` class expected by
bs4Dash/AdminLTE.

## Usage

``` r
validate_bs4dash_navbar(rightUi)
```

## Arguments

- rightUi:

  A
  [`shiny::tagList()`](https://rstudio.github.io/htmltools/reference/tagList.html)
  or tag intended for `bs4DashNavbar(rightUi = ...)`.

## Value

Invisibly returns `TRUE` when valid; otherwise errors with a targeted
message.
