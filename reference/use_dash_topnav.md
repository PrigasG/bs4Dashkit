# Top navigation layout: replace the sidebar with a navbar menu

Turns a regular `bs4Dash` app into a top-navigation app, similar to
[`bslib::page_navbar()`](https://rstudio.github.io/bslib/reference/page_navbar.html).
The sidebar is hidden and its menu is mirrored as a horizontal menu
inside the navbar. Clicks on the horizontal menu are delegated back to
the original sidebar links, so everything wired to the sidebar keeps
working: `input$<sidebarMenu id>`,
[`bs4Dash::updateTabItems()`](https://bs4dash.rinterface.com/reference/dashboardSidebar.html),
badges, and bookmarking.

## Usage

``` r
use_dash_topnav(
  topbar_h = 56,
  align = c("left", "center", "right"),
  gap = 0,
  style = c("underline", "pill", "compact"),
  mobile = c("collapse", "scroll"),
  overflow = c("auto", "more", "scroll"),
  more_after = Inf,
  title = c("auto", "show", "compact", "hide"),
  page_title = c("none", "tab"),
  brand = TRUE,
  debug = FALSE
)
```

## Arguments

- topbar_h:

  Height for the navbar. Numeric values are treated as pixels; CSS
  lengths such as `"3.5rem"` are also accepted. The mirrored menu can be
  aligned with `align`. If you also place a centered
  [`dash_nav_title()`](https://PrigasG.github.io/bs4Dashkit/reference/dash_nav_title.md)
  in the navbar, the title is centered in the remaining space between
  the mirrored menu and right-side controls. In that case
  `align = "left"` or `"right"` usually gives the cleanest result;
  `align = "center"` is best for apps without a centered title or with
  only a small number of tabs.

- align:

  Horizontal alignment of the mirrored menu inside the navbar: `"left"`
  (default), `"center"`, or `"right"`.

- gap:

  Space between mirrored top-nav items. Numeric values are treated as
  pixels; CSS lengths such as `"0.5rem"` are also accepted.

- style:

  Visual style for top-nav tabs: `"underline"` (default), `"pill"`, or
  `"compact"`.

- mobile:

  Mobile behavior: `"collapse"` (default) shows a hamburger that opens
  the mirrored tabs; `"scroll"` keeps tabs in one horizontally
  scrollable row.

- overflow:

  Desktop overflow behavior. `"auto"` (default) keeps the tab row
  intact. `"more"` moves items after `more_after` into a `More`
  dropdown. `"scroll"` allows horizontal scrolling.

- more_after:

  Number of top-level items to keep visible when `overflow = "more"`.
  Use `Inf` to disable moving items.

- title:

  How a centered
  [`dash_nav_title()`](https://PrigasG.github.io/bs4Dashkit/reference/dash_nav_title.md)
  behaves when top-nav tabs need space: `"auto"` (default) compacts then
  hides as needed, `"show"` always shows it, `"compact"` hides the
  subtitle, and `"hide"` hides it in top-nav mode. In
  `mobile = "scroll"`, `"auto"` hides the centered title earlier so the
  tab row has room; `"show"` is allowed but may crowd the scroll row.

- page_title:

  Optional content title synced from the active top-nav tab. Use
  `"none"` (default) to disable or `"tab"` to show the selected tab
  label above the content area.

- brand:

  Logical. If `TRUE` (default), the sidebar brand (icon + label) is
  mirrored into the navbar. Ignored when
  `bs4Dash::bs4DashSidebar(disable = TRUE)` already placed the brand in
  the navbar.

- debug:

  Logical. If `TRUE`, prints diagnostic messages to the browser console
  when the navbar or sidebar menu cannot be found.

## Value

A `shiny.tag.list` with the top-nav CSS/JS dependencies and the
initialization script. Include it once in `bs4DashBody(...)`.

## Details

Keep your app exactly as it is -
[`bs4DashSidebar()`](https://bs4dash.rinterface.com/reference/dashboardSidebar.html),
[`bs4SidebarMenu()`](https://bs4dash.rinterface.com/reference/dashboardSidebar.html),
[`bs4TabItems()`](https://bs4dash.rinterface.com/reference/dashboardBody.html) -
and add `use_dash_topnav()` (or
`use_bs4Dashkit_core(layout = "topnav")`) to the body. The sidebar stays
in the DOM as the single source of truth but is never shown.

Menu items with sub-items
([`bs4SidebarMenuSubItem()`](https://bs4dash.rinterface.com/reference/dashboardSidebar.html))
are rendered as navbar dropdowns. Menus rendered on the fly
([`renderMenu()`](https://bs4dash.rinterface.com/reference/renderMenu.html))
and updates via
[`updateTabItems()`](https://bs4dash.rinterface.com/reference/dashboardSidebar.html)
are picked up automatically.

On screens narrower than 992px the menu stays on one horizontally
scrollable row instead of collapsing into a hamburger.

## Examples

``` r
if (interactive()) {
  library(shiny)
  library(bs4Dash)

  ttl <- dash_titles(brand_text = "Top-nav demo", icon = icon("bolt"))

  ui <- bs4DashPage(
    title = ttl$app_name,
    header = bs4DashNavbar(title = ttl$brand),
    sidebar = bs4DashSidebar(
      bs4SidebarMenu(
        id = "sidebar",
        bs4SidebarMenuItem("Home", tabName = "home", icon = icon("house")),
        bs4SidebarMenuItem("Data", tabName = "data", icon = icon("table"))
      )
    ),
    body = bs4DashBody(
      use_bs4Dashkit_core(ttl, preset = "professional", layout = "topnav"),
      bs4TabItems(
        bs4TabItem(tabName = "home", "Home content"),
        bs4TabItem(tabName = "data", "Data content")
      )
    )
  )

  shinyApp(ui, function(input, output, session) {})
}
```
