# Built-in bs4Dashkit theme presets

Returns the theme presets shipped with bs4Dashkit so they are easy to
discover in code completion, validation errors, and documentation.

## Usage

``` r
bs4dashkit_theme_presets(values = FALSE)
```

## Arguments

- values:

  Logical. If `TRUE`, also returns the preset theme values as a
  list-column named `tokens`.

## Value

A data frame with one row per preset and columns `preset` and
`description`. If `values = TRUE`, the returned data frame also includes
a `tokens` list-column.
