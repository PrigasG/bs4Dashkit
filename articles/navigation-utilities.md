# Navigation Utilities

``` r
library(bs4Dashkit)
```

`bs4Dashkit` provides a few navbar helpers designed for
[bs4Dash](https://github.com/RinteRface/bs4Dash). They return standard
Shiny UI (mostly
[`actionButton()`](https://rdrr.io/pkg/shiny/man/actionButton.html)
wrapped for navbar use) and are styled consistently with `btn-nav-pill`.

## `dash_nav_item()` — wrapping elements for the navbar

[bs4Dash](https://github.com/RinteRface/bs4Dash)’s navbar typically
expects items wrapped in a `<li class="nav-item">`.
[`dash_nav_item()`](https://PrigasG.github.io/bs4Dashkit/reference/dash_nav_item.md)
applies the wrapper (`<li class="nav-item dropdown"> ... </li>`) so you
can focus on the content.

``` r
rightUi = tagList(
  dash_nav_item(dash_nav_refresh_button("refresh")),
  dash_nav_item(dash_nav_help_button("help"))
)
```

If a component already returns a `<li>` (for example
[`dash_nav_title()`](https://PrigasG.github.io/bs4Dashkit/reference/dash_nav_title.md)),
you do not need to wrap it again.

------------------------------------------------------------------------

## Refresh button

Creates a pre-styled
[`actionButton()`](https://rdrr.io/pkg/shiny/man/actionButton.html)
intended for the navbar.

``` r
dash_nav_refresh_button("refresh")                      # default label + icon
dash_nav_refresh_button("refresh", label = "Reload")    # custom label
dash_nav_refresh_button("refresh", label = "")          # icon only
dash_nav_refresh_button("refresh", icon = "arrows-rotate")
```

**Server wiring:**

The most common behavior is a full app refresh:

``` r
observeEvent(input$refresh, {
  session$reload()
})
```

If you prefer a “soft refresh”, you can invalidate reactive chains
instead (for example, by updating a reactive counter). That pattern is
app-specific.

## Help button

Creates a pre-styled
[`actionButton()`](https://rdrr.io/pkg/shiny/man/actionButton.html)
intended to open help content.

``` r
dash_nav_help_button("help")                     # default label + icon
dash_nav_help_button("help", label = "Support")  # custom label
dash_nav_help_button("help", label = "")         # icon only
dash_nav_help_button("help", icon = "circle-info")
```

**Server wiring**

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

## `dash_nav_title()` — styled title block

Renders a title block with optional subtitle and icon, designed for use
in `leftUi` or `rightUi.`

``` r
dash_nav_title(
  title    = "DASHBOARDS",
  subtitle = "Critical & Main",
  icon     = icon("shield-halved"),
  align    = "center"                    # "center" | "left" | "right"
)
```

### Alignment patterns

**Centered** — title floats to the middle of the navbar regardless of
other items:

``` r
rightUi = tagList(
  dash_nav_title(
    "DASHBOARDS", "Critical & Main",
    icon  = icon("shield-halved"),
    align = "center"
  ),
  dash_nav_item(dash_nav_refresh_button("refresh")),
  dash_nav_item(dash_nav_help_button("help"))
)
```

**Right-aligned** — title sits after all other right items:

``` r
rightUi = tagList(
  dash_nav_item(dash_nav_refresh_button("refresh")),
  dash_nav_item(dash_nav_help_button("help")),
  dash_nav_title(
    "DASHBOARDS", "Critical & Main",
    icon  = icon("shield-halved"),
    align = "right"
  )
)
```

**Left-aligned** — title appears before other right items:

``` r
rightUi = tagList(
  dash_nav_title(
    "DASHBOARDS", "Critical & Main",
    icon  = icon("shield-halved"),
    align = "left"
  ),
  dash_nav_item(dash_nav_refresh_button("refresh")),
  dash_nav_item(dash_nav_help_button("help"))
)
```

## `dash_user_menu()` — user menu wrapper

[`dash_user_menu()`](https://PrigasG.github.io/bs4Dashkit/reference/dash_user_menu.md)
is a lightweight wrapper that ensures your dropdown menu is placed in
the correct navbar `<li>` container with a consistent class:

- `<li class="nav-item dropdown dash-user-menu"> ... </li>`

Because it already returns a `<li>`, **do not** wrap it in
[`dash_nav_item()`](https://PrigasG.github.io/bs4Dashkit/reference/dash_nav_item.md).

``` r
dash_user_menu(
  dropdownMenu(
    type = "notifications",
    notificationItem("Profile"),
    notificationItem("Logout")
  )
)
```

## Sign out patterns (no dedicated button)

`bs4Dashkit` does not ship a dedicated logout button. Most apps place
sign-out inside the user dropdown menu, which keeps the navbar clean.

### Option 1: “Logout” inside the dropdown menu

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
authentication framework you’re using. If you just want a simple
confirmation and reload:

``` r
# Example only: you control the real sign-out logic
observeEvent(input$logout, { ... })
```

## Full navbar example

``` r
bs4DashNavbar(
  title = ttl$brand,
  skin  = "light",
  rightUi = tagList(
    dash_nav_title(
      "DASHBOARDS",
      "Critical & Main",
      icon  = icon("shield-halved"),
      align = "center"
    ),
    dash_nav_item(dash_nav_refresh_button("refresh")),
    dash_nav_item(dash_nav_help_button("help")),
    dash_user_menu(
      dropdownMenu(
        type = "notifications",
        notificationItem("Profile"),
        notificationItem("Sign out")
      )
    )
  )
)
```

**Server:**

``` r
server <- function(input, output, session) {
  observeEvent(input$refresh, session$reload())

  observeEvent(input$help, {
    showModal(modalDialog("Help content.", easyClose = TRUE))
  })

  observeEvent(input$logout, {
    showModal(modalDialog(
      title  = "Sign out",
      "Are you sure?",
      footer = tagList(
        modalButton("Cancel"),
        actionButton("logout_confirm", "Sign out", class = "btn btn-danger")
      )
    ))
  })

  observeEvent(input$logout_confirm, {
    removeModal()
    session$reload()
  })
}
```
