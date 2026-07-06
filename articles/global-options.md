# Global Options

``` r

library(bs4Dashkit)
```

`bs4Dashkit` reads a small set of
[`options()`](https://rdrr.io/r/base/options.html) so you can establish
project-wide defaults without repeating the same arguments in every app.

Options are only used when the corresponding argument is not provided
(or is `NULL`).

------------------------------------------------------------------------

## Available options

| Option | Used by | Purpose | Default |
|----|----|----|----|
| `bs4Dashkit.sidebar.collapsed` | [`dash_titles()`](https://PrigasG.github.io/bs4Dashkit/reference/dash_titles.md) | Sidebar brand mode when collapsed | `"icon-only"` when an icon is supplied, otherwise `"text-only"` |
| `bs4Dashkit.sidebar.expanded` | [`dash_titles()`](https://PrigasG.github.io/bs4Dashkit/reference/dash_titles.md) | Sidebar brand mode when expanded | `"icon-text"` when an icon is supplied, otherwise `"text-only"` |
| `bs4Dashkit.brand_divider` | [`dash_titles()`](https://PrigasG.github.io/bs4Dashkit/reference/dash_titles.md) | Show divider under brand strip | `TRUE` |
| `bs4Dashkit.theme_preset` | [`use_bs4Dashkit_core()`](https://PrigasG.github.io/bs4Dashkit/reference/use_bs4Dashkit_core.md) | Default preset name when `preset = NULL` | `NULL` |
| `bs4Dashkit.accent` | [`use_bs4Dashkit_core()`](https://PrigasG.github.io/bs4Dashkit/reference/use_bs4Dashkit_core.md) | Default accent when `accent = NULL` | `"#2f6f8f"` |
| `bs4Dashkit.debug` | [`dash_titles()`](https://PrigasG.github.io/bs4Dashkit/reference/dash_titles.md) | Enable debug logging (JS console warnings) | `FALSE` |

The values shown above are the built-in defaults used when neither the
function argument nor the corresponding option is set.
[`dashkit_opt()`](https://PrigasG.github.io/bs4Dashkit/reference/dashkit_opt.md)
simply retrieves `getOption("bs4Dashkit.<name>")` with a fallback
default supplied by the calling function.

## Notes:

For sidebar modes, valid values are “icon-only”, “icon-text”, and
“text-only”.

- If `bs4Dashkit.theme_preset` is `NULL`,
  [`use_bs4Dashkit_core()`](https://PrigasG.github.io/bs4Dashkit/reference/use_bs4Dashkit_core.md)
  uses
  [`use_dash_theme()`](https://PrigasG.github.io/bs4Dashkit/reference/use_dash_theme.md).
- If a preset is set, it uses
  [`use_dash_theme_preset()`](https://PrigasG.github.io/bs4Dashkit/reference/use_dash_theme_preset.md).

------------------------------------------------------------------------

## Setting options

Place these in `global.R` (for Shiny applications) or at the top or your
`app.R`:

``` r

options(
  bs4Dashkit.sidebar.collapsed = "icon-only",
  bs4Dashkit.sidebar.expanded  = "icon-text",
  bs4Dashkit.brand_divider     = TRUE,
  bs4Dashkit.theme_preset      = "professional",
  bs4Dashkit.accent            = "#2f6f8f",
  bs4Dashkit.debug             = FALSE
)
```

After setting these, you can keep individual calls short:

``` r

ttl <- dash_titles(
  brand_text = "Dashboard",
  icon       = icon("project-diagram")
)

ui <- bs4DashPage(
  title  = ttl$app_name,
  header = bs4DashNavbar(title = ttl$brand),
  sidebar = bs4DashSidebar(),
  body = bs4DashBody(
    use_bs4Dashkit_core(ttl)
  )
)
```

------------------------------------------------------------------------

## Per-app overrides

Options are just defaults. Any app can override them by supplying
arguments.

``` r

ttl <- dash_titles(
  brand_text     = "Special App",
  icon           = icon("star"),
  collapsed      = "icon-text",
  collapsed_text = "SAP",
  brand_divider  = FALSE
)

body <- bs4DashBody(
  use_bs4Dashkit_core(ttl, preset = "modern", accent = "#6b2f8f")
)
```

------------------------------------------------------------------------

## Checking current options

``` r

getOption("bs4Dashkit.sidebar.collapsed")
getOption("bs4Dashkit.sidebar.expanded")
getOption("bs4Dashkit.brand_divider")
getOption("bs4Dashkit.theme_preset")
getOption("bs4Dashkit.accent")
getOption("bs4Dashkit.debug")
```

------------------------------------------------------------------------

## Resetting to built-in defaults

``` r

options(
  bs4Dashkit.sidebar.collapsed = NULL,
  bs4Dashkit.sidebar.expanded  = NULL,
  bs4Dashkit.brand_divider     = NULL,
  bs4Dashkit.theme_preset      = NULL,
  bs4Dashkit.accent            = NULL,
  bs4Dashkit.debug             = NULL
)
```
