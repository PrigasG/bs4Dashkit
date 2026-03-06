# Navbar title (center, right, or left)

Creates a consistent title block for bs4Dash navbars, with optional
subtitle and icon. Alignment can be "center", "right", or "left".

## Usage

``` r
dash_nav_title(
  title,
  subtitle = NULL,
  icon = NULL,
  align = c("center", "right", "left")
)
```

## Arguments

- title:

  Main title (character or tag)

- subtitle:

  Optional subtitle (character or tag)

- icon:

  Optional fontawesome icon name, e.g. "shield-halved"

- align:

  One of c("center","right","left")

## Value

A `shiny.tag` object representing the navbar title UI.

## Details

IMPORTANT:

- align = "left" is intended to be placed in dashboardHeader(leftUi =
  ...)

- align = "right" is intended to be placed in dashboardHeader(rightUi =
  ...)

- align = "center" can be placed anywhere (it is positioned by CSS/JS)
