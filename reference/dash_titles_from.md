# Create dashboard titles from brand options

Create dashboard titles from brand options

## Usage

``` r
dash_titles_from(brand, ...)
```

## Arguments

- brand:

  A `bs4dashkit_brand_options` object created by
  [`dash_brand_options()`](https://PrigasG.github.io/bs4Dashkit/reference/dash_brand_options.md).

- ...:

  Additional arguments passed to
  [`dash_titles()`](https://PrigasG.github.io/bs4Dashkit/reference/dash_titles.md),
  overriding values stored in `brand`.

## Value

A named list with `app_name`, `brand`, and `deps`; see
[`dash_titles()`](https://PrigasG.github.io/bs4Dashkit/reference/dash_titles.md).
