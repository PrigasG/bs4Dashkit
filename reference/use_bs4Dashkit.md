# Load core CSS and JS for bs4Dashkit

Adds the package's bundled CSS (core, theme, sidebar) and optional JS
helpers.

## Usage

``` r
use_bs4Dashkit(include_center_js = TRUE)
```

## Arguments

- include_center_js:

  Logical. If `TRUE` (default), also includes the JavaScript helper that
  supports the centered navbar title layout.

## Value

An
[`htmltools::tagList()`](https://rstudio.github.io/htmltools/reference/tagList.html)
containing an
[`htmltools::htmlDependency()`](https://rstudio.github.io/htmltools/reference/htmlDependency.html).
