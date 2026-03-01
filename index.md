# bs4Dashkit

`bs4Dashkit` provides structured branding, theming and navigation
utilities for [`{bs4Dash}`](https://rinterface.github.io/bs4Dash/)
applications.

It reduces repetitive CSS overrides and sidebar wiring to a small,
composable set of functions designed to work together.

## Features

| Function                                                                                                     | Purpose                                                                                                                                     |
|--------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------|
| [`dash_titles()`](https://PrigasG.github.io/bs4Dashkit/reference/dash_titles.md)                             | Unified constructor for all brand and sidebar configuration                                                                                 |
| [`use_bs4Dashkit_core()`](https://PrigasG.github.io/bs4Dashkit/reference/use_bs4Dashkit_core.md)             | injects dependencies, applies a theme preset, configures sidebar behavior                                                                   |
| [`dash_footer()`](https://PrigasG.github.io/bs4Dashkit/reference/dash_footer.md)                             | Responsive footer with independent logo and text positioning                                                                                |
| [`dash_nav_title()`](https://PrigasG.github.io/bs4Dashkit/reference/dash_nav_title.md)                       | Styled navbar title block with optional subtitle                                                                                            |
| [`dash_nav_item()`](https://PrigasG.github.io/bs4Dashkit/reference/dash_nav_item.md)                         | Wraps UI element as navbar itemS                                                                                                            |
| [`dash_nav_refresh_button()`](https://PrigasG.github.io/bs4Dashkit/reference/dash_nav_refresh_button.md)     | Pre-styled page reload button                                                                                                               |
| [`dash_nav_help_button()`](https://PrigasG.github.io/bs4Dashkit/reference/dash_nav_help_button.md)           | Pre-styled help trigger button                                                                                                              |
| [`dash_user_menu()`](https://PrigasG.github.io/bs4Dashkit/reference/dash_user_menu.md)                       | Wrapper for [bs4Dash](https://github.com/RinteRface/bs4Dash) [`dropdownMenu()`](https://bs4dash.rinterface.com/reference/dropdownMenu.html) |
| [`use_dash_theme()`](https://PrigasG.github.io/bs4Dashkit/reference/use_dash_theme.md)                       | Apply CSS-variable overrides                                                                                                                |
| [`use_dash_theme_preset()`](https://PrigasG.github.io/bs4Dashkit/reference/use_dash_theme_preset.md)         | Apply named theme preset                                                                                                                    |
| [`use_dash_sidebar_behavior()`](https://PrigasG.github.io/bs4Dashkit/reference/use_dash_sidebar_behavior.md) | Configure collapsed and expanded sidebar widths                                                                                             |

------------------------------------------------------------------------

## Installation

``` r
# Install from CRAN
install.packages("bs4Dashkit")

# Or with pak
pak::pak("bs4Dashkit")


# Development version from GitHub
remotes::install_github("PrigasG/bs4Dashkit")
```

------------------------------------------------------------------------

## Quick start

``` r
library(shiny)
library(bs4Dash)
library(bs4Dashkit)

ttl <- dash_titles(
  brand_text = "Dashboards",
  icon       = "project-diagram"
)

ui <- bs4DashPage(
  title  = ttl$app_name,
  header = bs4DashNavbar(title = ttl$brand),
  sidebar = bs4DashSidebar(
    bs4SidebarMenu(
      bs4SidebarMenuItem("Dashboard", tabName = "dash", icon = icon("gauge-high"))
    )
  ),
  body = bs4DashBody(
    use_bs4Dashkit_core(ttl),  # recommended first call
    bs4TabItems(
      bs4TabItem(tabName = "dash", h2("Hello Dashboard"))
    )
  )
)

server <- function(input, output, session) {}
shinyApp(ui, server)
```

------------------------------------------------------------------------

## Core concepts

### `dash_titles()`

Creates a single object that defines brand text, icon/image, visual
effects, and sidebar brand behaviour.

``` r
ttl <- dash_titles(
  brand_text     = "OLTCR Dashboards",
  icon           = "project-diagram",
  weight         = 700,
  effect         = "shimmer",
  glow_color     = "#2f6f8f",
  size           = "20px",
  collapsed      = "icon-text",
  expanded       = "icon-text",
  collapsed_text = "DT",
  expanded_text  = "OLTCR Dashboards",
  brand_divider  = TRUE
)

# ttl$app_name → bs4DashPage(title = ...)
# ttl$brand    → bs4DashNavbar(title = ...)
# ttl$deps     → injected automatically by use_bs4Dashkit_core()
```

### Sidebar modes

Control what appears in the sidebar brand area in each state:

| Mode          | What renders                 |
|---------------|------------------------------|
| `"icon-only"` | icon (or image) only         |
| `"icon-text"` | Icon plus a short text label |
| `"text-only"` | Text label only              |

Collapsed and expanded states can be configured independently.

### Theme presets

``` r
use_bs4Dashkit_core(ttl, preset = "professional")  # cool blue-grey (default)
use_bs4Dashkit_core(ttl, preset = "vibrant")        # stronger accent colours
use_bs4Dashkit_core(ttl, preset = "minimal")        # flat, low-contrast
```

Accent overrides:

``` r
use_bs4Dashkit_core(ttl, preset = "professional", accent = "#2f6f8f")
```

### Footer layouts

``` r
# Logo left, text left (default)
dash_footer(logo_src = "logo.png", left_text = "My Organisation")

# Logo right
dash_footer(
  logo_src = "logo.png",
  left_text = "My Organisation",
  logo_position = "right"
)

# Both elements on the right
dash_footer(
  logo_src = "logo.png",
  left_text = "My Organisation",
  logo_position = "right",
  text_position = "right"
)

# No logo
dash_footer(logo_src = NULL, left_text = "My Organisation \u2022 2025")
```

### Global options

Set project-wide defaults once:

``` r
options(
  bs4Dashkit.sidebar.collapsed = "icon-only",
  bs4Dashkit.sidebar.expanded  = "icon-text",
  bs4Dashkit.brand_divider     = TRUE,
  bs4Dashkit.theme_preset      = "professional",
  bs4Dashkit.accent            = "#2f6f8f"
)
```

Arguments supplied directly to functions always override global options.

## Documentation

Full reference and articles: <https://PrigasG.github.io/bs4Dashkit>

## License

MIT
