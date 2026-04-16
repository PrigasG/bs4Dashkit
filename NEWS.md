---
editor_options: 
  markdown: 
    wrap: 72
---

## bs4Dashkit 0.2.0

### Ergonomics and discoverability

-   `dash_titles()` now accepts simple `shiny::icon()` inputs in
    addition to character icon names, and emits a more targeted error
    when `icon=` receives an unsupported object.

-   Added sidebar brand text controls for collapsed and expanded states:
    `collapsed_text_size`, `expanded_text_size`,
    `collapsed_text_weight`, and `expanded_text_weight`.

-   Added `bs4dashkit_theme_presets()` to list shipped theme presets and
    improved unknown-preset errors to enumerate valid choices.

-   Polished the built-in theme presets so they style navbar, sidebar,
    footer, link, and status colors more coherently, and extended
    `bs4dashkit_theme_presets(values = TRUE)` to expose the shipped
    preset tokens for inspection and customization.

-   Added `bs4dashkit_example_app()` as a minimal runnable example of the
    recommended `dash_titles()` + `use_bs4Dashkit_core()` workflow.

### Documentation and package polish

-   Updated README and vignettes to match the shipped API:

    -   removed references to the non-existent
        `dash_nav_logout_button()`

    -   aligned documentation with the current preset names
        `"professional"`, `"modern"`, and `"dark-lite"`

    -   clarified preset discoverability and the recommended body-level
        placement of `use_bs4Dashkit_core()`

### Testing

-   Expanded test coverage for:

    -   icon normalization in `dash_titles()`

    -   targeted validation errors for invalid icon objects

    -   collapsed and expanded sidebar brand text styling controls

    -   theme preset discovery and preset validation errors

    -   the exported minimal example app helper

## bs4Dashkit 0.1.0

### Initial release

-   Added `dash_titles()` as a unified constructor for brand and sidebar
    configuration. Returns `$app_name`, `$brand`, and `$deps` for
    placement in `bs4DashPage()`, `bs4DashNavbar()`, and
    `bs4DashBody()`.

-   Added `use_bs4Dashkit_core()` as the recommended entry point for
    injecting dependencies, applying a theme preset, and configuring
    sidebar behavior.

-   Added theme support via CSS custom properties:

    -   Presets: `"professional"`, `"modern"`, and `"dark-lite"`

    -   `use_dash_theme()` for direct CSS variable overrides

    -   `use_dash_theme_preset()` for applying named presets

    -   `bs4dashkit_theme_presets()` for inspecting available presets

-   Added configurable sidebar brand modes:

    -   "icon-only", `"icon-text"`, and `"text-only"`

    -   Independent configuration for collapsed and expanded states

-   Added use_dash_sidebar_behavior() for configurable collapsed width,
    expanded width, and topbar height.

-   Added `use_dash_sidebar_brand_divider()` for optional brand/menu
    separation.

-   Added brand visual effects (`"glow"`, `"shimmer"`, `"emboss"`) and
    two-color gradients via `dash_titles()`.

-   Added support for image-based brand icons via `icon_img` and
    `icon_shape`.

-   Added navbar utilities:

    -   `dash_nav_title()`

    -   `dash_nav_item()`

    -   `dash_nav_refresh_button()`

    -   `dash_nav_help_button()`

    -   `dash_user_menu()`

-   Added `dash_footer()`with independently positional logo and text
    elements.

-   Added global options:

    -   `bs4Dashkit.sidebar.collapsed`

    -   `bs4Dashkit.sidebar.expanded`

    -   `bs4Dashkit.brand_divider`

    -   `bs4Dashkit.theme_preset`

    -   `bs4Dashkit.accent`
