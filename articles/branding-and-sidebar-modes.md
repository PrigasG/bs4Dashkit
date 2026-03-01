# Branding and Sidebar Modes

``` r
library(bs4Dashkit)
```

## `dash_titles()` — full argument reference

[`dash_titles()`](https://PrigasG.github.io/bs4Dashkit/reference/dash_titles.md)
is the single constructor for all branding and sidebar behaviour. It
returns a list you destructure into the three placement slots described
below.

``` r
ttl <- dash_titles(
  brand_text     = "My App",       # required: visible brand label
  app_name       = NULL,            # browser tab title; defaults to brand_text
  icon           = NULL,            # Font Awesome icon name e.g. "shield-halved"
  icon_img       = NULL,            # image path — overrides icon when set
  icon_shape     = "circle",        # "circle" | "rounded" | "square"
  icon_size      = NULL,            # CSS size e.g. "22px"
  icon_color     = NULL,            # CSS color for FA icon e.g. "#2f6f8f"
  weight         = 700,             # CSS font-weight
  spacing        = "-0.02em",       # CSS letter-spacing
  size           = NULL,            # CSS font-size for label e.g. "13px"
  italic         = FALSE,
  font_family    = NULL,            # CSS font-family string
  color          = NULL,            # solid label colour; ignored when gradient set
  gradient       = NULL,            # c("#hex1", "#hex2") — sets gradient effect
  effect         = "none",          # "none" | "glow" | "shimmer" | "emboss"
  glow_color     = NULL,            # colour for glow / shimmer
  collapsed      = "icon-only",     # brand mode when sidebar is collapsed
  expanded       = "icon-text",     # brand mode when sidebar is expanded
  collapsed_text = NULL,            # short label for collapsed icon-text/text-only
  expanded_text  = NULL             # full label for expanded icon-text/text-only
)
```

### Return value

| Slot           | Type        | Placement                                                                                                                               |
|----------------|-------------|-----------------------------------------------------------------------------------------------------------------------------------------|
| `ttl$app_name` | `character` | `bs4DashPage(title = ttl$app_name)`                                                                                                     |
| `ttl$brand`    | `tagList`   | `bs4DashNavbar(title = ttl$brand)` (and/or `bs4DashSidebar(title = ttl$brand)`)                                                         |
| `ttl$deps`     | `tagList`   | inside `bs4DashBody(...)` — handled by [`use_bs4Dashkit_core()`](https://PrigasG.github.io/bs4Dashkit/reference/use_bs4Dashkit_core.md) |

------------------------------------------------------------------------

## Icon options

### Font Awesome icon

``` r
ttl <- dash_titles(
  brand_text = "My App",
  icon       = "chart-line",
  icon_color = "#2f6f8f",
  icon_size  = "20px"
)
```

### Image logo

`icon_img` overrides `icon`. The path is relative to your app’s `www/`
folder.

``` r
ttl <- dash_titles(
  brand_text = "My App",
  icon_img   = "logo.png",    # served from www/logo.png
  icon_shape = "rounded",     # "circle" | "rounded" | "square"
  icon_size  = "28px"
)
```

------------------------------------------------------------------------

## Label effects

``` r
# No effect (plain text)
ttl <- dash_titles(brand_text = "My App", effect = "none")

# Glow
ttl <- dash_titles(brand_text = "My App", effect = "glow", glow_color = "#2f6f8f")

# Shimmer (animated gradient sweep)
ttl <- dash_titles(brand_text = "My App", effect = "shimmer", glow_color = "#5ba3c9")

# Emboss (subtle relief shadow)
ttl <- dash_titles(brand_text = "My App", effect = "emboss")

# Two-colour gradient (effect argument is ignored when gradient is set)
ttl <- dash_titles(brand_text = "My App", gradient = c("#2f6f8f", "#5ba3c9"))
```

------------------------------------------------------------------------

## Sidebar modes

The sidebar brand area can show different content depending on whether
the sidebar is collapsed or expanded. There are three modes, combinable
independently for each state.

| Mode          | What renders                 |
|---------------|------------------------------|
| `"icon-only"` | Icon or image only — no text |
| `"icon-text"` | Icon plus a text label       |
| `"text-only"` | Text label only — no icon    |

### Common combinations

``` r
# Compact when collapsed, full when expanded (recommended default)
ttl <- dash_titles(
  brand_text     = "Test Dashboard",
  icon           = "project-diagram",
  collapsed      = "icon-only",
  expanded       = "icon-text",
  expanded_text  = "Dashboard"
)

# Show abbreviated text when collapsed
ttl <- dash_titles(
  brand_text     = "OLTCR Dashboards",
  icon           = "project-diagram",
  collapsed      = "icon-text",
  expanded       = "icon-text",
  collapsed_text = "DT",             # ≤ 8 chars recommended
  expanded_text  = "OLTCR Dashboards"
)

# Icon only in both states
ttl <- dash_titles(
  brand_text = "OLTCR Dashboards",
  icon       = "project-diagram",
  collapsed  = "icon-only",
  expanded   = "icon-only"
)
```

------------------------------------------------------------------------

## Hover-expand sidebar

[`use_bs4Dashkit_core()`](https://PrigasG.github.io/bs4Dashkit/reference/use_bs4Dashkit_core.md)
includes hover-expand sidebar behavior by default. When the sidebar is
collapsed on desktop, it expands temporarily on mouse hover.

Configure it with the sizing arguments:

``` r
body = bs4DashBody(
  use_bs4Dashkit_core(
    ttl,
    topbar_h = 56,
    collapsed_w = 4.2,
    expanded_w = 250
  ),
  # ...
)
```

If you are not using use_bs4Dashkit_core(), you can enable hover-expand
directly:

``` r
body = bs4DashBody(
  use_bs4Dashkit(),
  ttl$deps,
  use_dash_sidebar_behavior(),
  # ...
)
```

------------------------------------------------------------------------

## Brand divider

A subtle horizontal rule between the brand mark and the sidebar menu:

``` r
ttl <- dash_titles(
  brand_text    = "My App",
  icon          = "chart-line",
  brand_divider = TRUE           # default TRUE (can be disabled)
)

# Or control it independently
use_dash_sidebar_brand_divider()
```

------------------------------------------------------------------------

## Global options

Set defaults for your whole project in `global.R` or `app.R` before
calling
[`dash_titles()`](https://PrigasG.github.io/bs4Dashkit/reference/dash_titles.md):

``` r
options(
  bs4Dashkit.sidebar.collapsed = "icon-only",
  bs4Dashkit.sidebar.expanded  = "icon-text",
  bs4Dashkit.brand_divider     = TRUE
)
```

[`dash_titles()`](https://PrigasG.github.io/bs4Dashkit/reference/dash_titles.md)
reads these options when the corresponding arguments are `NULL`, so
individual apps only need to specify what differs from the project
default.

------------------------------------------------------------------------

## Putting it together

``` r
library(shiny)
library(bs4Dash)
library(bs4Dashkit)

ttl <- dash_titles(
  brand_text     = "Test Dashboard",
  icon           = "project-diagram",
  weight         = 700,
  effect         = "shimmer",
  glow_color     = "#2f6f8f",
  size           = "20px",
  collapsed      = "icon-text",
  expanded       = "icon-text",
  collapsed_text = "DT",
  expanded_text  = "Dashboard",
  brand_divider  = TRUE
)

ui <- bs4DashPage(
  title  = ttl$app_name,
  header = bs4DashNavbar(title = ttl$brand, skin = "light"),
  sidebar = bs4DashSidebar(
    skin = "light",
    bs4SidebarMenu(
      bs4SidebarMenuItem("Dashboard", tabName = "dash", icon = icon("gauge-high")),
      bs4SidebarMenuItem("Projects",  tabName = "proj", icon = icon("folder-open"))
    )
  ),
  body = bs4DashBody(
    bs4TabItems(
      bs4TabItem(tabName = "dash", h3("Dashboard")),
      bs4TabItem(tabName = "proj", h3("Projects"))
    )
  )
)

server <- function(input, output, session) {}
shinyApp(ui, server)
```
