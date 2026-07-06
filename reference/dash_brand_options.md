# Brand options for bs4Dashkit titles

Creates a reusable brand configuration that can be converted to
[`dash_titles()`](https://PrigasG.github.io/bs4Dashkit/reference/dash_titles.md)
output with
[`dash_titles_from()`](https://PrigasG.github.io/bs4Dashkit/reference/dash_titles_from.md).

## Usage

``` r
dash_brand_options(
  name,
  icon = NULL,
  collapsed = NULL,
  expanded = NULL,
  app_name = NULL,
  collapsed_mode = NULL,
  expanded_mode = NULL,
  ...
)
```

## Arguments

- name:

  Visible brand label.

- icon:

  Font Awesome icon name or simple
  [`shiny::icon()`](https://rdrr.io/pkg/shiny/man/icon.html) tag.

- collapsed:

  Short label used when the sidebar brand is collapsed.

- expanded:

  Label used when the sidebar brand is expanded.

- app_name:

  Browser tab title.

- collapsed_mode:

  Sidebar brand mode when collapsed. If `NULL`,
  [`dash_titles()`](https://PrigasG.github.io/bs4Dashkit/reference/dash_titles.md)
  uses its normal default.

- expanded_mode:

  Sidebar brand mode when expanded. If `NULL`,
  [`dash_titles()`](https://PrigasG.github.io/bs4Dashkit/reference/dash_titles.md)
  uses its normal default.

- ...:

  Additional options forwarded to
  [`dash_titles()`](https://PrigasG.github.io/bs4Dashkit/reference/dash_titles.md)
  by
  [`dash_titles_from()`](https://PrigasG.github.io/bs4Dashkit/reference/dash_titles_from.md).

## Value

A `bs4dashkit_brand_options` object.
