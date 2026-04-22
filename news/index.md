# Changelog

## bs4Dashkit 0.2.0

CRAN release: 2026-04-21

### Ergonomics and discoverability

- [`dash_titles()`](https://PrigasG.github.io/bs4Dashkit/reference/dash_titles.md)
  now accepts simple
  [`shiny::icon()`](https://rdrr.io/pkg/shiny/man/icon.html) inputs in
  addition to character icon names, and emits a more targeted error when
  `icon=` receives an unsupported object.

- Added sidebar brand text controls for collapsed and expanded states:
  `collapsed_text_size`, `expanded_text_size`, `collapsed_text_weight`,
  and `expanded_text_weight`.

- Added
  [`bs4dashkit_theme_presets()`](https://PrigasG.github.io/bs4Dashkit/reference/bs4dashkit_theme_presets.md)
  to list shipped theme presets and improved unknown-preset errors to
  enumerate valid choices.

- Polished the built-in theme presets so they style navbar, sidebar,
  footer, link, and status colors more coherently, and extended
  `bs4dashkit_theme_presets(values = TRUE)` to expose the shipped preset
  tokens for inspection and customization.

- Added
  [`bs4dashkit_example_app()`](https://PrigasG.github.io/bs4Dashkit/reference/bs4dashkit_example_app.md)
  as a minimal runnable example of the recommended
  [`dash_titles()`](https://PrigasG.github.io/bs4Dashkit/reference/dash_titles.md) +
  [`use_bs4Dashkit_core()`](https://PrigasG.github.io/bs4Dashkit/reference/use_bs4Dashkit_core.md)
  workflow.

- Added
  [`bs4dashkit_demo_app()`](https://PrigasG.github.io/bs4Dashkit/reference/bs4dashkit_demo_app.md)
  plus a packaged `inst/examples/real-shiny-app/app.R` example for
  interactively testing sidebar brand states, hover-expand behavior,
  presets, navbar controls, and footer styling together. The packaged
  example now contains the full standalone app code directly.

- Added `inst/examples/sidebar-smoke-test/app.R` as a minimal sidebar
  verification app and `inst/examples/test-all/app.R` as a heavier
  end-to-end stress test for branding, sidebar, navbar, theme, and
  footer features.

- Refined sidebar brand state handling so hover-expanded sidebars use
  the expanded text rules consistently, `brand_text` is treated as the
  default expanded label, and icon-requested states fall back more
  gracefully when no icon is supplied.

- Fixed reactive sidebar mode updates by clearing stale
  collapsed/expanded body classes before applying the current mode and
  cleaning up old observers and hover listeners before installing new
  ones.

- Fixed collapsed and expanded sidebar text sizing and weight controls
  so live updates consistently win over AdminLTE defaults, and centered
  the collapsed `"text-only"` label layout.

- Allowed `brand_text = NULL` for fully icon-only brands when both
  sidebar states are `"icon-only"` and an icon or image brand is
  supplied, with a browser-title fallback warning when `app_name` is
  omitted.

- Improved
  [`dash_nav_title()`](https://PrigasG.github.io/bs4Dashkit/reference/dash_nav_title.md)
  centering so the title stays visually centered as the viewport and
  surrounding navbar content change, and added left/center/right
  alignment controls to the interactive demo.

### Documentation and package polish

- Updated README and vignettes to match the shipped API:

  - removed references to the non-existent `dash_nav_logout_button()`

  - aligned documentation with the current preset names
    `"professional"`, `"modern"`, and `"dark-lite"`

  - clarified preset discoverability and the recommended body-level
    placement of
    [`use_bs4Dashkit_core()`](https://PrigasG.github.io/bs4Dashkit/reference/use_bs4Dashkit_core.md)

  - clarified how `brand_text`, `collapsed_text`, and `expanded_text`
    interact across collapsed, hover-expanded, and expanded sidebar
    states

  - documented the textless icon-only brand path, the automatic sidebar
    mirroring of `bs4DashNavbar(title = ttl$brand)`, and the shipped
    example apps for smoke testing and full feature testing

### Testing

- Expanded test coverage for:

  - icon normalization in
    [`dash_titles()`](https://PrigasG.github.io/bs4Dashkit/reference/dash_titles.md)

  - targeted validation errors for invalid icon objects

  - collapsed and expanded sidebar brand text styling controls

  - sidebar mode class resets and cleanup of reactive hover/state
    listeners

  - theme preset discovery and preset validation errors

  - the exported minimal example app helper

## bs4Dashkit 0.1.0

CRAN release: 2026-03-10

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

  - Presets: `"professional"`, `"modern"`, and `"dark-lite"`

  - [`use_dash_theme()`](https://PrigasG.github.io/bs4Dashkit/reference/use_dash_theme.md)
    for direct CSS variable overrides

  - [`use_dash_theme_preset()`](https://PrigasG.github.io/bs4Dashkit/reference/use_dash_theme_preset.md)
    for applying named presets

  - [`bs4dashkit_theme_presets()`](https://PrigasG.github.io/bs4Dashkit/reference/bs4dashkit_theme_presets.md)
    for inspecting available presets

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
