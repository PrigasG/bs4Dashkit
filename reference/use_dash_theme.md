# Apply a theme via CSS variables

Sets bs4Dashkit CSS custom properties (variables) for background,
surfaces, borders, text, and accent color.

## Usage

``` r
use_dash_theme(
  bg = "#f5f6f8",
  surface = "#ffffff",
  border = "#e2e3e7",
  text = "#1d1f23",
  muted = "#6b6f76",
  accent = "#2f6f8f",
  accent_soft = "#e8f1f5",
  navbar_bg = "#ffffff",
  navbar_text = "#1d1f23",
  sidebar_bg = "#ffffff",
  sidebar_text = "#1d1f23",
  sidebar_hover = "#eef4f7",
  footer_bg = "#ffffff",
  footer_text = "#6b6f76",
  success = "#2d8a56",
  warning = "#c37a14",
  danger = "#b94a48",
  radius = 12,
  shadow = "0 1px 3px rgba(0,0,0,0.07)"
)
```

## Arguments

- bg:

  Page background color.

- surface:

  Card and panel background color.

- border:

  Border color used on cards, separators, and outlines.

- text:

  Primary text color.

- muted:

  Muted text color.

- accent:

  Accent color used for highlights and emphasis.

- accent_soft:

  Softer accent tone used for subtle fills, hover states, and focus
  treatments.

- navbar_bg:

  Navbar background color.

- navbar_text:

  Navbar text color.

- sidebar_bg:

  Sidebar background color.

- sidebar_text:

  Sidebar text color.

- sidebar_hover:

  Sidebar hover and active background color.

- footer_bg:

  Footer background color.

- footer_text:

  Footer text color.

- success:

  Success accent color.

- warning:

  Warning accent color.

- danger:

  Danger accent color.

- radius:

  Corner radius in pixels.

- shadow:

  Box shadow CSS string used for cards and surfaces.

## Value

A `shiny.tag.list` containing stylesheet dependencies and inline CSS
variables for the app theme.
