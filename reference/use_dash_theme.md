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

- radius:

  Corner radius in pixels.

- shadow:

  Box shadow CSS string used for cards and surfaces.

## Value

A
[`shiny::tagList()`](https://rstudio.github.io/htmltools/reference/tagList.html)
that injects CSS variables into the page `<head>`.
