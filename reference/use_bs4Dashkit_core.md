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
  expanded_w = 250,
  layout = c("sidebar", "topnav"),
  topnav = NULL,
  topnav_align = c("left", "center", "right"),
  topnav_gap = 0,
  topnav_style = c("underline", "pill", "compact"),
  topnav_mobile = c("collapse", "scroll"),
  topnav_overflow = c("auto", "more", "scroll"),
  topnav_more_after = Inf,
  topnav_title = c("auto", "show", "compact", "hide"),
  topnav_page_title = c("none", "tab"),
  topnav_brand = TRUE,
  topnav_debug = FALSE
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

  Height for topbar + brand strip. Numeric values are treated as pixels;
  CSS lengths such as `"3.5rem"` are also accepted.

- collapsed_w:

  Sidebar collapsed width. Numeric values are treated as rem; CSS
  lengths such as `"4.25rem"` are also accepted.

- expanded_w:

  Sidebar expanded width. Numeric values are treated as pixels; CSS
  lengths such as `"270px"` are also accepted.

- layout:

  Layout behavior to apply. `"sidebar"` keeps the default bs4Dash
  sidebar with hover-expand behavior. `"topnav"` hides the sidebar and
  mirrors its menu into the navbar with
  [`use_dash_topnav()`](https://PrigasG.github.io/bs4Dashkit/reference/use_dash_topnav.md).

- topnav:

  Optional output from
  [`dash_topnav_options()`](https://PrigasG.github.io/bs4Dashkit/reference/dash_topnav_options.md).
  When supplied, its values are used for the top-navigation settings
  below.

- topnav_align:

  Horizontal alignment for the mirrored top-nav menu when
  `layout = "topnav"`: `"left"`, `"center"`, or `"right"`. If a centered
  [`dash_nav_title()`](https://PrigasG.github.io/bs4Dashkit/reference/dash_nav_title.md)
  is also present, `"left"` or `"right"` usually leaves the title more
  readable.

- topnav_gap:

  Space between mirrored top-nav items. Numeric values are treated as
  pixels; CSS lengths such as `"0.5rem"` are also accepted.

- topnav_style:

  Visual style for top-nav tabs: `"underline"`, `"pill"`, or
  `"compact"`.

- topnav_mobile:

  Mobile behavior: `"collapse"` shows a hamburger for tabs; `"scroll"`
  keeps a horizontal tab row.

- topnav_overflow:

  Desktop overflow behavior: `"auto"`, `"more"`, or `"scroll"`.

- topnav_more_after:

  Number of top-level items kept visible when
  `topnav_overflow = "more"`.

- topnav_title:

  How centered
  [`dash_nav_title()`](https://PrigasG.github.io/bs4Dashkit/reference/dash_nav_title.md)
  behaves when tabs need space: `"auto"`, `"show"`, `"compact"`, or
  `"hide"`.

- topnav_page_title:

  Optional content title synced from the active top-nav tab: `"none"` or
  `"tab"`.

- topnav_brand:

  Logical. If `TRUE`, mirror the sidebar brand into the navbar when
  bs4Dash has not already placed one there.

- topnav_debug:

  Logical. If `TRUE`, print top-nav diagnostics to the browser console.

## Value

A `shiny.tag.list` containing core CSS and/or JavaScript dependencies
for bs4Dashkit.
