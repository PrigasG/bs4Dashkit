# Create sidebar / navbar brand UI

Produces an icon + text block for bs4Dash brand slots with rich styling
and optional visual effects. Supports Font Awesome icons or image logos.

## Usage

``` r
dash_brand_ui(
  brand_text,
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
  glow_color = NULL
)
```

## Arguments

- brand_text:

  Visible brand label (character). May be `NULL` for icon-only brands.

- icon:

  Font Awesome icon name e.g. "shield-halved", or a simple
  `icon("shield-halved")` tag. NULL for none.

- icon_img:

  URL or www-relative path to an image logo. Overrides `icon` when both
  are supplied.

- icon_shape:

  Shape mask for image icons: "circle", "rounded", "square". Ignored for
  FA icons. Default "circle".

- icon_size:

  Size of icon/image as CSS string e.g. "20px", "1.3em". NULL = inherits
  sidebar default.

- icon_color:

  CSS color for FA icon e.g. "#2f6f8f". NULL = inherit. For image icons,
  applies a CSS tint via mix-blend-mode (subtle).

- weight:

  CSS font-weight: numeric or keyword. Default 700.

- spacing:

  CSS letter-spacing. Default "-0.02em".

- size:

  CSS font-size for label e.g. "13px". NULL = inherit.

- italic:

  Logical. Italicise the label. Default FALSE.

- font_family:

  CSS font-family string e.g. "'Inter', sans-serif".

- color:

  Solid CSS color for label text. NULL = inherit. Ignored when
  `gradient` is set.

- gradient:

  Character vector of 2 hex colors for gradient text effect e.g.
  c("#2f6f8f", "#5ba3c9"). Automatically enables effect = "gradient".

- effect:

  Visual effect on label: "none", "glow", "shimmer", "emboss".
  "gradient" is set automatically when `gradient` is supplied.

- glow_color:

  CSS color for glow effect. Defaults to first gradient color or `color`
  or the package accent blue.

## Value

A named list with components:

- ui:

  A `shiny.tag.list` containing the generated brand UI.

- dep:

  A `shiny.tag` object containing scoped CSS dependencies for the brand
  styling.
