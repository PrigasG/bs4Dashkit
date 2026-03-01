---
editor_options: 
  markdown: 
    wrap: 72
---

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

    -   Presets: `"professional"`, `"vibrant"`, and `"minimal"`

    -   `use_dash_theme()` for direct CSS variable overrides

    -   `use_dash_theme_preset()` for applying named presets

    -   `theme_presets()` for inspecting available presets

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
