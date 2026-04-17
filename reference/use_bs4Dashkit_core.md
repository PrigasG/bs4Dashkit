# Load bs4Dashkit core dependencies in one call

Recommended entry point for bs4Dashkit in bs4DashBody(). For most apps,
this should be the first element inside `bs4DashBody(...)`.

## Usage

``` r
use_bs4Dashkit_core(
  ttl,
  preset = NULL,
  accent = NULL,
  ...,
  topbar_h = 56,
  collapsed_w = 4.2,
  expanded_w = 250
)
```

## Arguments

- ttl:

  Output from dash_titles()

- preset:

  Optional theme preset name (e.g. "professional"). If NULL, uses option
  bs4Dashkit.theme_preset (if set).

- accent:

  Optional accent override. If NULL, uses option bs4Dashkit.accent. If
  preset is used, this overrides the preset accent.

- ...:

  Optional overrides passed to use_dash_theme_preset() when preset is
  used.

- topbar_h:

  Height (px) for topbar + brand strip

- collapsed_w:

  Sidebar collapsed width (rem)

- expanded_w:

  Sidebar expanded width (px)

## Value

A `shiny.tag.list` containing core CSS and/or JavaScript dependencies
for bs4Dashkit.
