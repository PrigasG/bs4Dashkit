# Set sidebar brand display mode for expanded and collapsed states

Controls icon visibility, text visibility, and text content in both
collapsed and expanded sidebar states.

## Usage

``` r
use_dash_sidebar_brand_mode(
  icon = NULL,
  collapsed = c("icon-only", "icon-text", "text-only"),
  expanded = c("icon-text", "icon-only", "text-only"),
  collapsed_text = NULL,
  expanded_text = NULL,
  collapsed_text_size = NULL,
  expanded_text_size = NULL,
  collapsed_text_weight = NULL,
  expanded_text_weight = NULL,
  debug = FALSE
)
```

## Arguments

- icon:

  Font Awesome icon name used in the brand, e.g. "shield-halved", or a
  simple `icon("shield-halved")` tag. Required when any mode includes
  "icon".

- collapsed:

  Display mode when sidebar is collapsed: "icon-only", "icon-text", or
  "text-only"

- expanded:

  Display mode when sidebar is expanded: "icon-text", "icon-only", or
  "text-only"

- collapsed_text:

  Short label for collapsed "icon-text" or "text-only" mode. Keep \<= 8
  chars. NULL falls back to the current brand label already present in
  the DOM. When using
  [`dash_titles()`](https://PrigasG.github.io/bs4Dashkit/reference/dash_titles.md),
  the higher-level helper usually resolves this to `brand_text` for
  visible text modes.

- expanded_text:

  Label for expanded "icon-text" or "text-only" mode. Keep \<= 30 chars.
  NULL falls back to the current brand label already present in the DOM.
  When using
  [`dash_titles()`](https://PrigasG.github.io/bs4Dashkit/reference/dash_titles.md),
  the higher-level helper usually resolves this to `brand_text` for
  visible text modes.

- collapsed_text_size:

  Optional CSS font-size applied to the sidebar brand label while
  collapsed.

- expanded_text_size:

  Optional CSS font-size applied to the sidebar brand label while
  expanded.

- collapsed_text_weight:

  Optional CSS font-weight applied to the sidebar brand label while
  collapsed.

- expanded_text_weight:

  Optional CSS font-weight applied to the sidebar brand label while
  expanded.

- debug:

  Logical. If `TRUE`, prints helpful messages to the browser console for
  diagnosing missing icons or brand label elements.

## Value

A `shiny.tag` or `shiny.tag.list` containing sidebar brand mode styling
or dependencies.

## Details

Modes:

- "icon-only" : icon shown, label hidden — requires `icon`

- "text-only" : label shown, icon hidden — `collapsed_text` /
  `expanded_text` optional

- "icon-text" : both shown — requires `icon`; text args optional
