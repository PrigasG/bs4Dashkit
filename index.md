# bs4Dashkit

Structured theming and navigation utilities for
[bs4Dash](https://github.com/RinteRface/bs4Dash) applications.

`bs4Dashkit` provides:

- Unified brand and sidebar configuration
- Configurable collapsed / expanded sidebar modes
- Hover-expand sidebar behavior
- Subtle CSS-variable theming
- Standardized navigation components (refresh, help, user menu)
- Lightweight dependency model compatible with native
  [bs4Dash](https://github.com/RinteRface/bs4Dash) layouts

------------------------------------------------------------------------

## Installation

``` r

# Development version
remotes::install_github("PrigasG/bs4Dashkit")
```

------------------------------------------------------------------------

## Quick Start

``` r

library(shiny)
library(bs4Dash)
library(bs4Dashkit)

ttl <- dash_titles(
  brand_text = "OLTCR Dashboards",
  icon = icon("cloud"),
  collapsed = "icon-only",
  expanded = "icon-text"
)

ui <- bs4DashPage(
  title = ttl$app_name,
  header = bs4DashNavbar(title = ttl$brand),
  sidebar = bs4DashSidebar(
    bs4SidebarMenu(
      bs4SidebarMenuItem("Dashboard", tabName = "dash")
    )
  ),
  body = bs4DashBody(
    use_bs4Dashkit_core(ttl),
    bs4TabItems(
      bs4TabItem(
        tabName = "dash",
        h2("Hello Dashboard")
      )
    )
  )
)

server <- function(input, output, session) {}
shinyApp(ui, server)
```

------------------------------------------------------------------------

## Key Features

### Sidebar Modes

- `"icon-only"`
- `"icon-text"`
- `"text-only"`

Fully configurable for collapsed and expanded states.

`brand_text` is the primary label. It is used in the navbar and, by
default, as the expanded sidebar label. The sidebar brand mirrors the
navbar title you pass to `bs4DashNavbar(title = ttl$brand)`. Use
`collapsed_text` only when you want a very short label in the narrow
collapsed sidebar. In practice, about 3 characters works best.

### Theme System

CSS variable-driven theming:

``` r

use_dash_theme(accent = "#2f6f8f")
```

### New Ergonomics

Recent additions make the package easier to wire up in real apps:

``` r

ttl <- dash_titles(
  brand_text = "OLTCR Dashboards",
  icon = icon("cloud"),
  collapsed_text = "OLT",
  expanded_text = "OLTCR Dashboards", # optional; brand_text is the default
  collapsed_text_size = "10px",
  expanded_text_size = "15px",
  collapsed_text_weight = 700,
  expanded_text_weight = 800
)

bs4dashkit_theme_presets()
bs4dashkit_example_app()
bs4dashkit_demo_app()
```

For a textless icon brand in both sidebar states:

``` r

ttl <- dash_titles(
  brand_text = NULL,
  app_name = "Icon Lab",
  icon = icon("cloud"),
  collapsed = "icon-only",
  expanded = "icon-only"
)
```

### Navigation Utilities

Prebuilt components:

- [`dash_nav_refresh_button()`](https://PrigasG.github.io/bs4Dashkit/reference/dash_nav_refresh_button.md)
- [`dash_nav_help_button()`](https://PrigasG.github.io/bs4Dashkit/reference/dash_nav_help_button.md)
- [`dash_user_menu()`](https://PrigasG.github.io/bs4Dashkit/reference/dash_user_menu.md)

Available presets:

``` r

bs4dashkit_theme_presets()
```

Server-side wiring example:

``` r

observeEvent(input$refresh, session$reload())
```

------------------------------------------------------------------------

## Documentation

Full documentation and examples are available at:

<https://prigasg.github.io/bs4Dashkit/>

For a fuller interactive demo, run:

``` r

bs4dashkit_demo_app()
```

or open the packaged example app file:

``` r

shiny::runApp(system.file("examples", "real-shiny-app", package = "bs4Dashkit"))
```

For a heavier stress-test example that exercises the shipped features
together:

``` r

shiny::runApp(system.file("examples", "test-all", package = "bs4Dashkit"))
```

That packaged example is now a standalone full app source file, not just
a wrapper around
[`bs4dashkit_demo_app()`](https://PrigasG.github.io/bs4Dashkit/reference/bs4dashkit_demo_app.md).

------------------------------------------------------------------------

## License

MIT

## Full Example App

A complete working example (brand, sidebar modes, hover expand, theme
preset, navbar tools, footer) is included in the documentation site:

- Articles -\> Complete Example App
