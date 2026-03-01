# Changelog

## bs4Dashkit 0.1.0

### Initial release

- Added
  [`dash_titles()`](https://PrigasG.github.io/bs4Dashkit/reference/dash_titles.md)
  as a unified constructor for brand and sidebar configuration. Returns
  `$app_name`, `$brand`, and `$deps` for placement in
  [`bs4DashPage()`](https://bs4dash.rinterface.com/reference/dashboardPage.html),
  [`bs4DashNavbar()`](https://bs4dash.rinterface.com/reference/dashboardHeader.html),
  and
  [`bs4DashBody()`](https://bs4dash.rinterface.com/reference/dashboardBody.html).

- Added
  [`use_bs4Dashkit_core()`](https://PrigasG.github.io/bs4Dashkit/reference/use_bs4Dashkit_core.md)
  as the recommended entry point for injecting dependencies, applying a
  theme preset, and configuring sidebar behavior.

- Added theme support via CSS custom properties:

  - Presets: `"professional"`, `"vibrant"`, and `"minimal"`

  - [`use_dash_theme()`](https://PrigasG.github.io/bs4Dashkit/reference/use_dash_theme.md)
    for direct CSS variable overrides

  - [`use_dash_theme_preset()`](https://PrigasG.github.io/bs4Dashkit/reference/use_dash_theme_preset.md)
    for applying named presets

  - `theme_presets()` for inspecting available presets

- Added configurable sidebar brand modes:

  - “icon-only”, `"icon-text"`, and `"text-only"`

  - Independent configuration for collapsed and expanded states

- Added use_dash_sidebar_behavior() for configurable collapsed width,
  expanded width, and topbar height.

- Added
  [`use_dash_sidebar_brand_divider()`](https://PrigasG.github.io/bs4Dashkit/reference/use_dash_sidebar_brand_divider.md)
  for optional brand/menu separation.

- Added brand visual effects (`"glow"`, `"shimmer"`, `"emboss"`) and
  two-color gradients via
  [`dash_titles()`](https://PrigasG.github.io/bs4Dashkit/reference/dash_titles.md).

- Added support for image-based brand icons via `icon_img` and
  `icon_shape`.

- Added navbar utilities:

  - [`dash_nav_title()`](https://PrigasG.github.io/bs4Dashkit/reference/dash_nav_title.md)

  - [`dash_nav_item()`](https://PrigasG.github.io/bs4Dashkit/reference/dash_nav_item.md)

  - [`dash_nav_refresh_button()`](https://PrigasG.github.io/bs4Dashkit/reference/dash_nav_refresh_button.md)

  - [`dash_nav_help_button()`](https://PrigasG.github.io/bs4Dashkit/reference/dash_nav_help_button.md)

  - [`dash_user_menu()`](https://PrigasG.github.io/bs4Dashkit/reference/dash_user_menu.md)

- Added
  [`dash_footer()`](https://PrigasG.github.io/bs4Dashkit/reference/dash_footer.md)with
  independently positional logo and text elements.

- Added global options:

  - `bs4Dashkit.sidebar.collapsed`

  - `bs4Dashkit.sidebar.expanded`

  - `bs4Dashkit.brand_divider`

  - `bs4Dashkit.theme_preset`

  - `bs4Dashkit.accent`
