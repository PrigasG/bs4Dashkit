# Getting Started

``` r
library(bs4Dashkit)
```

## Overview

`bs4Dashkit` extends [bs4Dash](https://github.com/RinteRface/bs4Dash) by
standardizing branding, sidebar behavior, navbar utilities, and theme
customization. Every feature is optional — you can adopt as little or as
much as you need.

The package is organised around four areas:

1.  **Brand and sidebar** —
    [`dash_titles()`](https://PrigasG.github.io/bs4Dashkit/reference/dash_titles.md) +
    [`use_bs4Dashkit_core()`](https://PrigasG.github.io/bs4Dashkit/reference/use_bs4Dashkit_core.md)
2.  **Theming** —
    [`use_dash_theme()`](https://PrigasG.github.io/bs4Dashkit/reference/use_dash_theme.md)
    and named presets
3.  **Navbar** —
    [`dash_nav_title()`](https://PrigasG.github.io/bs4Dashkit/reference/dash_nav_title.md),
    refresh / help / logout buttons, user menu
4.  **Footer** —
    [`dash_footer()`](https://PrigasG.github.io/bs4Dashkit/reference/dash_footer.md)
    with flexible logo and text positioning

------------------------------------------------------------------------

## Minimal example

The smallest possible `bs4Dashkit` app requires exactly two calls beyond
normal `bs4Dash` boilerplate:

``` r
library(shiny)
library(bs4Dash)
library(bs4Dashkit)

# 1. Build the brand object
ttl <- dash_titles("My Dashboard")

ui <- bs4DashPage(
  title   = ttl$app_name,           # browser tab title
  header  = bs4DashNavbar(title = ttl$brand),
  sidebar = bs4DashSidebar(),
  body    = bs4DashBody(
    use_bs4Dashkit_core(ttl)        # 2. always the first call in body and called once
  )
)

server <- function(input, output, session) {}
shinyApp(ui, server)
```

[`dash_titles()`](https://PrigasG.github.io/bs4Dashkit/reference/dash_titles.md)
accepts a single string and sensible defaults handle everything else.
[`use_bs4Dashkit_core()`](https://PrigasG.github.io/bs4Dashkit/reference/use_bs4Dashkit_core.md)
loads the CSS dependencies, activates the sidebar brand mode, and
applies the default theme.

------------------------------------------------------------------------

## `dash_titles()` — the brand object

[`dash_titles()`](https://PrigasG.github.io/bs4Dashkit/reference/dash_titles.md)
is the single entry point for all brand-related configuration. It
returns a named list with three slots:

| Slot           | Where it goes                                                                                                                                         |
|----------------|-------------------------------------------------------------------------------------------------------------------------------------------------------|
| `ttl$app_name` | `bs4DashPage(title = ...)`                                                                                                                            |
| `ttl$brand`    | `bs4DashNavbar(title = ...)` (and/or `bs4DashSidebar(title = ...)`)                                                                                   |
| `ttl$deps`     | inside `bs4DashBody(...)` (handled automatically by [`use_bs4Dashkit_core()`](https://PrigasG.github.io/bs4Dashkit/reference/use_bs4Dashkit_core.md)) |

``` r
ttl <- dash_titles(
  brand_text     = "OLTCR Dashboards",
  icon           = "project-diagram",  # Font Awesome icon name
  weight         = 700,
  effect         = "shimmer",          # "none" | "glow" | "shimmer" | "emboss"
  glow_color     = "#2f6f8f",
  size           = "20px",
  collapsed      = "icon-text",
  expanded       = "icon-text",
  collapsed_text = "DT",               # shown when sidebar is collapsed
  expanded_text  = "OLTCR Dashboards",
  brand_divider  = TRUE
)
```

Alternatively, use an image instead of a Font Awesome icon:

``` r
ttl <- dash_titles(
  brand_text = "My App",
  icon_img   = "logo.png",        # overrides `icon`
  icon_shape = "rounded"              # "circle" | "rounded" | "square"
)
```

**NB: Place logo.png in your app’s www/ directory.**

------------------------------------------------------------------------

## `use_bs4Dashkit_core()` — the core entry point

Always place this as the **first element** inside
[`bs4DashBody()`](https://bs4dash.rinterface.com/reference/dashboardBody.html).
It:

- Injects the package CSS and JavaScript
- Activates the sidebar brand mode logic
- Applies a theme preset (default: `"professional"`)

``` r
body = bs4DashBody(
  use_bs4Dashkit_core(ttl, preset = "professional"),
  # ... rest of your content
)
```

Available presets:

``` r
use_bs4Dashkit_core(ttl, preset = "professional")  # cool blue-grey (default)
use_bs4Dashkit_core(ttl, preset = "vibrant")        # bolder accent colours
use_bs4Dashkit_core(ttl, preset = "minimal")        # flat, low-contrast
```

------------------------------------------------------------------------

## Sidebar modes

The sidebar brand area can show different content depending on whether
the sidebar is collapsed or expanded. Set these in
[`dash_titles()`](https://PrigasG.github.io/bs4Dashkit/reference/dash_titles.md):

``` r
ttl <- dash_titles(
  brand_text     = "OLTCR Dashboards",
  icon           = "chart-line",
  collapsed      = "icon-only",       # just the icon when narrow
  expanded       = "icon-text",       # icon + label when wide
  collapsed_text = "OL",
  expanded_text  = "OLTCR Dashboards"
)
```

| Mode          | Collapsed | Expanded |
|---------------|-----------|----------|
| `"icon-only"` | ✓         | ✓        |
| `"icon-text"` | ✓         | ✓        |
| `"text-only"` | ✓         | ✓        |

Add hover-expand behaviour (sidebar expands on mouse-over even when
collapsed):

``` r
body = bs4DashBody(
  use_bs4Dashkit_core(
    ttl,
    preset = "professional",
    topbar_h = 56,
    collapsed_w = 4.2,
    expanded_w = 250
  )
  # ...
)
```

**NB:
[`use_dash_sidebar_behavior()`](https://PrigasG.github.io/bs4Dashkit/reference/use_dash_sidebar_behavior.md)
is included by
[`use_bs4Dashkit_core()`](https://PrigasG.github.io/bs4Dashkit/reference/use_bs4Dashkit_core.md).**
Call it directly only if you are not using the core helper.

Hover-expand behavior is included by
[`use_bs4Dashkit_core()`](https://PrigasG.github.io/bs4Dashkit/reference/use_bs4Dashkit_core.md).
Configure it via `topbar_h`, `collapsed_w`, and `expanded_w`. Call
[`use_dash_sidebar_behavior()`](https://PrigasG.github.io/bs4Dashkit/reference/use_dash_sidebar_behavior.md)
directly only when not using the core helper.

------------------------------------------------------------------------

## Global options

Set package-level defaults once (e.g. in your `global.R`) so every app
in a project inherits them:

``` r
options(
  bs4Dashkit.sidebar.collapsed = "icon-only",
  bs4Dashkit.sidebar.expanded  = "icon-text",
  bs4Dashkit.brand_divider     = TRUE,
  bs4Dashkit.accent            = "#2f6f8f",
  bs4Dashkit.theme_preset      = "professional"
)
```

If `preset = NULL`,
[`use_bs4Dashkit_core()`](https://PrigasG.github.io/bs4Dashkit/reference/use_bs4Dashkit_core.md)
uses the package option `bs4Dashkit.theme_preset (if set)`. If
`accent = NULL`, it uses `bs4Dashkit.accent`.

``` r
use_bs4Dashkit_core(ttl, preset = NULL) # uses option if set
use_bs4Dashkit_core(ttl, accent = NULL) # uses option if set
```

[`dash_titles()`](https://PrigasG.github.io/bs4Dashkit/reference/dash_titles.md)
reads these options when the corresponding arguments are `NULL`, so you
can omit them from individual calls.

------------------------------------------------------------------------

## Troubleshooting

- “I see 404s for dash-theme.css” -\> call use_bs4Dashkit_core() or
  use_bs4Dashkit() first (resource path)

- “My icon doesn’t show” -\> check Font Awesome name / include icon_img

- “Hover expand doesn’t work on mobile”-\> expected (touch devices)

- “Sidebar labels disappear on hover” -\> indicates CSS overrides; use
  shipped dash-sidebar.css

## What next?

- **Branding and sidebar modes** — full reference for all
  [`dash_titles()`](https://PrigasG.github.io/bs4Dashkit/reference/dash_titles.md)
  arguments
- **Theming and presets** — CSS variable overrides and custom presets
- **Navigation utilities** — refresh, help, logout, user menu, and
  [`dash_nav_title()`](https://PrigasG.github.io/bs4Dashkit/reference/dash_nav_title.md)
- **Footer** — all footer layout combinations
- **Complete example app** — a single app that exercises every feature
