# Top Navigation Prototype

``` r

library(bs4Dashkit)
```

[`use_dash_topnav()`](https://PrigasG.github.io/bs4Dashkit/reference/use_dash_topnav.md)
is a prototype layout helper for
[bs4Dash](https://github.com/RinteRface/bs4Dash) apps that should feel
more like a top-navigation app than a sidebar app.

The app still defines a regular
[`bs4DashSidebar()`](https://bs4dash.rinterface.com/reference/dashboardSidebar.html)
with a
[`bs4SidebarMenu()`](https://bs4dash.rinterface.com/reference/dashboardSidebar.html).
bs4Dashkit hides that sidebar, mirrors the menu into the navbar, and
delegates clicks back to the original sidebar links. That keeps native
[bs4Dash](https://github.com/RinteRface/bs4Dash) tab switching,
`input$sidebar`,
[`updateTabItems()`](https://bs4dash.rinterface.com/reference/dashboardSidebar.html),
and bookmarking behavior intact.

## Recommended setup

Use the core helper when you are already using
[`dash_titles()`](https://PrigasG.github.io/bs4Dashkit/reference/dash_titles.md):

``` r

ttl <- dash_titles(
  brand_text = "Topnav Lab",
  icon = icon("compass"),
  collapsed = "icon-only",
  expanded = "icon-text"
)

body <- bs4DashBody(
  use_bs4Dashkit_core(
    ttl,
    preset = "professional",
    layout = "topnav",
    topnav = dash_topnav_options(
      align = "left",
      gap = 6,
      mobile = "collapse",
      style = "compact",
      title = "auto"
    )
  ),
  bs4TabItems(
    bs4TabItem(tabName = "overview", "Overview"),
    bs4TabItem(tabName = "reports", "Reports")
  )
)
```

[`dash_topnav_options()`](https://PrigasG.github.io/bs4Dashkit/reference/dash_topnav_options.md)
bundles the top-nav settings in one object. You can still use the
individual `topnav_*` arguments in
[`use_bs4Dashkit_core()`](https://PrigasG.github.io/bs4Dashkit/reference/use_bs4Dashkit_core.md)
for small one-off overrides, but the object form keeps production setup
easier to scan.

`align` controls where the mirrored tabs sit in the navbar:

- `"left"` keeps tabs close to the brand and is usually the safest
  choice when the navbar also has a centered
  [`dash_nav_title()`](https://PrigasG.github.io/bs4Dashkit/reference/dash_nav_title.md).
- `"center"` centers the tab group and works best when there is no
  centered title or when there are only a few short tabs.
- `"right"` moves the tab group toward the right controls, useful when
  the brand is visually heavy or the left side needs more space.

`gap` controls the space between top-nav items. Use a small value such
as `4` or `6` for subtle breathing room, or `0` for a compact
AdminLTE-style tab strip.

## Mobile, style, and overflow

By default, mobile top-nav mode uses a hamburger button for tabs:

``` r

use_bs4Dashkit_core(
  ttl,
  layout = "topnav",
  topnav = dash_topnav_options(mobile = "collapse")
)
```

Use `mobile = "scroll"` if you prefer a single horizontally scrollable
row on small screens. Mobile top-nav modes work best without a centered
navbar title once the viewport starts to tighten; keep `title = "auto"`
so bs4Dashkit hides
[`dash_nav_title()`](https://PrigasG.github.io/bs4Dashkit/reference/dash_nav_title.md)
early when the tab row needs room, or set `title = "hide"` for a
permanently tab-first navbar.

`topnav_style` controls the tab treatment:

``` r

use_bs4Dashkit_core(
  ttl,
  layout = "topnav",
  topnav = dash_topnav_options(style = "underline")
)
use_bs4Dashkit_core(
  ttl,
  layout = "topnav",
  topnav = dash_topnav_options(style = "pill")
)
use_bs4Dashkit_core(
  ttl,
  layout = "topnav",
  topnav = dash_topnav_options(style = "compact")
)
```

The underline style uses a small animated indicator that moves when the
active tab changes.

For crowded desktop navbars, move later tabs into a `More` dropdown:

``` r

use_bs4Dashkit_core(
  ttl,
  layout = "topnav",
  topnav = dash_topnav_options(
    overflow = "more",
    more_after = 4
  )
)
```

`title = "auto"` compacts a centered
[`dash_nav_title()`](https://PrigasG.github.io/bs4Dashkit/reference/dash_nav_title.md)
when tabs need room, then hides it if there still is not enough space.
Use `"show"`, `"compact"`, or `"hide"` when you want explicit behavior.

Top-nav clicks also emit a Shiny event:

``` r

observeEvent(input$bs4dashkit_topnav, {
  str(input$bs4dashkit_topnav)
})
```

If the page body needs a simple title synced from the active tab,
enable:

``` r

use_bs4Dashkit_core(
  ttl,
  layout = "topnav",
  topnav = dash_topnav_options(page_title = "tab")
)
```

You can also call
[`use_dash_topnav()`](https://PrigasG.github.io/bs4Dashkit/reference/use_dash_topnav.md)
directly if you assemble the other dependencies yourself:

``` r

bs4DashBody(
  use_bs4Dashkit(),
  ttl$deps,
  use_dash_theme_preset("professional"),
  use_dash_topnav(topbar_h = "56px", align = "left", gap = 6, mobile = "collapse")
)
```

## Dropdown menu items

Sidebar menu items with sub-items are rendered as navbar dropdowns:

``` r

bs4SidebarMenu(
  id = "sidebar",
  bs4SidebarMenuItem("Overview", tabName = "overview", icon = icon("gauge-high")),
  bs4SidebarMenuItem(
    "Reports",
    icon = icon("chart-line"),
    bs4SidebarMenuSubItem("Monthly", tabName = "monthly"),
    bs4SidebarMenuSubItem("Quality", tabName = "quality")
  )
)
```

## Runnable example

The package ships a prototype app that exercises flat menu items,
dropdown sub-items, navbar utilities, footer styling, theme presets, and
server-side tab updates:

``` r

shiny::runApp(system.file("examples", "topnav-prototype", package = "bs4Dashkit"))
```

This feature is intentionally conservative: the hidden sidebar remains
the source of truth, and the top-nav layer mirrors it rather than
replacing [bs4Dash](https://github.com/RinteRface/bs4Dash) internals.
