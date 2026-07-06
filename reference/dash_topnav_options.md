# Top navigation options

Bundles the top-navigation settings used by
`use_bs4Dashkit_core(layout = "topnav")`. This keeps app setup compact
while preserving the same options accepted by
[`use_dash_topnav()`](https://PrigasG.github.io/bs4Dashkit/reference/use_dash_topnav.md).

## Usage

``` r
dash_topnav_options(
  align = c("left", "center", "right"),
  gap = 0,
  style = c("underline", "pill", "compact"),
  mobile = c("collapse", "scroll"),
  overflow = c("auto", "more", "scroll"),
  more_after = Inf,
  title = c("auto", "show", "compact", "hide"),
  page_title = c("none", "tab"),
  brand = TRUE,
  debug = FALSE
)
```

## Arguments

- align:

  Horizontal alignment of the mirrored menu inside the navbar: `"left"`
  (default), `"center"`, or `"right"`.

- gap:

  Space between mirrored top-nav items. Numeric values are treated as
  pixels; CSS lengths such as `"0.5rem"` are also accepted.

- style:

  Visual style for top-nav tabs: `"underline"` (default), `"pill"`, or
  `"compact"`.

- mobile:

  Mobile behavior: `"collapse"` (default) shows a hamburger that opens
  the mirrored tabs; `"scroll"` keeps tabs in one horizontally
  scrollable row.

- overflow:

  Desktop overflow behavior. `"auto"` (default) keeps the tab row
  intact. `"more"` moves items after `more_after` into a `More`
  dropdown. `"scroll"` allows horizontal scrolling.

- more_after:

  Number of top-level items to keep visible when `overflow = "more"`.
  Use `Inf` to disable moving items.

- title:

  How a centered
  [`dash_nav_title()`](https://PrigasG.github.io/bs4Dashkit/reference/dash_nav_title.md)
  behaves when top-nav tabs need space: `"auto"` (default) compacts then
  hides as needed, `"show"` always shows it, `"compact"` hides the
  subtitle, and `"hide"` hides it in top-nav mode. In
  `mobile = "scroll"`, `"auto"` hides the centered title earlier so the
  tab row has room; `"show"` is allowed but may crowd the scroll row.

- page_title:

  Optional content title synced from the active top-nav tab. Use
  `"none"` (default) to disable or `"tab"` to show the selected tab
  label above the content area.

- brand:

  Logical. If `TRUE` (default), the sidebar brand (icon + label) is
  mirrored into the navbar. Ignored when
  `bs4Dash::bs4DashSidebar(disable = TRUE)` already placed the brand in
  the navbar.

- debug:

  Logical. If `TRUE`, prints diagnostic messages to the browser console
  when the navbar or sidebar menu cannot be found.

## Value

A named list with class `bs4dashkit_topnav_options`.

## Examples

``` r
dash_topnav_options(
  align = "left",
  gap = 6,
  style = "compact",
  mobile = "collapse",
  overflow = "more",
  more_after = 4,
  title = "auto",
  page_title = "tab"
)
#> $align
#> [1] "left"
#> 
#> $gap
#> [1] "6px"
#> 
#> $style
#> [1] "compact"
#> 
#> $mobile
#> [1] "collapse"
#> 
#> $overflow
#> [1] "more"
#> 
#> $more_after
#> [1] 4
#> 
#> $title
#> [1] "auto"
#> 
#> $page_title
#> [1] "tab"
#> 
#> $brand
#> [1] TRUE
#> 
#> $debug
#> [1] FALSE
#> 
#> attr(,"class")
#> [1] "bs4dashkit_topnav_options"
```
