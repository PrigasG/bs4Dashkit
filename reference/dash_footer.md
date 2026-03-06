# Standard footer for bs4Dash dashboards

Standard footer for bs4Dash dashboards

## Usage

``` r
dash_footer(
  logo_src = NULL,
  left_text = NULL,
  right_text = NULL,
  right_date = NULL,
  date_format = "%B %d, %Y",
  logo_height = 20,
  logo_position = c("left", "right"),
  fixed = TRUE
)
```

## Arguments

- logo_src:

  Path under `www/` or an external URL.

- left_text:

  Text rendered on the left side (optional).

- right_text:

  Text rendered on the right side (optional).

- right_date:

  Optional Date to render on the right. Ignored if `right_text` is set.

- date_format:

  Format used when `right_date` is provided.

- logo_height:

  Height in px for the logo image.

- logo_position:

  Where the logo should appear: "left" or "right".

- fixed:

  Logical. Fixed footer (TRUE/FALSE).

## Value

A `shiny.tag` object representing a `bs4DashFooter` UI component.
