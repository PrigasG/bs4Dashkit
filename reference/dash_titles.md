# Dashboard brand and sidebar configuration

Single entry point for branding and sidebar brand behavior. Creates a
reusable object you place into
[`bs4DashPage()`](https://bs4dash.rinterface.com/reference/dashboardPage.html),
[`bs4DashNavbar()`](https://bs4dash.rinterface.com/reference/dashboardHeader.html),
and
[`bs4DashBody()`](https://bs4dash.rinterface.com/reference/dashboardBody.html).

## Usage

``` r
dash_titles(
  brand_text,
  app_name = NULL,
  icon = NULL,
  icon_img = NULL,
  icon_shape = c("circle", "rounded", "square"),
  icon_size = NULL,
  icon_color = NULL,
  weight = 700,
  spacing = "-0.02em",
  size = NULL,
  italic = FALSE,
  font_family = NULL,
  color = NULL,
  gradient = NULL,
  effect = c("none", "glow", "shimmer", "emboss"),
  glow_color = NULL,
  collapsed = NULL,
  expanded = NULL,
  collapsed_text = NULL,
  expanded_text = NULL,
  collapsed_text_size = NULL,
  expanded_text_size = NULL,
  collapsed_text_weight = NULL,
  expanded_text_weight = NULL,
  brand_divider = NULL,
  debug = NULL
)
```

## Arguments

- brand_text:

  Visible brand label shown in the navbar/sidebar. May be `NULL` only
  when both sidebar modes are `"icon-only"` and an icon or image logo is
  supplied.

- app_name:

  Browser tab title. If `NULL`, defaults to `brand_text`, or
  `"bs4Dashkit"` when `brand_text` is empty.

- icon:

  Font Awesome icon name for the brand (for example `"project-diagram"`)
  or a simple `icon("project-diagram")` tag. Ignored when `icon_img` is
  supplied.

- icon_img:

  Path (www relative) or URL to an image logo. Overrides `icon`.

- icon_shape:

  Shape mask for image logos. One of `"circle"`, `"rounded"`,
  `"square"`.

- icon_size:

  CSS size for the icon/image (e.g. `"20px"`, `"1.2em"`).

- icon_color:

  CSS color for the Font Awesome icon. For image icons, a subtle tint
  may be applied.

- weight:

  CSS font-weight for the brand text.

- spacing:

  CSS letter-spacing for the brand text.

- size:

  CSS font-size for the brand text (e.g. `"14px"`).

- italic:

  Logical. If `TRUE`, renders brand text in italics.

- font_family:

  CSS font-family string (e.g. `"'Inter', sans-serif"`).

- color:

  Solid CSS text color for the brand label (ignored when `gradient` is
  set).

- gradient:

  Character vector of length 2 giving gradient colors for the brand
  label. When set, gradient styling is applied.

- effect:

  Visual effect for the brand label. One of `"none"`, `"glow"`,
  `"shimmer"`, `"emboss"`. If `gradient` is set, gradient styling is
  used.

- glow_color:

  Color used for glow/shimmer effects (when applicable).

- collapsed:

  Sidebar brand mode when the sidebar is collapsed. One of
  `"icon-only"`, `"icon-text"`, `"text-only"`. If `NULL`, uses option
  `bs4Dashkit.sidebar.collapsed`.

- expanded:

  Sidebar brand mode when the sidebar is expanded. One of `"icon-only"`,
  `"icon-text"`, `"text-only"`. If `NULL`, uses option
  `bs4Dashkit.sidebar.expanded`.

- collapsed_text:

  Short label used in collapsed mode (recommended \<= 8 chars).

- expanded_text:

  Label used in expanded mode (recommended \<= 30 chars).

- collapsed_text_size:

  Optional CSS font-size applied only to the sidebar brand label while
  collapsed (for example `"11px"` or `"0.75rem"`).

- expanded_text_size:

  Optional CSS font-size applied only to the sidebar brand label while
  expanded.

- collapsed_text_weight:

  Optional CSS font-weight applied only to the sidebar brand label while
  collapsed.

- expanded_text_weight:

  Optional CSS font-weight applied only to the sidebar brand label while
  expanded.

- brand_divider:

  Logical. If `TRUE`, shows a divider under the brand block. If `NULL`,
  uses option `bs4Dashkit.brand_divider`.

- debug:

  Logical. If `TRUE`, emits console warnings for missing icons, etc. If
  `NULL`, uses option `bs4Dashkit.debug`.

## Value

A named list with components:

- app_name:

  A character string for use in `bs4DashPage(title = ...)`.

- brand:

  A `shiny.tag` object for use in `bs4DashNavbar(title = ...)`. In a
  standard
  [`bs4DashPage()`](https://bs4dash.rinterface.com/reference/dashboardPage.html),
  the sidebar brand mirrors the navbar brand automatically.

- deps:

  A `shiny.tag.list` containing CSS and JavaScript dependencies to
  include once in `bs4DashBody(...)`.
