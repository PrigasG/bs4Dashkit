# Toggle the sidebar header divider (line under the brand area)

Toggle the sidebar header divider (line under the brand area)

## Usage

``` r
use_dash_sidebar_brand_divider(show = TRUE)
```

## Arguments

- show:

  Logical. TRUE keeps divider (default). FALSE hides it.

## Value

If `show` is `TRUE`, an empty `shiny.tag.list`. If `show` is `FALSE`, a
`shiny.tag` object containing CSS that hides the sidebar brand divider.
