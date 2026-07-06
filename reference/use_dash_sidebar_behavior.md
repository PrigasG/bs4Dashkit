# Sidebar behavior: icon-only collapse + hover expand + ellipsis labels

Sidebar behavior: icon-only collapse + hover expand + ellipsis labels

## Usage

``` r
use_dash_sidebar_behavior(topbar_h = 56, collapsed_w = 4.2, expanded_w = 250)
```

## Arguments

- topbar_h:

  Height for navbar and sidebar brand strip. Numeric values are treated
  as pixels; CSS lengths such as `"3.5rem"` are also accepted.

- collapsed_w:

  Width for icon-only sidebar. Numeric values are treated as rem; CSS
  lengths such as `"4.25rem"` are also accepted.

- expanded_w:

  Expanded sidebar width. Numeric values are treated as pixels; CSS
  lengths such as `"270px"` are also accepted.

## Value

A `shiny.tag` or `shiny.tag.list` containing sidebar behavior
dependencies to include in the UI.
