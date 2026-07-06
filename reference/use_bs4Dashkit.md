# Load core CSS and JS for bs4Dashkit

Adds the package's bundled CSS (core, theme, sidebar) and optional JS
helpers. All assets are attached as named
[`htmltools::htmlDependency`](https://rstudio.github.io/htmltools/reference/htmlDependency.html)
objects, so they are included once per page regardless of how many
bs4Dashkit helpers request them.

## Usage

``` r
use_bs4Dashkit(include_center_js = TRUE)
```

## Arguments

- include_center_js:

  Logical. If `TRUE` (default), also includes the JavaScript helper that
  supports the centered navbar title layout.

## Value

A
[`htmltools::tagList`](https://rstudio.github.io/htmltools/reference/tagList.html)
containing
[`htmltools::htmlDependency`](https://rstudio.github.io/htmltools/reference/htmlDependency.html)
objects for the package CSS and optional JavaScript helpers.
