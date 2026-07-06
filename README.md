
# bs4Dashkit

Structured theming and navigation utilities for `{bs4Dash}`
applications.

`bs4Dashkit` provides:

- Unified brand and sidebar configuration
- Reusable brand option objects for shared app families
- Configurable collapsed / expanded sidebar modes
- Hover-expand sidebar behavior
- Prototype top-navigation mode for no-sidebar dashboards
- Subtle CSS-variable theming
- Complete standardized navbar components (status, refresh, help, user
  menu)
- Lightweight dependency model compatible with native `{bs4Dash}`
  layouts

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
bs4dashkit_theme_presets()
```

### Top Navigation Prototype

Use `layout = "topnav"` when you want a no-sidebar dashboard. Keep the
normal `bs4DashSidebar()` and `bs4SidebarMenu()` in your app; bs4Dashkit
hides the sidebar and mirrors its menu into the navbar so native tab
switching still works.

``` r
body = bs4DashBody(
  use_bs4Dashkit_core(
    ttl,
    preset = "professional",
    layout = "topnav",
    topnav = dash_topnav_options(
      align = "left",
      gap = 6,
      mobile = "collapse",
      style = "compact",
      overflow = "more",
      more_after = 4,
      title = "auto",
      page_title = "tab"
    )
  ),
  bs4TabItems(...)
)
```

`dash_topnav_options()` keeps top-nav setup in one memorable object. The
prefixed arguments such as `topnav_align` and `topnav_gap` remain
available for small one-off overrides.

`align` can be `"left"`, `"center"`, or `"right"`. If you also use a
centered `dash_nav_title()`, left or right tab alignment usually leaves
the title clearer; centered tabs are best when the navbar has no
centered title or only a few tabs.

Top-nav mode also includes mobile hamburger behavior, an animated active
underline, optional pill/compact tab styles, a `More` overflow mode, and
a separate `input$bs4dashkit_topnav` click event for server-side logging
or analytics. Use `topnav_page_title = "tab"` when you want a small
content title synced from the selected tab.

For a runnable prototype:

``` r
shiny::runApp(system.file("examples", "topnav-prototype", package = "bs4Dashkit"))
```

### New Ergonomics

Recent additions make the package easier to wire up in real apps:

``` r
brand <- dash_brand_options(
  name = "Atlas Forge",
  icon = icon("layer-group"),
  collapsed = "AF",
  expanded = "Atlas Forge"
)

ttl <- dash_titles_from(brand)
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

- `dash_nav_status_item()`
- `dash_nav_refresh_item()`
- `dash_nav_help_item()`
- `dash_user_menu()`
- `validate_bs4dash_navbar()`

``` r
rightUi <- tagList(
  dash_nav_status_item("Ready", status = "success", icon = icon("circle-check")),
  dash_nav_refresh_item("refresh"),
  dash_nav_help_item("help")
)

validate_bs4dash_navbar(rightUi)
```

The lower-level `dash_nav_refresh_button()` and `dash_nav_help_button()`
remain available when you need to build a custom wrapper yourself.

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
a wrapper around `bs4dashkit_demo_app()`.

------------------------------------------------------------------------

## License

MIT

## Full Example App

A complete working example (brand, sidebar modes, hover expand, theme
preset, navbar tools, footer) is included in the documentation site:

- Articles -\> Complete Example App
