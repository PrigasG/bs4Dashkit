# Navigation Utilities

``` r

library(bs4Dashkit)
```

`bs4Dashkit` provides navbar helpers designed for
[bs4Dash](https://github.com/RinteRface/bs4Dash). The complete item
helpers return valid direct children for `bs4DashNavbar(rightUi = ...)`,
while lower-level button helpers remain available for custom wrappers.

## Complete navbar items

Prefer these helpers for standard right-side navbar controls:

``` r

rightUi <- tagList(
  dash_nav_status_item("Ready", status = "success", icon = icon("circle-check")),
  dash_nav_refresh_item("refresh"),
  dash_nav_help_item("help")
)

validate_bs4dash_navbar(rightUi)
```

[`dash_nav_status_item()`](https://PrigasG.github.io/bs4Dashkit/reference/dash_nav_status_item.md),
[`dash_nav_refresh_item()`](https://PrigasG.github.io/bs4Dashkit/reference/dash_nav_refresh_item.md),
and
[`dash_nav_help_item()`](https://PrigasG.github.io/bs4Dashkit/reference/dash_nav_help_item.md)
all return the complete `<li class="nav-item dropdown">` structure
expected by bs4Dash/AdminLTE.

## `dash_nav_item()` - wrapping custom elements

Use
[`dash_nav_item()`](https://PrigasG.github.io/bs4Dashkit/reference/dash_nav_item.md)
for custom controls that do not already return a navbar `<li>`:

``` r

rightUi <- tagList(
  dash_nav_item(actionButton("custom", "Custom"))
)
```

If a component already returns a `<li>` (for example
[`dash_nav_title()`](https://PrigasG.github.io/bs4Dashkit/reference/dash_nav_title.md),
[`dash_nav_refresh_item()`](https://PrigasG.github.io/bs4Dashkit/reference/dash_nav_refresh_item.md),
[`dash_nav_help_item()`](https://PrigasG.github.io/bs4Dashkit/reference/dash_nav_help_item.md),
[`dash_nav_status_item()`](https://PrigasG.github.io/bs4Dashkit/reference/dash_nav_status_item.md),
or
[`dash_user_menu()`](https://PrigasG.github.io/bs4Dashkit/reference/dash_user_menu.md)),
do not wrap it again.

## Validate mixed navbar UI

When mixing custom and packaged components,
[`validate_bs4dash_navbar()`](https://PrigasG.github.io/bs4Dashkit/reference/validate_bs4dash_navbar.md)
catches common structural mistakes before bs4Dash emits a lower-level
error:

``` r

rightUi <- tagList(
  dash_nav_refresh_item("refresh"),
  tags$li(class = "nav-item", "Missing dropdown class")
)

validate_bs4dash_navbar(rightUi)
#> Error: Navbar item 2 is an <li> but is missing class "dropdown".
#> Wrap it with dash_nav_item().
```

## Refresh controls

[`dash_nav_refresh_item()`](https://PrigasG.github.io/bs4Dashkit/reference/dash_nav_refresh_item.md)
returns a complete navbar item. The lower-level
[`dash_nav_refresh_button()`](https://PrigasG.github.io/bs4Dashkit/reference/dash_nav_refresh_button.md)
returns only the styled
[`actionButton()`](https://rdrr.io/pkg/shiny/man/actionButton.html) when
you need custom structure.

``` r

dash_nav_refresh_item("refresh")                      # complete navbar item
dash_nav_refresh_item("refresh", label = "Reload")    # custom label
dash_nav_refresh_item("refresh", label = "")          # icon only
dash_nav_refresh_item("refresh", icon = "arrows-rotate")
```

The most common server behavior is a full app refresh:

``` r

observeEvent(input$refresh, {
  session$reload()
})
```

If you prefer a soft refresh, invalidate reactive chains instead. That
pattern is app-specific.

## Help controls

[`dash_nav_help_item()`](https://PrigasG.github.io/bs4Dashkit/reference/dash_nav_help_item.md)
returns a complete navbar item. The lower-level
[`dash_nav_help_button()`](https://PrigasG.github.io/bs4Dashkit/reference/dash_nav_help_button.md)
returns only the styled
[`actionButton()`](https://rdrr.io/pkg/shiny/man/actionButton.html).

``` r

dash_nav_help_item("help")                     # complete navbar item
dash_nav_help_item("help", label = "Support")  # custom label
dash_nav_help_item("help", label = "")         # icon only
dash_nav_help_item("help", icon = "circle-info")
```

A simple help modal:

``` r

observeEvent(input$help, {
  showModal(modalDialog(
    title     = "Help",
    "Add your instructions here.",
    easyClose = TRUE,
    footer    = modalButton("Close")
  ))
})
```

A more structured help modal:

``` r

observeEvent(input$help, {
  showModal(modalDialog(
    title = "Help & Documentation",
    tagList(
      h4("Getting started"),
      p("Describe the dashboard purpose here."),
      h4("Data sources"),
      p("Describe where data comes from."),
      h4("Contact"),
      p("Email: support@yourorg.gov")
    ),
    size      = "l",
    easyClose = TRUE,
    footer    = modalButton("Close")
  ))
})
```

## Status badge

Use
[`dash_nav_status_item()`](https://PrigasG.github.io/bs4Dashkit/reference/dash_nav_status_item.md)
for compact state indicators:

``` r

dash_nav_status_item("Ready", status = "success", icon = icon("circle-check"))
dash_nav_status_item("Syncing", status = "info", icon = icon("rotate"))
dash_nav_status_item("Review", status = "warning", icon = icon("triangle-exclamation"))
```

## `dash_nav_title()` - styled title block

Renders a title block with optional subtitle and icon, designed for use
in `leftUi` or `rightUi`.

``` r

dash_nav_title(
  title    = "DASHBOARDS",
  subtitle = "Critical & Main",
  icon     = icon("shield-halved"),
  align    = "center"                    # "center" | "left" | "right"
)
```

### Alignment patterns

Centered title:

``` r

rightUi <- tagList(
  dash_nav_title(
    "DASHBOARDS", "Critical & Main",
    icon  = icon("shield-halved"),
    align = "center"
  ),
  dash_nav_status_item("Ready", status = "success", icon = icon("circle-check")),
  dash_nav_refresh_item("refresh"),
  dash_nav_help_item("help")
)
```

Right-aligned title:

``` r

rightUi <- tagList(
  dash_nav_refresh_item("refresh"),
  dash_nav_help_item("help"),
  dash_nav_title(
    "DASHBOARDS", "Critical & Main",
    icon  = icon("shield-halved"),
    align = "right"
  )
)
```

Left-aligned title:

``` r

rightUi <- tagList(
  dash_nav_title(
    "DASHBOARDS", "Critical & Main",
    icon  = icon("shield-halved"),
    align = "left"
  ),
  dash_nav_refresh_item("refresh"),
  dash_nav_help_item("help")
)
```

## `dash_user_menu()` - user menu wrapper

[`dash_user_menu()`](https://PrigasG.github.io/bs4Dashkit/reference/dash_user_menu.md)
is a lightweight wrapper that ensures your dropdown menu is placed in
the correct navbar `<li>` container with a consistent class:

``` r

dash_user_menu(
  dropdownMenu(
    type = "notifications",
    notificationItem("Profile"),
    notificationItem("Logout")
  )
)
```

Because it already returns a `<li>`, do not wrap it in
[`dash_nav_item()`](https://PrigasG.github.io/bs4Dashkit/reference/dash_nav_item.md).

## Sign out patterns

`bs4Dashkit` does not ship a dedicated logout button. Most apps place
sign-out inside the user dropdown menu, which keeps the navbar clean.

``` r

dash_user_menu(
  dropdownMenu(
    type = "notifications",
    notificationItem("Profile"),
    notificationItem("Logout")
  )
)
```

Handle sign-out by listening to your own input or by using whatever
authentication framework your app uses.

## Full navbar example

``` r

rightUi <- tagList(
  dash_nav_title(
    "DASHBOARDS",
    "Critical & Main",
    icon  = icon("shield-halved"),
    align = "center"
  ),
  dash_nav_status_item("Ready", status = "success", icon = icon("circle-check")),
  dash_nav_refresh_item("refresh"),
  dash_nav_help_item("help"),
  dash_user_menu(
    dropdownMenu(
      type = "notifications",
      notificationItem("Profile"),
      notificationItem("Sign out")
    )
  )
)

validate_bs4dash_navbar(rightUi)

bs4DashNavbar(
  title = ttl$brand,
  skin  = "light",
  rightUi = rightUi
)
```

Server:

``` r

server <- function(input, output, session) {
  observeEvent(input$refresh, session$reload())

  observeEvent(input$help, {
    showModal(modalDialog("Help content.", easyClose = TRUE))
  })
}
```
